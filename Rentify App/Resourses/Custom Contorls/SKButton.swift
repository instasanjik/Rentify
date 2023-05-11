//
//  SKButton.swift
//  Rentify App
//
//  Created by Sanzhar Koshkarbayev on 12.05.2023.
//

import Foundation
import UIKit

class SKButton: UIButton {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 1
        self.clipsToBounds = true
        self.layer.cornerRadius = 10
    }
    
}
