//
//  HouseGalleryTableViewCell.swift
//  Rentify App
//
//  Created by Sanzhar Koshkarbayev on 25.04.2023.
//

import UIKit

class HouseGalleryTableViewCell: UITableViewCell {
    
    var photoCount = 10
    var isPlusNeeded = false
    let PHOTO_DISPLAY_LIMIT = 3

    @IBOutlet weak var galleryCollectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        galleryCollectionView.delegate = self
        galleryCollectionView.dataSource = self
    }
    
    func setupData(photoLinks: [String]) {
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}

extension HouseGalleryTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if photoCount > PHOTO_DISPLAY_LIMIT {
            isPlusNeeded = true
            return PHOTO_DISPLAY_LIMIT
        }
        return photoCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GalleryCollectionViewCell", for: indexPath) as! GalleryCollectionViewCell
        cell.imageView.image = UIImage(named: "House-\(Int.random(in: 1...22))")
        if indexPath.row == PHOTO_DISPLAY_LIMIT - 1 && isPlusNeeded {
            let view = UIView(frame: cell.bounds)
            view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
            view.layer.cornerRadius = 4
            view.clipsToBounds = true
            cell.addSubview(view)
            let label = UILabel(frame: view.bounds)
            label.textAlignment = .center
            label.text = "+\(photoCount - PHOTO_DISPLAY_LIMIT)"
            label.textColor = .white
            label.font = .systemFont(ofSize: 16, weight: .medium)
            view.addSubview(label)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GalleryCollectionViewCell", for: indexPath) as! GalleryCollectionViewCell
            cell.imageView.image = UIImage(named: "House-\(Int.random(in: 1...22))")
            return cell
        }
    }
    
    
}
