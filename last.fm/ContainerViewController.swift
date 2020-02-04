//
//  ContainerViewController.swift
//  last.fm
//
//  Created by Haspinder on 2020-02-04.
//  Copyright © 2020 Haspinder. All rights reserved.
//

import UIKit
import PagingKit

class ContainerViewController: UIViewController {

    @IBAction func close(_ sender: Any) {

        self.navigationController?.popViewController(animated: true)
    }
    var menuViewController: PagingMenuViewController?
    var contentViewController: PagingContentViewController?
    
    var dataSource = [(menu: String, content: UIViewController)]()

    var startPosition : Int?
    var items = [Artist]()
    var category : Searchtype?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = (0..<items.count).map {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController
            vc?.data = items[$0]
            vc?.category = category ?? .Track
            return (menu: "\($0)", content: (vc ?? UIViewController()))
        }
        self.contentViewController?.reloadData(with: self.startPosition ?? 0)

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
          if let vc = segue.destination as? PagingContentViewController {
              contentViewController = vc
              contentViewController?.delegate = self
              contentViewController?.dataSource = self
          }
      }

}

extension ContainerViewController: PagingContentViewControllerDataSource {
    func numberOfItemsForContentViewController(viewController: PagingContentViewController) -> Int {
        return dataSource.count
    }
    
    func contentViewController(viewController: PagingContentViewController, viewControllerAt index: Int) -> UIViewController {
        return dataSource[index].content
    }
}


extension ContainerViewController: PagingContentViewControllerDelegate {
    func contentViewController(viewController: PagingContentViewController, didManualScrollOn index: Int, percent: CGFloat) {
    }
}
