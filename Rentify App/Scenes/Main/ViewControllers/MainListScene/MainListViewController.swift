//
//  MainListViewController.swift
//  Rentify App
//
//  Created by Sanzhar Koshkarbayev on 22.04.2023.
//

import UIKit

class MainListViewController: UIViewController {
    
    @IBOutlet weak var mainTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainTableView.dataSource = self
        mainTableView.delegate = self
        mainTableView.rowHeight = UITableView.automaticDimension
        mainTableView.estimatedRowHeight = 287 + 24 + 12
        
        self.navigationController?.navigationBar.isHidden = true
    }
    
}

extension MainListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderTableViewCell", for: indexPath) as! HeaderTableViewCell
            cell.delegate = self
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "BodyTableViewCell", for: indexPath) as! BodyTableViewCell
            cell.delegate = self
            return cell
        }
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
////        switch indexPath.row {
////        case 0:
////            return 287 + 24 + 12
////        default:
////            return 10 * 309 + 100
////        }
//    }
    
    
}

extension MainListViewController: BodyTableViewCellDelegate {
    func didSelectItemAt() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "HouseViewController")
        self.navigationController?.pushViewController(vc!, animated: true)
    }
}

extension MainListViewController: HeaderTableViewCellDelegate {
    
    func typeRefreshed(to type: SpaceType?, all: Bool) {
        if let cell = mainTableView.cellForRow(at: IndexPath(row: 1, section: 0)) as? BodyTableViewCell {
            cell.listTableView.reloadData()
        }
    }
    
    
}
