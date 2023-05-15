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
}
