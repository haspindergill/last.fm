//
//  LastFmTableViewCell.swift
//  last.fm
//
//  Created by Haspinder on 2020-02-03.
//  Copyright © 2020 Haspinder. All rights reserved.
//

import UIKit
import SwiftyJSON
import Imaginary

class LastFmTableViewCell: UITableViewCell {

    @IBOutlet weak var img: UIImageView!
       @IBOutlet weak var lblTitle: UILabel!
       @IBOutlet weak var lblDetail: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var artist : Artist?{didSet{
               self.updateArtistCellUI()
               }}
    
    func updateArtistCellUI() {
    lblDetail?.text = (artist?.listeners ?? "0") + " listeners"
    lblTitle?.text = artist?.name
        img?.image = UIImage(named: "placeholder")
        guard let imageUrl = URL(string:artist?.image?[3].link ?? ""),(artist?.image?[3].link?.count ?? 0  > 0) else {return}
        setImage(url: imageUrl)
    }
    
    func setImage(url : URL) {
        let option = Option()
        img?.setImage(url: url, placeholder: UIImage(named: "placeholder"), option: option) { (response) in}
    }

    
    
    var data : Artist?{didSet{
            self.updateCellUI()
            }}
        
      //Update UI when new value present in player variable
        func updateCellUI() {
            lblTitle?.text = data?.name
            lblDetail?.text = data?.artist
            img?.image = UIImage(named: "placeholder")
            guard let imageUrl = URL(string:data?.image?[3].link ?? ""), (data?.image?[3].link?.count ?? 0  > 0) else {
                                  return
                              }
            setImage(url: imageUrl)
                            }

}
