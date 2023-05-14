//
//  HouseViewController.swift
//  Rentify App
//
//  Created by Sanzhar Koshkarbayev on 25.04.2023.
//

import UIKit
import Agrume

class HouseViewController: UIViewController {
    
    @IBOutlet weak var shareBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var likeBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var contentTableView: UITableView!
    @IBOutlet weak var footerView: UIView!
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet var footerBottomConstraint: NSLayoutConstraint!
    
    let PRICE = "1920"
    
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
        footerBottomConstraint.constant = -120
//        tabBarController?.tabBar.isHidden = true
        shareBarButtonItem.image = UIImage(named: "Share_Icon")!.withRenderingMode(.alwaysOriginal)
        isAdFavorite = false
        footerView.layer.borderColor = UIColor.systemGray3.cgColor
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
//        tabBarController?.tabBar.isHidden = false
    }
    
    @IBAction func likeTapped(_ sender: UIBarButtonItem) {
        isAdFavorite.toggle()
    }
    
    @IBAction func bookTapped(_ sender: Any) {
        
    }
    
}

extension HouseViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "HouseHeaderTableViewCell", for: indexPath) as! HouseHeaderTableViewCell
            cell.setupData(imageLink: "https://images.pexels.com/photos/1974596/pexels-photo-1974596.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1")
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "HousePriceTableViewCell", for: indexPath) as! HousePriceTableViewCell
            cell.setupData(id: "102923", price: PRICE, reviews: "3.1 (6 reviews)", address: "A.Pushkin st. - Republic Avenue, HC \"Rose\"")
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "HouseOverviewTableViewCell", for: indexPath) as! HouseOverviewTableViewCell
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
            let cell = tableView.dequeueReusableCell(withIdentifier: "HouseCalendarTableViewCell", for: indexPath) as! HouseCalendarTableViewCell
            cell.delegate = self
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: "HouseFacilitiesTableViewCell", for: indexPath) as! HouseFacilitiesTableViewCell
            cell.setupData(facilities: [])
            return cell
        case 5:
            let cell = tableView.dequeueReusableCell(withIdentifier: "HouseGalleryTableViewCell", for: indexPath) as! HouseGalleryTableViewCell
            cell.delegate = self
            return cell
        case 6:
            let cell = tableView.dequeueReusableCell(withIdentifier: "HouseLocationTableViewCell", for: indexPath) as! HouseLocationTableViewCell
            return cell
        default:
            return UITableViewCell()
        }
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

extension HouseViewController: HouseCalendarTableViewCellDelegate {
    
    func datesSelected(days: [Date], totalDays: Int, totalWeekends: Int) {
        totalPriceLabel.text = "$\(String((Int(PRICE) ?? 0) / 31 * totalDays).beautifulPrice())"
        if totalDays == 0 {
            footerBottomConstraint.constant = -120
        } else {
            footerBottomConstraint.constant = 0
        }
        self.view.setNeedsUpdateConstraints()
        self.view.setNeedsLayout()
        self.footerView.setNeedsUpdateConstraints()
        self.footerView.setNeedsLayout()
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
            self.footerView.layoutIfNeeded()
        }
    }
    
    
}

extension HouseViewController: HouseGalleryTableViewCellDelegate {
    
    
    func seeAllTapped(at index: Int) {
        var images: [UIImage] = []
        for index in 5...19 {
            images.append(UIImage(named: "House-\(index)")!)
        }
        
        let agrume = Agrume(images: images, startIndex: index, background: .blurred(.light))
        
        agrume.show(from: self)
    }
    
    
}
