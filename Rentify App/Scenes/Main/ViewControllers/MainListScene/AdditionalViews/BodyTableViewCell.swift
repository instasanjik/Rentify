//
//  BodyTableViewCell.swift
//  Rentify App
//
//  Created by Sanzhar Koshkarbayev on 22.04.2023.
//

import UIKit

protocol BodyTableViewCellDelegate: AnyObject {
    func didSelectItemAt()
}

class Ad {
    var previewImageLink: String = ""
    var type: String = ""
    var price: String = ""
    var rating: String = ""
    var address: String = ""
    var numberOfBedrooms: String = ""
    var numberOfBathRooms: String = ""
    var area: String = ""
    
    init(previewImageLink: String, type: String, price: String, rating: String, address: String, numberOfBedrooms: String, numberOfBathRooms: String) {
        self.previewImageLink = previewImageLink
        self.type = type
        self.price = price
        self.rating = rating
        self.address = address
        self.numberOfBedrooms = numberOfBedrooms
        self.numberOfBathRooms = numberOfBathRooms
    }
}

class BodyTableViewCell: UITableViewCell {
    
    @IBOutlet weak var listTableView: UITableView!
    var delegate: BodyTableViewCellDelegate?
    
    var adsForDisplaying: [Ad] = []

    override func awakeFromNib() {
        super.awakeFromNib()
        listTableView.dataSource = self
        listTableView.delegate = self
        listTableView.showsVerticalScrollIndicator = false
        listTableView.isScrollEnabled = false
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}

extension BodyTableViewCell: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return adsForDisplaying.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 309
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AdTableViewCell", for: indexPath) as! AdTableViewCell
        cell.setupData(ad: adsForDisplaying[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelectItemAt()
    }
    
    
}

