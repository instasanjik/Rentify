//
//  HousesViewController.swift
//  Rentify App
//
//  Created by Sanzhar Koshkarbayev on 22.04.2023.
//

import UIKit
import CRRefresh

class HousesViewController: UIViewController {

    @IBOutlet weak var housesTableView: UITableView!
    
    var rentedPromises: [RentedPromise] = [] {
        didSet {
            housesTableView.reloadData()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        housesTableView.delegate = self
        housesTableView.dataSource = self
        housesTableView.showsVerticalScrollIndicator = false
        
        
        housesTableView.cr.addHeadRefresh(animator: NormalHeaderAnimator()) {
            Server.sharedInstance.getRentedPromises { result in
                CacheManager.shared.rentedPromises = result
                self.housesTableView.cr.endHeaderRefresh()
                self.rentedPromises = result
                if self.rentedPromises.isEmpty {
                    self.housesTableView.isHidden = true
                }
            }
        }
    }
    
    fileprivate func reloadPage() {
        if !CacheManager.shared.rentedPromisesNeedRequest { return }
        view.showLoading()
        
        Server.sharedInstance.getRentedPromises { result in
            self.rentedPromises = result
            CacheManager.shared.rentedPromises = result
            if !result.isEmpty {
                CacheManager.shared.rentedPromisesNeedRequest = false
            }
            self.view.hideLoading()
            if self.rentedPromises.isEmpty {
                self.housesTableView.isHidden = true
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

extension HousesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rentedPromises.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 265
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HouseTableViewCell", for: indexPath) as! HouseTableViewCell
        cell.selectionStyle = .none
        cell.setupData(promise: rentedPromises[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "HouseViewController") as? HouseViewController {
//            vc.isRented = true
//            self.navigationController?.pushViewController(vc, animated: true)
//        }
    }
    
    
}

