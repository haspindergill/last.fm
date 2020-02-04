//
//  ViewController.swift
//  last.fm
//
//  Created by Haspinder on 2020-02-03.
//  Copyright © 2020 Haspinder. All rights reserved.
//

import UIKit
import SwiftyJSON

enum Searchtype{
    case Artist
    case Track
    case Album
}

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!{didSet{
          tableView.estimatedRowHeight = 100}}
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    var activeType : Searchtype = .Track
    
    // Assign tableView Delegate methods to TableDataSource
      var dataSource : TableDataSource?{
          didSet{
              tableView.delegate = dataSource
              tableView.dataSource = dataSource
          }
      }
    
    var items = [AnyObject](){didSet{
        dataSource?.items = items as Array<AnyObject>
        DispatchQueue.main.async {
        self.tableView?.reloadData()}
          }}
    
    var artistItems = [Artist]()
    var artistData : Result?
    var albumData : Result?
    var albumItems = [Artist]()
    var trackItems = [Artist]()
    var trackData : Result?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        }
    
}




//MARK: TableView
extension ViewController{
    
    //init the datasource class
    func setupTableView() {
        dataSource = TableDataSource(items: items as Array<AnyObject>, height: UITableView.automaticDimension, tableView: tableView, cellIdentifier: "LastFmTableViewCell", configureCellBlock: { (cell, item, index) in
            self.configureTableCell(cell: cell, item: item,index: index)
        }, aRowSelectedListener: { (indexPath) in
            self.clickHandler(indexPath: indexPath)
           
        }, lastIndexReached:{(IndexPath) in
            self.callLoadMore()
            } )
    }
    
    func clickHandler(indexPath : IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ContainerViewController") as? ContainerViewController
            vc?.items = self.items as! [Artist]
            vc?.startPosition = indexPath.row
            vc?.category = self.activeType
            self.navigationController?.pushViewController(vc ?? UIViewController(), animated: true)
    }
    
    
    
    func configureTableCell(cell : AnyObject?,item : AnyObject?,index : IndexPath?) {
        let cell = cell as? LastFmTableViewCell
        switch activeType {
        case .Artist:
            cell?.artist = item as? Artist
        default:
            cell?.data = item as? Artist
        }
    }
    
    
    
    
    func callLoadMore() {
        switch self.activeType{
        case.Album:
            self.callSearchApi(withText: (self.albumData?.SearchAttributes ?? ""), type: .Album, pageNumber: (self.albumData?.currentPage ?? 0) + 1, paging: true)
        case.Track:
            self.callSearchApi(withText: (self.searchBar?.text ?? ""), type: .Track, pageNumber: (self.trackData?.currentPage ?? 0) + 1, paging: true)
        case.Artist:
            self.callSearchApi(withText: (self.artistData?.SearchAttributes ?? ""), type: .Artist, pageNumber: (self.artistData?.currentPage ?? 0) + 1, paging: true)
        }
    }
}

// MARK: - SegmentedControl Bar Actions

extension ViewController{
    @IBAction func valueChanged(segmentedControl: UISegmentedControl) {
    switch segmentedControl.selectedSegmentIndex {
    case 0:
        activeType = .Track
        items = trackItems
        case 1:
        activeType = .Artist
        items = artistItems
        case 2:
        activeType = .Album
        items = albumItems
    default:
        activeType = .Track
    }
     }
}



// MARK: - Search Bar Delegate Methods

extension ViewController : UISearchBarDelegate{
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        self.tableView.alpha = 1.0
               self.tableView.isUserInteractionEnabled = true
    }
    
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if(searchText.count > 0){
            self.callSearchApi(withText: searchText, type: .Album, pageNumber: 1, paging: false)
            self.callSearchApi(withText: searchText, type: .Track, pageNumber: 1, paging: false)
            self.callSearchApi(withText: searchText, type: .Artist, pageNumber: 1, paging: false)
}

    }
    public func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.tableView.alpha = 0.5
        self.tableView.isUserInteractionEnabled = false
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        self.tableView.alpha = 1.0
        self.tableView.isUserInteractionEnabled = true
    }
}


// MARK: - SearchEngine - API's

extension ViewController{
    
    // Call  API
    func callSearchApi(withText text:String, type:Searchtype,pageNumber:Int,paging:Bool) {
        APIManager.init().opertationWithRequest(withApi: API.Search(search: text, type: type,pageNumber: String(pageNumber))) { (response) in
                switch response{
                case .Failure(let error):
                    print(error ?? "")
                case .Success(let data):
                    guard let data = data as? Result else {
                        return
                    }
                   switch type {
                    case .Album:
                        self.albumData = data
                        if paging{
                            self.albumItems.append(contentsOf: self.albumData?.albums ?? [] )
                            }else{
                            self.albumItems = self.albumData?.albums ?? []}
                    case .Artist:
                        self.artistData = data
                        if paging{
                            self.artistItems.append(contentsOf: self.artistData?.artists ?? [] )
                            }else{
                            self.artistItems = self.artistData?.artists ?? []}
                   case .Track:
                        self.trackData = data

                        if paging{
                        self.trackItems.append(contentsOf: self.trackData?.tracks ?? [] )
                        }else{
                        self.trackItems = self.trackData?.tracks ?? []}
                    }
                    if (self.activeType == .Album && type == .Album){
                            self.items = self.albumItems
                    }else if(self.activeType == .Track && type == .Track){
                        self.items = self.trackItems
                    }else if(self.activeType == .Artist && type == .Artist){
                       self.items = self.artistItems
                    }
        
                }
            }

        }
}




