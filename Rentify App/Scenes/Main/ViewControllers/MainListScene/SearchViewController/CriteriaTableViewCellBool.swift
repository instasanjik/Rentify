//
//  CriteriaTableViewCellBool.swift
//  Rentify App
//
//  Created by Sanzhar Koshkarbayev on 13.05.2023.
//

import UIKit

class CriteriaTableViewCellBool: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var boolSwitch: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
