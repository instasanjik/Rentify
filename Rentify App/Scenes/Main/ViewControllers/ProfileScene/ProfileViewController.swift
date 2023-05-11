//
//  ProfileViewController.swift
//  Rentify App
//
//  Created by Sanzhar Koshkarbayev on 22.04.2023.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var talbeView: UITableView!
    
    let PROFILE_BLOCKS = ["Settings", "My awards", "Notifications", "Write a letter to the developers", "Report About the problem", "Leave"]
    let ICON_NAMES = ["gear", "star", "bell", "mail", "exclamationmark.2", "rectangle.portrait.and.arrow.right"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        if indexPath.row == 4 {
            let alert = UIAlertController(title: "Report a problem", message: "Tell us more about your own problem that you are facing, we will solve it in the near future", preferredStyle: .alert)

            alert.addTextField { (textField) in
                textField.text = "I ran into a problem at the moment of "
            }

            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
                let textField = alert?.textFields![0]
                print("Text field: \(textField!.text)")
            }))

            self.present(alert, animated: true, completion: nil)
        } else if indexPath.row == 5 {
            let alertController = UIAlertController(title: "Leave", message: "Are you sure want to leave the application?", preferredStyle: .actionSheet)
            
            let action1 = UIAlertAction(title: "Yes", style: .default) { (action) in
                CacheManager.shared.removeString(forKey: "refreshToken")
                self.showAuthorization()
            }
            alertController.addAction(action1)
            
            let action2 = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
                print("Cancel is pressed......")
            }
            alertController.addAction(action2)
            self.present(alertController, animated: true, completion: nil)
        }
        return
    }
    
    
    func showAuthorization() {
        let storyboard = UIStoryboard(name: "Authorization", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "OpeningScreenViewController")
        vc.modalTransitionStyle = .coverVertical
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
}
