//
//  User.swift
//  Rentify App
//
//  Created by Sanzhar Koshkarbayev on 15.05.2023.
//

import Foundation


enum Metric {
    case usd
    case kzt
    case rub
    
    func getAbbr() -> String {
        switch self {
        case .usd:
            return "USD"
        case .kzt:
            return "KZT"
        case .rub:
            return "RUB"
        }
    }
}

class User {
    static let shared = User()
    
    var email: String? = nil
    var avatarLink: String? = nil
    var userName: String? = nil
    var metric: Metric = .usd {
        didSet {
            Server.sharedInstance.setCurrentCurrency(need: metric)
        }
    }
    
    init(email: String? = nil, avatarLink: String? = nil, userName: String? = nil) {
        self.email = email
        self.avatarLink = avatarLink
        self.userName = userName
    }
}
