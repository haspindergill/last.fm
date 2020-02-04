//
//  TableViewDataSource.swift
//  last.fm
//
//  Created by Haspinder on 2020-02-03.
//  Copyright © 2020 Haspinder. All rights reserved.
//

import Foundation
import UIKit


typealias  ListCellConfigureBlock = (_ cell : AnyObject , _ item : AnyObject? , _ indexPath : IndexPath?) -> ()
typealias  DidSelectedRow = (_ indexPath : IndexPath) -> ()
typealias  DidReachLastCell = (_ indexPath : IndexPath) -> ()


class TableDataSource: NSObject {
    
    
    var items : Array<AnyObject>?
    var cellIdentifier : String?
    var tableView  : UITableView?
    var tableViewRowHeight : CGFloat = 44.0
    var configureCellBlock : ListCellConfigureBlock?
    var aRowSelectedListener : DidSelectedRow?
    var loadMoreListener : DidReachLastCell?
    
    init (items : Array<AnyObject>? , height : CGFloat , tableView : UITableView? , cellIdentifier : String?  , configureCellBlock : ListCellConfigureBlock? , aRowSelectedListener : @escaping DidSelectedRow, lastIndexReached:@escaping DidReachLastCell) {
        
        self.tableView = tableView
        
        self.items = items
        
        self.cellIdentifier = cellIdentifier
        
        self.tableViewRowHeight = height
        
        self.configureCellBlock = configureCellBlock
        
        self.aRowSelectedListener = aRowSelectedListener
        
        self.loadMoreListener = lastIndexReached
        
    }
    
    
    override init() {
        
        super.init()
        
    }
    
}



extension TableDataSource : UITableViewDelegate , UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0{
        guard let identifier = cellIdentifier else{
            fatalError("Cell identifier not provided")
        }
        
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: identifier , for: indexPath) as UITableViewCell
        if let block = self.configureCellBlock , let item: AnyObject = self.items?[indexPath.row]{
            block(cell , item ,indexPath)
        }
        
            return cell}else{
            
            return tableView.dequeueReusableCell(withIdentifier: "LoadMoreTableViewCell" , for: indexPath) as UITableViewCell
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let block = self.aRowSelectedListener{
            block(indexPath)
        }
        self.tableView?.deselectRow(at: indexPath, animated: true)
    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 { return self.items?.count ?? 0} else{return 1}
    }
    
    
    
    internal func numberOfSections(in tableView: UITableView) -> Int {
        if((self.items?.count ?? 0) >= Int(APIConstants.SearchLimit) ?? 20){return 2}else{return 1}
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.tableViewRowHeight
}
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if (indexPath.section == 1){
            if let block = self.loadMoreListener{
                       block(indexPath)
                   }        }
    }
       

}
