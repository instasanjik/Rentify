//
//  TypeCollectionViewCell.swift
//  Rentify App
//
//  Created by Sanzhar Koshkarbayev on 22.04.2023.
//

import UIKit

class TypeCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                bgView.backgroundColor = .black
                nameLabel.textColor = .white
                iconImageView.tintColor = .white
            } else {
                bgView.backgroundColor = .white
                nameLabel.textColor = .black
                iconImageView.tintColor = .black
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        bgView.layer.borderColor = UIColor.systemGray4.cgColor
    }
}
