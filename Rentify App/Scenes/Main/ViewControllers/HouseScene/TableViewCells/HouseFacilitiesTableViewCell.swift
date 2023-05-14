//
//  HouseFacilitiesTableViewCell.swift
//  Rentify App
//
//  Created by Sanzhar Koshkarbayev on 25.04.2023.
//

import UIKit

class HouseFacilitiesTableViewCell: UITableViewCell {

    @IBOutlet weak var facilitiesCollectionView: UICollectionView!
    
    let FACILITIES: [String] = [
        "Facilities_metro",
        "Facilities_parking",
        "Facilities_ping-pong",
        "Facilities_repair",
        "Facilities_schools",
        "Facilities_shops",
        "Facilities_weather",
        "Facilities_wifi"
    ]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        facilitiesCollectionView.delegate = self
        facilitiesCollectionView.dataSource = self
    }
    
    func setupData(facilities: [String]) {
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}

extension HouseFacilitiesTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return FACILITIES.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FacillitiesCollectionViewCell", for: indexPath) as! FacillitiesCollectionViewCell
        cell.imageView.image = UIImage(named: FACILITIES[indexPath.row])
        cell.nameLabel.text = FACILITIES[indexPath.row].components(separatedBy: "_")[1].capitalized
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 48, height: 77)
    }
    
    
}
