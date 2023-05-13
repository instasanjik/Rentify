//
//  HouseTableViewCell.swift
//  Rentify App
//
//  Created by Sanzhar Koshkarbayev on 22.04.2023.
//

import UIKit

class HouseTableViewCell: UITableViewCell {
    
    @IBOutlet weak var previewView: SKCurveView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        previewView.setupView(additionalViewBackgroundColor: .tintColor,
                              additionalViewText: "1 day",
                              imageForShowing: UIImage(named: "House-\(Int.random(in: 1...9))"))
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
