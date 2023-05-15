//
//  HousePriceTableViewCell.swift
//  Rentify App
//
//  Created by Sanzhar Koshkarbayev on 25.04.2023.
//

import UIKit

class HousePriceTableViewCell: UITableViewCell {

    @IBOutlet weak var idView: UIView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        idView.clipsToBounds = true
        idView.layer.borderWidth = 1
        idView.layer.borderColor = UIColor.tintColor.cgColor
    }
    
    func setupData(id: String, price: String, reviews: String, address: String) {
        idLabel.text = "ID: \(id)"
        switch User.shared.metric {
        case .usd:
            priceLabel.text = "$\(price.beautifulPrice())"
        case .kzt:
            if let price = Double(price) {
                self.priceLabel.text = "\(String(Int(price * Server.sharedInstance.currencyMultiplyer)).beautifulPrice()) KZT"
            }
        case .rub:
            if let price = Double(price) {
                self.priceLabel.text = "\(String(Int(price * Server.sharedInstance.currencyMultiplyer)).beautifulPrice()) RUB"
            }
        }
        ratingLabel.text = reviews
        addressLabel.text = address
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
