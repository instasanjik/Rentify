//
//  BodyTableViewCell.swift
//  Rentify App
//
//  Created by Sanzhar Koshkarbayev on 22.04.2023.
//

import UIKit
import SnapKit

protocol BodyTableViewCellDelegate: AnyObject {
    func didSelectItemAt()
    func didReturnItems(newCount: Int)
}

class BodyTableViewCell: UITableViewCell {
    
    @IBOutlet weak var listTableView: UITableView!
    var delegate: BodyTableViewCellDelegate?
    
    var adType: AdType = .all
    
    var adsForDisplaying: [Ad] = [] {
        didSet {
            listTableView.reloadData()
            listTableView.snp.makeConstraints { make in
                make.height.equalTo(adsForDisplaying.count * 309 + 100)
            }
            delegate?.didReturnItems(newCount: adsForDisplaying.count)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        listTableView.dataSource = self
        listTableView.delegate = self
        listTableView.showsVerticalScrollIndicator = false
        listTableView.isScrollEnabled = false
        
        listTableView.showLoading(style: .medium)
        Server.sharedInstance.getAds(type: adType) { ads in
            self.adsForDisplaying = ads
            CacheManager.shared.ads = ads
            self.listTableView.hideLoading()
//            if sel
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func refreshList() {
        Server.sharedInstance.getAds(type: adType) { ads in
            self.adsForDisplaying = ads
            CacheManager.shared.ads = ads
        }
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

