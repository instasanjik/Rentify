//
//  LoginViewController.swift
//  Rentify App
//
//  Created by Sanzhar Koshkarbayev on 22.04.2023.
//

import UIKit
import SVProgressHUD

class LoginViewController: UIViewController {

    @IBOutlet weak var nameTextField: SKTextField!
    @IBOutlet weak var passwordTextField: SKTextField!
    @IBOutlet weak var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    @IBAction func loginTapped(_ sender: UIButton) {
        SVProgressHUD.show()
//        Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { _ in
            SVProgressHUD.dismiss()
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: "MainTabbarController")
            vc.modalPresentationStyle = .fullScreen
            vc.modalTransitionStyle = .crossDissolve
            self.present(vc, animated: true)
//        }
    }
}
