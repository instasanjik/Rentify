//
//  HouseTableViewCell.swift
//  Rentify App
//
//  Created by Sanzhar Koshkarbayev on 22.04.2023.
//

import UIKit

class HouseTableViewCell: UITableViewCell {
    
    @IBOutlet weak var previewView: SKCurveView!
    @IBOutlet weak var additionalInfoLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var regionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupData(promise: RentedPromise) {
        previewView.setupView(additionalViewBackgroundColor: .tintColor,
                              additionalViewText: promise.timeLeft,
                              imageForShowing: promise.previewImageLink)
        additionalInfoLabel.text = promise.additionalInfo
        addressLabel.text = promise.address
        regionLabel.text = promise.region
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
