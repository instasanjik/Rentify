//
//  SearchViewController.swift
//  Rentify App
//
//  Created by Sanzhar Koshkarbayev on 13.05.2023.
//

import Foundation
import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var tableViewHeigth: NSLayoutConstraint!
    
    enum SpaceType {
        case house
        case aparts
        case dacha
        case room
        
        func getCriterias() -> [String] {
            switch self {
            case .house:
                return ["Budget", "The area of the adjacent plot", "Size", "Facilities", "With photo", "Number of floors", "Number of bedrooms", "Number of rooms", "Number of restroom", "Accessibility"]
            case .aparts:
                return ["Budget", "Size", "Facilities", "With photo", "Floor between", "Number of bedrooms", "Number of rooms", "Number of restroom", "Accessibility"]
            case .dacha:
                return ["Budget", "Size", "The area of the adjacent plot", "Garden", "Facilities", "With photo", "Number of floors", "Number of bedrooms", "Number of rooms", "Number of restroom", "Accessibility"]
            case .room:
                return ["Budget", "Size", "Facilities", "With photo",  "Accessibility"]
            }
        }
    }
    
    var type: SpaceType = .house {
        didSet {
            criterias = type.getCriterias()
        }
    }
    var criterias: [String] = [] {
        didSet {
            tableView.reloadData()
            tableViewHeigth.constant = CGFloat(criterias.count * 44)
            
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        criterias = type.getCriterias()
    }
    
    
    @IBAction func spaceTypeChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0: type = .house
        case 1: type = .aparts
        case 2: type = .dacha
        case 3: type = .room
        default: ()
        }
    }
    
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return criterias.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if criterias[indexPath.row] != "With photo" {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CriteriaTableViewCellString", for: indexPath) as! CriteriaTableViewCellString
            cell.nameLabel.text = criterias[indexPath.row]
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CriteriaTableViewCellBool", for: indexPath) as! CriteriaTableViewCellBool
            cell.nameLabel.text = criterias[indexPath.row]
            return cell
        }
    }
    
    
}
