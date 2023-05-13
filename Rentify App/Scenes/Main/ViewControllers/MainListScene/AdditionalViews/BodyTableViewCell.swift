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

class BodyTableViewCell: UITableViewCell {
    
    @IBOutlet weak var listTableView: UITableView!
    var delegate: BodyTableViewCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        listTableView.dataSource = self
        listTableView.delegate = self
        listTableView.showsVerticalScrollIndicator = false
        listTableView.isScrollEnabled = false
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension BodyTableViewCell: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 309
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AdTableViewCell", for: indexPath) as! AdTableViewCell
        cell.houseImageView.image = UIImage(named: "House-\(Int.random(in: 1...9))")
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelectItemAt()
    }
    
    
}

