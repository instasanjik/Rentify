//
//  ProgressHud.swift
//  Rentify App
//
//  Created by Sanzhar Koshkarbayev on 12.05.2023.
//

import Foundation
import SVProgressHUD

class ProgressHud {
    
    static func showSuccess(withText text: String?, delayTime: Float = 0.2) {
        SVProgressHUD.showSuccess(withStatus: text)
        SVProgressHUD.dismiss(withDelay: TimeInterval(delayTime))
    }
    
    static func showError(withText text: String?, delayTime: Float = 0.2) {
        SVProgressHUD.showError(withStatus: text)
        SVProgressHUD.dismiss(withDelay: TimeInterval(delayTime))
    }
    
}
