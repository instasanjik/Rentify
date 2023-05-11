//
//  LeaveConfirmationViewController.swift
//  Rentify App
//
//  Created by Sanzhar Koshkarbayev on 12.05.2023.
//

import UIKit

class LeaveConfirmationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func yesTapped(_ sender: Any) {
        CacheManager.shared.removeString(forKey: "refreshToken")
        
    }
    
    @IBAction func noTapped(_ sender: Any) {
        self.dismiss(animated: true)
    }
}
