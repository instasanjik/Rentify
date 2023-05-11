//
//  SignUpViewController.swift
//  Rentify App
//
//  Created by Sanzhar Koshkarbayev on 22.04.2023.
//

import UIKit
import SVProgressHUD

class SignUpViewController: UIViewController {

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
        SVProgressHUD.show()
        Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { _ in
            SVProgressHUD.dismiss()
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: "MainTabbarController")
            vc.modalPresentationStyle = .fullScreen
            vc.modalTransitionStyle = .crossDissolve
            self.present(vc, animated: true)
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
