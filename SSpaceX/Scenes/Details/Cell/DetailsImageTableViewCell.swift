//
//  DetailsImageTableViewCell.swift
//  SSpaceX
//
//  Created by Jabama on 6/28/23.
//

import UIKit

class DetailsImageTableViewCell: UITableViewCell {
    @IBOutlet weak var bannerImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func fillData(img:String){
        bannerImageView.loadImage(from: img)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
