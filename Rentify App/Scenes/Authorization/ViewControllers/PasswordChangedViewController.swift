//
//  PasswordChangedViewController.swift
//  Rentify App
//
//  Created by Sanzhar Koshkarbayev on 22.04.2023.
//

import UIKit

class PasswordChangedViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func backToLoginTapped(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }

}
