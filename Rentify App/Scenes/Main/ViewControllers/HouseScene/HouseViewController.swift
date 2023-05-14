//
//  HouseViewController.swift
//  Rentify App
//
//  Created by Sanzhar Koshkarbayev on 25.04.2023.
//

import UIKit

class HouseViewController: UIViewController {
    
    @IBOutlet weak var shareBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var likeBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var contentTableView: UITableView!
    
    var isAdFavorite = false {
        didSet {
            if isAdFavorite {
                likeBarButtonItem.image = UIImage(named: "Like_Icon_On")!.withRenderingMode(.alwaysOriginal)
            } else {
                likeBarButtonItem.image = UIImage(named: "Like_Icon")!.withRenderingMode(.alwaysOriginal)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        shareBarButtonItem.image = UIImage(named: "Share_Icon")!.withRenderingMode(.alwaysOriginal)
        isAdFavorite = false
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        print(contentTableView)
    }
    
    @IBAction func likeTapped(_ sender: UIBarButtonItem) {
        isAdFavorite.toggle()
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
            cell.setupData(imageLink: "https://images.pexels.com/photos/1974596/pexels-photo-1974596.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1")
        case 1:
            var cell = tableView.dequeueReusableCell(withIdentifier: "HousePriceTableViewCell", for: indexPath) as! HousePriceTableViewCell
            cell.setupData(id: "102923", price: "1920", reviews: "3.1 (6 reviews)", address: "A.Pushkin st. - Republic Avenue, HC \"Rose\"")
            return cell
        case 2:
            var cell = tableView.dequeueReusableCell(withIdentifier: "HouseOverviewTableViewCell", for: indexPath) as! HouseOverviewTableViewCell
            cell.setupData(landlord: Landlord(id: "82910",
                                              name: "Yeren",
                                              surname: "Kalibek",
                                              avatarLink: "https://images.pexels.com/photos/936019/pexels-photo-936019.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
                                              rating: 3.5,
                                              offersCount: 192,
                                              email: "yeren.kalibek@gmail.com",
                                              phoneNumber: "77479102829"),
                           overview: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled")
            return cell
        case 3:
            var cell = tableView.dequeueReusableCell(withIdentifier: "HouseCalendarTableViewCell", for: indexPath) as! HouseCalendarTableViewCell
            
            return cell
        case 4:
            var cell = tableView.dequeueReusableCell(withIdentifier: "HouseFacilitiesTableViewCell", for: indexPath) as! HouseFacilitiesTableViewCell
            cell.setupData(facilities: [])
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
            return 270
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
