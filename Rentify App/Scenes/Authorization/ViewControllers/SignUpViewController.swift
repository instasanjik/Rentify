//
//  SignUpViewController.swift
//  Rentify App
//
//  Created by Sanzhar Koshkarbayev on 22.04.2023.
//

import UIKit
import SVProgressHUD

class SignUpViewController: UIViewController {

    @IBOutlet weak var usernameTF: SKUsernameTextField!
    @IBOutlet weak var emailTF: SKTextField!
    @IBOutlet weak var passwordTF: SKTextField!
    
    @IBOutlet weak var checkboxButton: UIButton!
    
    var isChecked = false {
        didSet {
            if isChecked {
                checkboxButton.setImage(UIImage(named: "checkbox_on"), for: .normal)
            } else {
                checkboxButton.setImage(UIImage(named: "checkbox_off"), for: .normal)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    @IBAction func checkboxButtonTapped(_ sender: UIButton) {
        isChecked.toggle()
    }
    
    @IBAction func SignUpTapped(_ sender: UIButton) {
        let validation = validateTextFields(email: emailTF.text, username: usernameTF.text, password: passwordTF.text)
        if validation.isSuccess {
            if isChecked {
                SVProgressHUD.show()
                Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { _ in
                    SVProgressHUD.dismiss()
                    let sb = UIStoryboard(name: "Main", bundle: nil)
                    let vc = sb.instantiateViewController(withIdentifier: "MainTabbarController")
                    vc.modalPresentationStyle = .fullScreen
                    vc.modalTransitionStyle = .crossDissolve
                    self.present(vc, animated: true)
                }
            } else {
                ProgressHud.showError(withText: "To continue, you must accept the terms of use")
            }
        } else {
            ProgressHud.showError(withText: validation.errorDescription)
        }
    }
    
    @IBAction func loginTapped(_ sender: Any) {
        if let navigationController = self.navigationController {
            navigationController.popViewController(animated: true)
            
            let newViewController = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController")
            navigationController.pushViewController(newViewController!, animated: true)
        }
    }
    
}

extension SignUpViewController {
    
    func validateTextFields(email: String?, username: String?, password: String?) -> (isSuccess: Bool, errorDescription: String?) {
        
        if let username = username {
            if username.isEmpty {
                return (false, "Username field is empty.")
            } else if username.count < 3 {
                return (false, "Username must be at least 3 characters long.")
            }
        } else {
            return (false, "Username field is empty.")
        }
        
        if let email = email {
            if email.isEmpty {
                return (false, "Email field is empty.")
            } else if email.count < 3 {
                return (false, "Email must be at least 3 characters long.")
            } else if !isValidEmail(email) {
                return (false, "Invalid email format.")
            }
        } else {
            return (false, "Email field is empty.")
        }
        
        if let password = password {
            if password.isEmpty {
                return (false, "Password field is empty.")
            } else if password.count < 3 {
                return (false, "Password must be at least 3 characters long.")
            }
        } else {
            return (false, "Password field is empty.")
        }
        
        return (true, nil)
    }


    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }

    
}
