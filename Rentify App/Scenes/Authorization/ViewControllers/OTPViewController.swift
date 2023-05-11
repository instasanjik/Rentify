//
//  OTPViewController.swift
//  Rentify App
//
//  Created by Sanzhar Koshkarbayev on 22.04.2023.
//

import UIKit
import SVPinView
import SVProgressHUD

class OTPViewController: UIViewController {
    
    @IBOutlet weak var OTPView: SVPinView!
    @IBOutlet weak var sendCodeAgainButton: UIButton!
    @IBOutlet weak var textLabel: UILabel!
    var email: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startTimer()
        textLabel.text! += email
        OTPView.didFinishCallback = { [weak self] pin in
            DispatchQueue.main.async {
                SVProgressHUD.show()
                Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { _ in
                    SVProgressHUD.dismiss()
                    let vc = self?.storyboard?.instantiateViewController(withIdentifier: "NewPasswordViewController")
                    self?.navigationController?.pushViewController(vc!, animated: true)
                }
            }
        }
    }
    
    var timeLeft = 60
    var timer: Timer?

    func startTimer() {
        sendCodeAgainButton.isEnabled = false
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { [weak self] _ in
            guard let self = self else { return }
            
            self.timeLeft -= 1
            
            self.sendCodeAgainButton.setTitle("Send code again in \(self.timeLeft) seconds", for: .normal)
            
            if self.timeLeft == 0 {
                self.timer?.invalidate()
                self.timer = nil
                self.sendCodeAgainButton.isEnabled = true
                self.sendCodeAgainButton.setTitle("Send code again", for: .normal)
            }
        })
    }

    // Call this function when the button is tapped
    @IBAction func sendCodeAgainButtonTapped(_ sender: UIButton) {
        if timeLeft == 0 {
            // Start timer if time is up
            timeLeft = 10 // Reset time limit
            startTimer()
        }
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
