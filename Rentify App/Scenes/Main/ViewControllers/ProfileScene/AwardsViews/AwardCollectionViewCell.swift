//
//  AwardCollectionViewCell.swift
//  Rentify App
//
//  Created by Sanzhar Koshkarbayev on 16.05.2023.
//

import UIKit
import SnapKit

class AwardCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var logoImageview: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var bgView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        bgView.snp.makeConstraints { make in
            make.height.equalTo(188)
            make.width.equalTo(158)
        }
        bgView.layer.borderColor = UIColor.systemGray4.cgColor
    }
    
    func setupData(symbol: String, name: String, description: String) {
        logoImageview.text = symbol
        nameLabel.text = name
        descriptionLabel.text = description
        
    }
}
