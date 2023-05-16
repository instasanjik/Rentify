//
//  HouseViewController.swift
//  Rentify App
//
//  Created by Sanzhar Koshkarbayev on 25.04.2023.
//

import UIKit
import Agrume
import CoreLocation
//import SkeletonView

class HouseViewController: UIViewController {
    
    @IBOutlet weak var shareBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var likeBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var contentTableView: UITableView!
    @IBOutlet weak var footerView: UIView!
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet var footerBottomConstraint: NSLayoutConstraint!
    
    var apartmentsId: String = "" {
        didSet {
            Server.sharedInstance.getFullHouse(id: apartmentsId) { house in
                self.house = house
            }
        }
    }
    
    var house: HouseFull? = nil {
        didSet {
            if isViewLoaded {
                contentTableView.reloadData()
            }
        }
    }
    
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
        if let cell = contentTableView.cellForRow(at: IndexPath(row: 3, section: 0)) as? HouseCalendarTableViewCell {
            if isConsecutiveDates(cell.selectedDays) {
                ProgressHud.showSuccess(withText: "Booked")
            } else {
                ProgressHud.showError(withText: "Select consecutive dates!")
                cell.calendarView.shake()
            }
        }
    }
    
    func isConsecutiveDates(_ dates: [Date]) -> Bool {
        let dates = dates.sorted()
        guard dates.count > 1 else {
            return true
        }
        
        let calendar = Calendar.current
        let oneDay: TimeInterval = 60 * 60 * 24
        
        for i in 1..<dates.count {
            let previousDate = dates[i - 1]
            let currentDate = dates[i]
            
            // Check if the difference between dates is exactly one day
            let difference = calendar.dateComponents([.day], from: previousDate, to: currentDate)
            if difference.day != 1 {
                return false
            }
        }
        
        return true
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
            if house != nil {
                cell.setupData(imageLink: house?.imageLink ?? "")
            }
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "HousePriceTableViewCell", for: indexPath) as! HousePriceTableViewCell
            cell.setupData(id: house?.id ?? "",
                           price: house?.price ?? "",
                           reviews: house?.reviews ?? "",
                           address: house?.address ?? "")
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "HouseOverviewTableViewCell", for: indexPath) as! HouseOverviewTableViewCell
            cell.setupData(landlord: Landlord(id: house?.landlord?.id ?? "",
                                              name: house?.landlord?.name ?? "",
                                              surname: house?.landlord?.surname ?? "",
                                              avatarLink: house?.landlord?.avatarLink ?? "",
                                              rating: house?.landlord?.rating ?? 0,
                                              offersCount: house?.landlord?.offersCount ?? 0,
                                              email: house?.landlord?.email ?? "",
                                              phoneNumber: house?.landlord?.phoneNumber ?? ""),
                           overview: house?.overview ?? "")
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "HouseCalendarTableViewCell", for: indexPath) as! HouseCalendarTableViewCell
            cell.delegate = self
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: "HouseFacilitiesTableViewCell", for: indexPath) as! HouseFacilitiesTableViewCell
            cell.setupData(facilities: house?.facilities ?? [])
            return cell
        case 5:
            let cell = tableView.dequeueReusableCell(withIdentifier: "HouseGalleryTableViewCell", for: indexPath) as! HouseGalleryTableViewCell
            cell.setupData(photoLinks: house?.imageLinks ?? [])
            cell.delegate = self
            return cell
        case 6:
            let cell = tableView.dequeueReusableCell(withIdentifier: "HouseLocationTableViewCell", for: indexPath) as! HouseLocationTableViewCell
            cell.setupData(address: house?.address ?? "",
                           location: house?.location ?? CLLocation(latitude: 0, longitude: 0))
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
