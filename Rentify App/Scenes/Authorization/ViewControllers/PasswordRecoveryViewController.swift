//
//  PasswordRecoveryViewController.swift
//  Rentify App
//
//  Created by Sanzhar Koshkarbayev on 22.04.2023.
//

import UIKit
import SVProgressHUD

class PasswordRecoveryViewController: UIViewController {

    @IBOutlet weak var usernameTextField: SKTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func sendCodeTapped(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "OTPViewController") as! OTPViewController
        self.navigationController?.pushViewController(vc, animated: true)
        vc.email = self.hideText(self.usernameTextField.text!)
    }
    
    func hideText(_ text: String) -> String {
        let components = text.split(separator: "@")
        
        guard components.count == 2 else {
            return text
        }
        
        let username = components[0]
        let domain = components[1]
        
        let hiddenUsername = hideCharacters(String(username), keepFirst: 3)
        return "\(hiddenUsername)@\(domain)"
    }

    func hideCharacters(_ text: String, keepFirst count: Int) -> String {
        guard text.count > count else {
            return text
        }
        
        let startIndex = text.index(text.startIndex, offsetBy: count)
        let hiddenPart = String(repeating: "*", count: text.count - count)
        
        return text.replacingCharacters(in: startIndex..<text.endIndex, with: hiddenPart)
    }
    
}
