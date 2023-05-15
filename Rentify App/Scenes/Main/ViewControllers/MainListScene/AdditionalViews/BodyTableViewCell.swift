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
    
    var adsForDisplaying: [Ad] = []

    override func awakeFromNib() {
        super.awakeFromNib()
        listTableView.dataSource = self
        listTableView.delegate = self
        listTableView.showsVerticalScrollIndicator = false
        listTableView.isScrollEnabled = false
        
        listTableView.showLoading(style: .medium)
        Server.sharedInstance.getAds(type: .all) { ads in
            self.adsForDisplaying = ads
            CacheManager.shared.ads = ads
            self.listTableView.hideLoading()
//            if sel
        }
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

