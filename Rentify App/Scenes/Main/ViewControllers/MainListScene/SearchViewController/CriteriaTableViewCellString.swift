//
//  CriteriaTableViewCell.swift
//  Rentify App
//
//  Created by Sanzhar Koshkarbayev on 13.05.2023.
//

import UIKit

class CriteriaTableViewCellString: UITableViewCell {
    
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
