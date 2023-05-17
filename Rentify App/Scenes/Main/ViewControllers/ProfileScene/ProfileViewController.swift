//
//  ProfileViewController.swift
//  Rentify App
//
//  Created by Sanzhar Koshkarbayev on 22.04.2023.
//

import UIKit
import SkeletonView

class ProfileViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var talbeView: UITableView!
    
    let PROFILE_BLOCKS = ["Profile settings", "My awards", "Notifications", "Write a letter to the developers", "Report About the problem", "Leave"]
    let ICON_NAMES = ["gear", "star", "bell", "mail", "exclamationmark.2", "rectangle.portrait.and.arrow.right"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imageView.layer.cornerRadius = 64
        self.imageView.clipsToBounds = true
        
        Server.sharedInstance.getProfilePageData { image, username in
            self.imageView.image = image
            self.usernameLabel.text = username
        }
        talbeView.dataSource = self
        talbeView.delegate = self
    }
    

}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileBlockTableViewCell", for: indexPath) as! ProfileBlockTableViewCell
        cell.nameLabel.text = PROFILE_BLOCKS[indexPath.row]
        cell.blockIconImageView.image = UIImage(systemName: ICON_NAMES[indexPath.row])
        cell.blockIconImageView.tintColor = .black
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0: openSettingsScene()
        case 1: openAwardsScene()
        case 2: openNotificationScene()
        case 3: sentLetterToDevs()
        case 4: spawnReportAProblemModal()
        case 5: openLeaveConfirmationSceen()
        default: return
        }
    }
    
    
    func showAuthorization() {
        let storyboard = UIStoryboard(name: "Authorization", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "OpeningScreenViewController")
        vc.modalTransitionStyle = .coverVertical
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    func sentLetterToDevs() {
        let email = "koshkarbayev.07@gmail.com"
        if let url = URL(string: "mailto:\(email)") {
            UIApplication.shared.open(url)
        }
    }
    
    func openSettingsScene() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "EditProfileViewController") as! EditProfileViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func openAwardsScene() {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AwardsViewController") as! AwardsViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func openNotificationScene() {
        Logger.log(.action, "Notifications tapped")
        present(ProgressHud.showComingSoonAlert(), animated: true, completion: nil)
    }
    
    func spawnReportAProblemModal() {
        let alert = UIAlertController(title: "Report a problem", message: "Tell us more about your own problem that you are facing, we will solve it in the near future", preferredStyle: .alert)

        alert.addTextField { (textField) in
            textField.placeholder = "I ran into a problem on .."
        }

        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0]
            Server.sharedInstance.sendReport(reportText: textField!.text!)
            print("Text field: \(textField!.text)")
        }))
        
        let action2 = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            print("Cancel is pressed......")
        }
        alert.addAction(action2)

        self.present(alert, animated: true, completion: nil)
    }
    
    func openLeaveConfirmationSceen() {
        let alertController = UIAlertController(title: "Leave", message: "Are you sure want to leave the application?", preferredStyle: .actionSheet)
        
        let action1 = UIAlertAction(title: "Yes", style: .destructive) { (action) in
            CacheManager.shared.removeString(forKey: "accessToken")
            self.showAuthorization()
        }
        alertController.addAction(action1)
        
        let action2 = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            print("Cancel is pressed......")
        }
        alertController.addAction(action2)
        self.present(alertController, animated: true, completion: nil)
    }
    
}
