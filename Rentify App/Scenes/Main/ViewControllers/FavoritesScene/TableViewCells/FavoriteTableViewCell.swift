//
//  FavoriteTableViewCell.swift
//  Rentify App
//
//  Created by Sanzhar Koshkarbayev on 22.04.2023.
//

import UIKit

class FavoriteTableViewCell: UITableViewCell {
    
    @IBOutlet weak var previewView: SKCurveView!
    
    @IBOutlet weak var additionalInfoLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var regionLabel: UILabel!
    
    var promise: FavoritePromise?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupData(promise: FavoritePromise) {
        self.promise = promise
        
        previewView.setupView(additionalViewBackgroundColor: .black,
                              additionalViewFont: .systemFont(ofSize: 14, weight: .medium),
                              additionalViewText: promise.price.getCurrencyBasedPrice(),
                              imageForShowing: promise.previewLink)
        additionalInfoLabel.text = promise.additionalInfo
        addressLabel.text = promise.address
        regionLabel.text = promise.region
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func callTapped(_ sender: Any) {
        guard let promise = promise else { return }
        if let url = URL(string: "tel://\(promise.landlordPhoneNumber)") {
             UIApplication.shared.open(url)
        }
    }
    @IBAction func chatTapped(_ sender: Any) {
        guard let promise = promise else { return }
        if let url = URL(string: "mailto:\(promise.landlordEmail)") {
            UIApplication.shared.open(url)
        }
    }
}
