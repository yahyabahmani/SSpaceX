//
//  DetailsImageTableViewCell.swift
//  SSpaceX
//
//  Created by Jabama on 6/28/23.
//

import UIKit
protocol DetailsImageTableViewCellDelegate:NSObjectProtocol{
    func bookmarkSelect()
}
class DetailsImageTableViewCell: UITableViewCell {
    @IBOutlet weak var bookMarkButton: UIButton!
    @IBOutlet weak var bannerImageView: UIImageView!
    weak var  delegate:DetailsImageTableViewCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func fillData(img:String,id:String){
        bannerImageView.loadImage(from: img)
        self.bookMarkButton.setImage(UIImage(systemName:id), for: .normal)
      
    }

    
    
    @IBAction func bookmarkSelect(_ sender: Any) {
        self.delegate?.bookmarkSelect()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
