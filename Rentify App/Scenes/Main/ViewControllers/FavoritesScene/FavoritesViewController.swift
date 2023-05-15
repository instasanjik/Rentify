//
//  FavoritesViewController.swift
//  Rentify App
//
//  Created by Sanzhar Koshkarbayev on 22.04.2023.
//

import UIKit
import CRRefresh


class FavoritesViewController: UIViewController {

    @IBOutlet weak var mainTableView: UITableView!
    
    var favorites: [FavoritePromise] = [] {
        didSet {
            mainTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.showsVerticalScrollIndicator = false
        
        mainTableView.cr.addHeadRefresh(animator: NormalHeaderAnimator()) {
            Server.sharedInstance.getFavorites { result in
                CacheManager.shared.favorites = result
                self.mainTableView.cr.endHeaderRefresh()
                self.favorites = result
                if self.favorites.isEmpty {
                    self.mainTableView.isHidden = true
                }
            }
        }
    }
    
    fileprivate func reloadPage() {
        if !CacheManager.shared.favoritesNeedRequest { return }
        view.showLoading()
        
        Server.sharedInstance.getFavorites { result in
            self.favorites = result
            CacheManager.shared.favorites = result
            if !result.isEmpty {
                CacheManager.shared.favoritesNeedRequest = false
            }
            self.view.hideLoading()
            if self.favorites.isEmpty {
                self.mainTableView.isHidden = true
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        reloadPage()
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
        cell.setupData(promise: favorites[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "HouseViewController")
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    
}
