//
//  Ad.swift
//  Rentify App
//
//  Created by Sanzhar Koshkarbayev on 16.05.2023.
//

import Foundation

class Ad {
    var previewImageLink: String = ""
    var type: String = ""
    var price: String = ""
    var rating: String = ""
    var address: String = ""
    var numberOfBedrooms: String = ""
    var numberOfBathRooms: String = ""
    var area: String = ""
    
    init(previewImageLink: String, type: String, price: String, rating: String, address: String, numberOfBedrooms: String, numberOfBathRooms: String, area: String) {
        self.previewImageLink = previewImageLink
        self.type = type
        self.price = price
        self.rating = rating
        self.address = address
        self.numberOfBedrooms = numberOfBedrooms
        self.numberOfBathRooms = numberOfBathRooms
        self.area = area
    }
}
