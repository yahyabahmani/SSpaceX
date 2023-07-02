//
//  MainTableViewCell.swift
//  SSpaceX
//
//  Created by yahya on 6/28/23.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    @IBOutlet weak var flightNumber: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var flightImageView: UIImageView!
    
    
    @IBOutlet weak var checkMarckImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func fillData(model:MissionModel){
        self.flightNumber.text = "\(model.flightNumber ?? "")"
        self.dateLabel.text = model.dateUTC
        if model.success  ?? false{
            self.checkMarckImageView.image =  UIImage(systemName: "checkmark.square")
            self.checkMarckImageView.tintColor = UIColor.green
        }else{
            self.checkMarckImageView.image = UIImage(systemName: "xmark.app")
            self.checkMarckImageView.tintColor = UIColor.red
        }
        if let url = model.smallPatch  {
            flightImageView.loadImage(from: url)
        }
    }
    
}
