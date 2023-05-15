//
//  FavoritesViewController.swift
//  Rentify App
//
//  Created by Sanzhar Koshkarbayev on 22.04.2023.
//

import UIKit


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
        view.showLoading()
        
        Server.sharedInstance.getFavorites { result in
            self.favorites = result
            self.view.hideLoading()
            if self.favorites.isEmpty {
                self.mainTableView.isHidden = true
            }
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
