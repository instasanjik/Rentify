//
//  RentedPromise.swift
//  Rentify App
//
//  Created by Sanzhar Koshkarbayev on 15.05.2023.
//

import Foundation

class RentedPromise {
    var timeLeft: String = ""
    var previewImageLink: String = ""
    var additionalInfo: String = ""
    var address: String = ""
    var region: String = ""
    
    init(timeLeft: String, previewImageLink: String, additionalInfo: String, address: String, region: String) {
        self.timeLeft = timeLeft
        self.previewImageLink = previewImageLink
        self.additionalInfo = additionalInfo
        self.address = address
        self.region = region
    }
}
