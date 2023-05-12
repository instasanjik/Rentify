//
//  FavoriteTableViewCell.swift
//  Rentify App
//
//  Created by Sanzhar Koshkarbayev on 22.04.2023.
//

import UIKit

class FavoriteTableViewCell: UITableViewCell {
    
    @IBOutlet weak var previewView: SKCurveView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        previewView.setupView(additionalViewBackgroundColor: .black,
                              additionalViewFont: .systemFont(ofSize: 14, weight: .medium),
                              additionalViewText: "$1000",
                              imageForShowing: UIImage(named: "House-2"))
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
