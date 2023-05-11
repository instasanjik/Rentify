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
    
    @IBOutlet weak var callButton: UIButton!
    
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
    
    @IBAction func callButtonTapped(_ sender: Any) {
        if let url = URL(string: "tel://77479881965") {
             UIApplication.shared.open(url)
        }
    }
    
    @IBAction func mailButtonTapped(_ sender: Any) {
        let email = "koshkarbayev.07@gmail.com"
        if let url = URL(string: "mailto:\(email)") {
            UIApplication.shared.open(url)  
        }
    }
}
