//
//  FavoritePromise.swift
//  Rentify App
//
//  Created by Sanzhar Koshkarbayev on 15.05.2023.
//

import Foundation

class FavoritePromise {
    var previewLink: String = ""
    var price: String = ""
    var additionalInfo: String = ""
    var address: String = ""
    var region: String = ""
    var landlordPhoneNumber: String = ""
    var landlordEmail: String = ""
    
    
    init(previewLink: String, price: String, additionalInfo: String, address: String, region: String, landlordPhoneNumber: String, landlordEmail: String) {
        self.previewLink = previewLink
        self.price = price
        self.additionalInfo = additionalInfo
        self.address = address
        self.region = region
        self.landlordPhoneNumber = landlordPhoneNumber
        self.landlordEmail = landlordEmail
    }
}
