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
        Server.sharedInstance.loginUser(login: self.nameTextField.text ?? "", password: self.passwordTextField.text ?? "") { isSuccess in
            if isSuccess {
                SVProgressHUD.dismiss()
                let sb = UIStoryboard(name: "Main", bundle: nil)
                let vc = sb.instantiateViewController(withIdentifier: "MainTabbarController")
                vc.modalPresentationStyle = .fullScreen
                vc.modalTransitionStyle = .crossDissolve
                self.present(vc, animated: true)
            } else {
                ProgressHud.showError(withText: "Invalid login or password")
            }
        }
    }
    
    @IBAction func signUpTapped(_ sender: Any) {
        if let navigationController = self.navigationController {
            navigationController.popViewController(animated: true)
            
            let newViewController = self.storyboard?.instantiateViewController(withIdentifier: "SignUpViewController")
            navigationController.pushViewController(newViewController!, animated: true)
        }
    }
    
    
}

extension LoginViewController {
    
    
    
    
}
