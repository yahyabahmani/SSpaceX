//
//  DetailsSelectTableViewCell.swift
//  SSpaceX
//
//  Created by Jabama on 6/28/23.
//

import UIKit

class DetailsSelectTableViewCell: UITableViewCell {
    @IBOutlet weak var wikipedia: UIButton!
    private var url = ""
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    @IBAction func wikipediaPressed(_ sender: Any) {
        if let url = URL(string: self.url), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
    func fillData(url:String){
        self.url = url
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
