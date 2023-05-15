//
//  EditProfileViewController.swift
//  Rentify App
//
//  Created by Sanzhar Koshkarbayev on 16.05.2023.
//

import UIKit
import Kingfisher
import SVProgressHUD

class EditProfileViewController: UIViewController {
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var blockView: UIView!
    @IBOutlet weak var PickerViewPSuperView: UIView!
    
    @IBOutlet weak var usernameTextField: SKTextField!
    @IBOutlet weak var emailTextField: SKTextField!
    
    @IBOutlet weak var metricButton: UIButton!
    
    var avatarChanged = false
    var selectedRow = 0
    let metrics: [String] = ["USD / ft2", "KZT / m2", "RUB / m2"]

    override func viewDidLoad() {
        super.viewDidLoad()
        if let url = URL(string: User.shared.avatarLink ?? "") {
            avatarImageView.kf.setImage(with: url)
        }
        let tap = UITapGestureRecognizer(target: self, action: #selector(avatarTapped(_:)))
        avatarImageView.addGestureRecognizer(tap)
        
        let tap1 = UITapGestureRecognizer(target: self, action: #selector(bgTapped(_:)))
        blockView.addGestureRecognizer(tap1)
        
        avatarImageView.isUserInteractionEnabled = true
        usernameTextField.text = User.shared.userName
        emailTextField.text = User.shared.email
        metricButton.layer.borderColor = UIColor.systemGray5.cgColor
        metricButton.layer.cornerRadius = 5
    }
    
    @objc func bgTapped(_ sender: UITapGestureRecognizer) {
        cancelPickerViewTapped(0)
    }
    
    @objc func avatarTapped(_ sender: UITapGestureRecognizer) {
        print("avatar tapped")
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        present(imagePicker, animated: true)
    }
    
    @IBAction func savePickerViewTapped(_ sender: Any) {
        metricButton.setTitle(metrics[selectedRow], for: .normal)
        blockView.isHidden = true
        PickerViewPSuperView.isHidden = true
    }
    
    @IBAction func cancelPickerViewTapped(_ sender: Any) {
        blockView.isHidden = true
        PickerViewPSuperView.isHidden = true
    }
    
    @IBAction func metricTapped(_ sender: Any) {
        blockView.isHidden = false
        PickerViewPSuperView.isHidden = false
    }
    
    @IBAction func saveTaped(_ sender: Any) {
        SVProgressHUD.show()
        var newAvatar: UIImage? = nil
        if avatarChanged {
            newAvatar = avatarImageView.image
        }
        Server.sharedInstance.editUserProfile(user:
                                                User(email: emailTextField.text ?? "",
                                                     avatarLink: "",
                                                     userName: usernameTextField.text ?? ""), newAvatar: newAvatar) { isSuccess in
            if isSuccess {
                ProgressHud.showSuccess(withText: "Saved")
                self.navigationController?.popViewController(animated: true)
            } else {
                ProgressHud.showError(withText: "Some error was happened")
            }
        }
    }
}

extension EditProfileViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return metrics[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedRow = row
    }
    
    
    
    
}

extension EditProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        avatarChanged = true
        if let image = info[.originalImage] as? UIImage {
            avatarImageView.image = image
        }
    }
    
}
