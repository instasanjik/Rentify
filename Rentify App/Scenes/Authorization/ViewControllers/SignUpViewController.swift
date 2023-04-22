//
//  SignUpViewController.swift
//  Rentify App
//
//  Created by Sanzhar Koshkarbayev on 22.04.2023.
//

import UIKit

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

        // Do any additional setup after loading the view.
    }
    

    @IBAction func checkboxButtonTapped(_ sender: UIButton) {
        isChecked.toggle()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
