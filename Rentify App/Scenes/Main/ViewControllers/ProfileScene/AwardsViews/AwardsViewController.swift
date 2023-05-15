//
//  AwardsViewController.swift
//  Rentify App
//
//  Created by Sanzhar Koshkarbayev on 16.05.2023.
//

import UIKit

class AwardsViewController: UIViewController {

    @IBOutlet weak var mainCOllectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    

}

extension AwardsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AwardCollectionViewCell", for: indexPath) as! AwardCollectionViewCell
        cell.setupData(symbol: "🏠", name: "Home Saver", description: "achieved after a stable stay in the house for 7 months or more.")
        cell
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 158, height: 188)
    }
    
    
}
