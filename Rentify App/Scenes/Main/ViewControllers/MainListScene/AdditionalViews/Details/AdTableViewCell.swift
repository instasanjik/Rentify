//
//  AdTableViewCell.swift
//  Rentify App
//
//  Created by Sanzhar Koshkarbayev on 22.04.2023.
//

import UIKit
import Kingfisher

class AdTableViewCell: UITableViewCell {
    
    @IBOutlet weak var houseImageView: UIImageView!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    @IBOutlet weak var numberOfBedsLabel: UILabel!
    @IBOutlet weak var numberOfBathRoomsLabel: UILabel!
    @IBOutlet weak var totalAreaLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func setupData(ad: Ad) {
        if let url = URL(string: ad.previewImageLink) {
            houseImageView.kf.setImage(with: url)
        }
        priceLabel.text = "$\(ad.price)/mo"
        typeLabel.text = ad.type
        addressLabel.text = ad.address
        numberOfBedsLabel.text = ad.numberOfBedrooms
        numberOfBathRoomsLabel.text = ad.numberOfBathRooms
        totalAreaLabel.text = "\(ad.area)sqft"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
