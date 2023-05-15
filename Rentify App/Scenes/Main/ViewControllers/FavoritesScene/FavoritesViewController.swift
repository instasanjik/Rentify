//
//  FavoritesViewController.swift
//  Rentify App
//
//  Created by Sanzhar Koshkarbayev on 22.04.2023.
//

import UIKit

class FavoritePromise {
    var previewLink: String = ""
    var price: String = ""
    var additionalInfo: String = ""
    var address: String = ""
    var region: String = ""
    var landlordPhoneNumber: String = ""
    var landlordEmail: String = ""
    
    
    init(previewLink: String, price: String, additionalInfo: String, address: String, region: String, landlordPhoneNumber: String, landlordEmail: String) {
        self.previewLink = previewLink
        self.price = price
        self.additionalInfo = additionalInfo
        self.address = address
        self.region = region
        self.landlordPhoneNumber = landlordPhoneNumber
        self.landlordEmail = landlordEmail
    }
}

class FavoritesViewController: UIViewController {

    @IBOutlet weak var mainTableView: UITableView!
    
    var favorites: [FavoritePromise] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.showsVerticalScrollIndicator = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if favorites.isEmpty {
            mainTableView.isHidden = true
        }
    }
    
    @IBAction func findListingsTapped(_ sender: Any) {
        tabBarController?.selectedIndex = 2
    }

}

extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 321+16
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteTableViewCell", for: indexPath) as! FavoriteTableViewCell
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "HouseViewController")
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    
}
