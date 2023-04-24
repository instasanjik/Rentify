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
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        return
    }
    
    
}

