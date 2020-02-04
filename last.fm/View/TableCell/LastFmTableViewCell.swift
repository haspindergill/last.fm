//
//  LastFmTableViewCell.swift
//  last.fm
//
//  Created by Haspinder on 2020-02-03.
//  Copyright © 2020 Haspinder. All rights reserved.
//

import UIKit
import SwiftyJSON

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
        lblTitle?.text = artist?.name
        lblDetail?.text = (artist?.listeners ?? "0") + " listeners"
        img?.downloadImageFrom(link: artist?.image?[3].link ?? "", contentMode: UIView.ContentMode.scaleAspectFit)
    }
    var data : Artist?{didSet{
            self.updateCellUI()
            }}
        
      //Update UI when new value present in player variable
        func updateCellUI() {
            lblTitle?.text = data?.name
            lblDetail?.text = data?.artist
            img.image = UIImage(named: "placeholder")
            img?.downloadImageFrom(link: data?.image?[3].link ?? "", contentMode: UIView.ContentMode.scaleAspectFit)
        }

}
