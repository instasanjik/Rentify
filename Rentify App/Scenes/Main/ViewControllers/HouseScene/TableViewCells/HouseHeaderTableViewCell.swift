//
//  HouseHeaderTableViewCell.swift
//  Rentify App
//
//  Created by Sanzhar Koshkarbayev on 25.04.2023.
//

import UIKit
import Kingfisher

class HouseHeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var adPreviewImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupData(imageLink: String) {
        if let url = URL(string: imageLink) {
            adPreviewImageView.kf.setImage(with: url)
        } else {
            adPreviewImageView.image = UIImage(named: "No_Image")
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
