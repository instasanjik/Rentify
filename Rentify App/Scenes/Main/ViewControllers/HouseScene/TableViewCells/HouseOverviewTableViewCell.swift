//
//  HouseOverviewTableViewCell.swift
//  Rentify App
//
//  Created by Sanzhar Koshkarbayev on 25.04.2023.
//

import UIKit
import Cosmos

class Landlord {
    var id = "19230"
    var name = "Yeren"
    var surname = "Kalibek"
    var avatarLink = "https://images.pexels.com/photos/936019/pexels-photo-936019.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"
    var rating: Double = 4.5
    var offersCount = 192
    var email: String = "yeren.kalibek@gmail.com"
    var phoneNumber: String = "77479107281"
    
    init(id: String,
         name: String,
         surname: String,
         avatarLink: String,
         rating: Double,
         offersCount: Int,
         email: String,
         phoneNumber: String) {
        self.id = id
        self.name = name
        self.surname = surname
        self.avatarLink = avatarLink
        self.rating = rating
        self.offersCount = offersCount
        self.email = email
        self.phoneNumber = phoneNumber
    }
}

class HouseOverviewTableViewCell: UITableViewCell {
    
    @IBOutlet weak var callButton: UIButton!
    
    @IBOutlet weak var landlordAvatarImageView: UIImageView!
    @IBOutlet weak var landlordNameLabel: UILabel!
    @IBOutlet weak var offerCountLabel: UILabel!
    @IBOutlet weak var ratingLabel: CosmosView!
    @IBOutlet weak var overViewLabel: UILabel!
    
    var landlord: Landlord?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupData(landlord: Landlord, overview: String) {
        self.landlord = landlord
        landlordNameLabel.text = "\(landlord.name) \(landlord.surname)"
        if let url = URL(string: landlord.avatarLink) {
            landlordAvatarImageView.kf.setImage(with: url)
        }
        offerCountLabel.text = "\(landlord.offersCount) offers"
        ratingLabel.rating = landlord.rating
        overViewLabel.text = overview
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func callButtonTapped(_ sender: Any) {
        guard let landlord = landlord else { return }
        if let url = URL(string: "tel://\(landlord.phoneNumber)") {
             UIApplication.shared.open(url)
        }
    }
    
    @IBAction func mailButtonTapped(_ sender: Any) {
        guard let landlord = landlord else { return }
        if let url = URL(string: "mailto:\(landlord.email)") {
            UIApplication.shared.open(url)  
        }
    }
}
