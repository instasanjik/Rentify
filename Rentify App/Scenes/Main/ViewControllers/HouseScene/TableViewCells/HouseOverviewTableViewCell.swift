//
//  HouseOverviewTableViewCell.swift
//  Rentify App
//
//  Created by Sanzhar Koshkarbayev on 25.04.2023.
//

import UIKit

class Landlord {
    var id = ""
    var name = ""
    var surname = ""
    var avatarLink = ""
    var rating = 0
    var offersCount = 0

}

class HouseOverviewTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupData(landlord: Landlord, overview: String) {
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
