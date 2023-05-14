//
//  HouseViewController.swift
//  Rentify App
//
//  Created by Sanzhar Koshkarbayev on 25.04.2023.
//

import UIKit

class HouseViewController: UIViewController {
    
    @IBOutlet weak var contentTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(isViewLoaded)
        print(contentTableView)
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        print(contentTableView)
    }
    
    
}

extension HouseViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            var cell = tableView.dequeueReusableCell(withIdentifier: "HouseHeaderTableViewCell", for: indexPath) as! HouseHeaderTableViewCell
            cell.setupData(imageLink: "")
        case 1:
            var cell = tableView.dequeueReusableCell(withIdentifier: "HousePriceTableViewCell", for: indexPath) as! HousePriceTableViewCell
            cell.setupData(id: "102923", price: "1920", reviews: "3.1 (6 reviews)", address: "A.Pushkin st. - Republic Avenue, HC \"Rose\"")
            return cell
        case 2:
            var cell = tableView.dequeueReusableCell(withIdentifier: "HouseOverviewTableViewCell", for: indexPath) as! HouseOverviewTableViewCell
            return cell
        case 3:
            var cell = tableView.dequeueReusableCell(withIdentifier: "HouseCalendarTableViewCell", for: indexPath) as! HouseCalendarTableViewCell
            return cell
        case 4:
            var cell = tableView.dequeueReusableCell(withIdentifier: "HouseFacilitiesTableViewCell", for: indexPath) as! HouseFacilitiesTableViewCell
            return cell
        case 5:
            var cell = tableView.dequeueReusableCell(withIdentifier: "HouseGalleryTableViewCell", for: indexPath) as! HouseGalleryTableViewCell
            return cell
        case 6:
            var cell = tableView.dequeueReusableCell(withIdentifier: "HouseLocationTableViewCell", for: indexPath) as! HouseLocationTableViewCell
            return cell
        default:
            return UITableViewCell()
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 307
        case 1:
            return 124
        case 2:
            return 170
        case 3:
            return 257
        case 4:
            return 214
        case 5:
            return 116+22
        case 6:
            return 264+100
        default:
            return 1000
        }
    }
    
    
}
