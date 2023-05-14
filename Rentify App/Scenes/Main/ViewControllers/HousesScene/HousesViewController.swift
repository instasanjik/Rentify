//
//  HousesViewController.swift
//  Rentify App
//
//  Created by Sanzhar Koshkarbayev on 22.04.2023.
//

import UIKit

class RentedPromise {
    var timeLeft: String = ""
    var previewImageLink: String = ""
    var additionalInfo: String = ""
    var address: String = ""
    var region: String = ""
}

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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

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

