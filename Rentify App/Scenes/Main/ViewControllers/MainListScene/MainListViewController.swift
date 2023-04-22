//
//  MainListViewController.swift
//  Rentify App
//
//  Created by Sanzhar Koshkarbayev on 22.04.2023.
//

import UIKit

class MainListViewController: UIViewController {

    @IBOutlet weak var listTableView: UITableView!
    @IBOutlet weak var typesCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listTableView.dataSource = self
        listTableView.delegate = self
        listTableView.showsVerticalScrollIndicator = false
        
        typesCollectionView.delegate = self
        typesCollectionView.dataSource = self
    }
    
}

extension MainListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 309
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AdTableViewCell", for: indexPath) as! AdTableViewCell
        if indexPath.row == 0 {
            cell.houseImageView.image = UIImage(named: "House-1")
        } else {
            cell.houseImageView.image = UIImage(named: "House-1")
        }
        return cell
    }
    
    
}

extension MainListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TypeCollectionViewCell", for: indexPath) as! TypeCollectionViewCell
        if indexPath.row == 0 {
            cell.iconImageView.image = UIImage(named: "Buildings_Icon")
            cell.nameLabel.text = "All ads"
        } else if indexPath.row == 1 {
            cell.iconImageView.image = UIImage(named: "House_Icon")
            cell.nameLabel.text = "Houses"
        } else if indexPath.row == 2 {
            cell.iconImageView.image = UIImage(named: "Buildings_Icon")
            cell.nameLabel.text = "Apartments"
        } else {
            cell.iconImageView.image = UIImage(named: "Buildings_Icon")
            cell.nameLabel.text = "Rooms"
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var text = ""
        if indexPath.row == 0 {
            text = "All ads"
        } else if indexPath.row == 1 {
            text = "Houses"
        } else if indexPath.row == 2 {
            text = "Apartments"
        } else {
            text = "Rooms"
        }
        return CGSize(width: text.width(withConstrainedHeight: 20, font: UIFont.systemFont(ofSize: 15)) + 24 + 32 + 8, height: 40)
    }
    
    
}
