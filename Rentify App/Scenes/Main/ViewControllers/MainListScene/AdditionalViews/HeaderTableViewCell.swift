//
//  HeaderTableViewCell.swift
//  Rentify App
//
//  Created by Sanzhar Koshkarbayev on 22.04.2023.
//

import UIKit

class HeaderTableViewCell: UITableViewCell {
    @IBOutlet weak var typesCollectionView: UICollectionView!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        typesCollectionView.delegate = self
        typesCollectionView.dataSource = self
        typesCollectionView.showsHorizontalScrollIndicator = false
        typesCollectionView.selectItem(at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: .bottom)
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension HeaderTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TypeCollectionViewCell", for: indexPath) as! TypeCollectionViewCell
        if indexPath.row == 0 {
            cell.imageName = "All_Icon"
            cell.isSelected = true
            cell.nameLabel.text = "All ads"
        } else if indexPath.row == 1 {
            cell.imageName = "House_Icon"
            cell.nameLabel.text = "Houses"
        } else if indexPath.row == 2 {
            cell.imageName = "Buildings_Icon"
            cell.nameLabel.text = "Apartments"
        } else {
            cell.imageName = "Room_Icon"
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
