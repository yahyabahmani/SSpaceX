//
//  DetailsTextTableViewCell.swift
//  SSpaceX
//
//  Created by yahya on 6/28/23.
//

import UIKit

class DetailsTextTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.titleLabel.numberOfLines = 0
        // Initialization code
    }
    func fillData(txt:String){
        self.titleLabel.text = txt
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
