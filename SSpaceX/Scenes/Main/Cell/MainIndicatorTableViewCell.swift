//
//  MainIndicatorTableViewCell.swift
//  SSpaceX
//
//  Created by Jabama on 6/28/23.
//

import UIKit

class MainIndicatorTableViewCell: UITableViewCell {
    @IBOutlet weak var indicator: UIActivityIndicatorView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        indicator.startAnimating()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
