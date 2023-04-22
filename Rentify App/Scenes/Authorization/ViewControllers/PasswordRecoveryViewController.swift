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
        SVProgressHUD.show()
        Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { _ in
            DispatchQueue.main.async {
                SVProgressHUD.dismiss()
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "OTPViewController")
                self.navigationController?.pushViewController(vc!, animated: true)
            }
        }
    }
    
}
