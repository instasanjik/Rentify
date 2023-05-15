//
//  HousesViewController.swift
//  Rentify App
//
//  Created by Sanzhar Koshkarbayev on 22.04.2023.
//

import UIKit

class HousesViewController: UIViewController {

    @IBOutlet weak var housesTableView: UITableView!
    
    var rentedPromises: [RentedPromise] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        housesTableView.delegate = self
        housesTableView.dataSource = self
        housesTableView.showsVerticalScrollIndicator = false
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if rentedPromises.count == 0 {
            housesTableView.isHidden = true
        }
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
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "HouseViewController")
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    
}

