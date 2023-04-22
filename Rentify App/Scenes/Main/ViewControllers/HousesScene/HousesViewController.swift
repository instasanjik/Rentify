//
//  HousesViewController.swift
//  Rentify App
//
//  Created by Sanzhar Koshkarbayev on 22.04.2023.
//

import UIKit

class HousesViewController: UIViewController {

    @IBOutlet weak var housesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        housesTableView.delegate = self
        housesTableView.dataSource = self

        // Do any additional setup after loading the view.
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
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 265
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HouseTableViewCell", for: indexPath) as! HouseTableViewCell
        if indexPath.row == 0 {
            cell.houseImageView.image = UIImage(named: "Houses_With_Left")
        } else {
            cell.houseImageView.image = UIImage(named: "Houses_With_Left1")
        }
        return cell
    }
    
    
}

