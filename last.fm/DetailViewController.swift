//
//  DetailViewController.swift
//  last.fm
//
//  Created by Haspinder on 2020-02-03.
//  Copyright © 2020 Haspinder. All rights reserved.
//

import UIKit
import Imaginary

class DetailViewController: UIViewController {

    var category: Searchtype = .Track
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var subText: UILabel!
    @IBOutlet weak var deatilText: UILabel!
    @IBOutlet weak var urlText: UITextView!
    @IBOutlet weak var artworkImage: UIImageView!
    
    
    var data : Artist?
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let data = data else {
            return
        }
        name.text = data.name
        switch category {
        case .Artist:
            subText.text = (data.listeners ?? "") + " listeners"
        default:
            subText.text = data.artist
        }
        urlText.text = data.url
        deatilText.text = (data.streamable ?? "") + " Steamable"
        let option = Option()
        guard let imageUrl = URL(string:data.image?[3].link ?? "") else {
                             return
                         }
        artworkImage?.setImage(url: imageUrl, placeholder: UIImage(named: "placeholder"), option: option) { (response) in
                   }
    }

}
