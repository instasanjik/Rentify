//
//  ControlPanelTableViewCell.swift
//  Rentify App
//
//  Created by Sanzhar Koshkarbayev on 17.05.2023.
//

import UIKit

protocol ControlPanelViewDelegate: AnyObject {
    func leaveDidTap()
}

class ControlPanelTableViewCell: UITableViewCell {
    
    var delegate: ControlPanelViewDelegate?
    
    @IBOutlet weak var bgView: UIView!
    
    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var daysLeftLabel: UILabel!
    
    @IBOutlet weak var checkInLabel: UILabel!
    @IBOutlet weak var daysPassedLabel: UILabel!
    @IBOutlet weak var leaveButton: SKButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        bgView.layer.borderColor = UIColor.systemGray5.cgColor
        leaveButton.layer.borderColor = UIColor.systemRed.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    @IBAction func leaveTapped(_ sender: Any) {
        delegate?.leaveDidTap()
    }
    
    @IBAction func topUpTapped(_ sender: Any) {
        
    }
    
    
}
