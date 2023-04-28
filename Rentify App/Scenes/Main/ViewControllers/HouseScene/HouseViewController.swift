//
//  HouseViewController.swift
//  Rentify App
//
//  Created by Sanzhar Koshkarbayev on 25.04.2023.
//

import UIKit

class HouseViewController: UIViewController {

    @IBOutlet weak var mainTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainTableView.delegate = self
        mainTableView.dataSource = self
    }
    
    
}

extension HouseViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        switch indexPath.row {
        case 0:
            cell = tableView.dequeueReusableCell(withIdentifier: "HouseHeaderTableViewCell", for: indexPath) as! HouseHeaderTableViewCell
        case 1:
            cell = tableView.dequeueReusableCell(withIdentifier: "HousePriceTableViewCell", for: indexPath) as! HousePriceTableViewCell
        case 2:
            cell = tableView.dequeueReusableCell(withIdentifier: "HouseOverviewTableViewCell", for: indexPath) as! HouseOverviewTableViewCell
        case 3:
            cell = tableView.dequeueReusableCell(withIdentifier: "HouseCalendarTableViewCell", for: indexPath) as! HouseCalendarTableViewCell
        case 4:
            cell = tableView.dequeueReusableCell(withIdentifier: "HouseFacilitiesTableViewCell", for: indexPath) as! HouseFacilitiesTableViewCell
        case 5:
            cell = tableView.dequeueReusableCell(withIdentifier: "HouseGalleryTableViewCell", for: indexPath) as! HouseGalleryTableViewCell
        case 6:
            cell = tableView.dequeueReusableCell(withIdentifier: "HouseLocationTableViewCell", for: indexPath) as! HouseLocationTableViewCell
        default:
            return cell
        }
        return cell
    }
    
    
}
