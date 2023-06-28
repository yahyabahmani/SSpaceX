//
//  MainTableViewCell.swift
//  SSpaceX
//
//  Created by Jabama on 6/28/23.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    @IBOutlet weak var flightNumber: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var flightImageView: UIImageView!

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

        if let url = model.smallPatch  {
            flightImageView.loadImage(from: url)
        }
    }
    
}
