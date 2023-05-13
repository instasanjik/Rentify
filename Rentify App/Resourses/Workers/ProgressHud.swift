//
//  ProgressHud.swift
//  Rentify App
//
//  Created by Sanzhar Koshkarbayev on 12.05.2023.
//

import Foundation
import SVProgressHUD

class ProgressHud {
    
    static func showSuccess(withText text: String?, delayTime: Float = 2) {
        SVProgressHUD.showSuccess(withStatus: text)
        SVProgressHUD.dismiss(withDelay: TimeInterval(delayTime))
    }
    
    static func showError(withText text: String?, delayTime: Float = 2) {
        SVProgressHUD.showError(withStatus: text)
        SVProgressHUD.dismiss(withDelay: TimeInterval(delayTime))
    }
    
    static func showComingSoonAlert() -> UIAlertController {
        let refreshAlert = UIAlertController(title: "In developing", message: "This page is under development, we will add it later", preferredStyle: .alert)

        refreshAlert.addAction(UIAlertAction(title: "OK😊", style: .default, handler: { (action: UIAlertAction!) in
              print("Handle Ok logic here")
        }))

        refreshAlert.addAction(UIAlertAction(title: "OK😣", style: .cancel, handler: { (action: UIAlertAction!) in
              print("Handle Cancel Logic here")
        }))
        return refreshAlert
    }
    
}
