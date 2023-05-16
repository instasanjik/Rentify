//
//  HouseFull.swift
//  Rentify App
//
//  Created by Sanzhar Koshkarbayev on 17.05.2023.
//

import Foundation
import CoreLocation

class HouseFull {
    // header
    var imageLink: String = ""
    
    // price cell
    var id: String = ""
    var price: String = ""
    var reviews: String = ""
    var address: String = ""
    
    
    // landlord's cell
    var landlord: Landlord? = nil
    var overview: String = ""
    
    // calendar's cell
    var busyDates: [Date] = []
    
    // facilities cell
    var facilities: [String] = []
    
    // gallery
    var imageLinks: [String] = []
    
    // location
    var location = CLLocation(latitude: 0, longitude: 0)
    
    init(imageLink: String, id: String, price: String, reviews: String, address: String, landlord: Landlord, overview: String, busyDates: [Date], facilities: [String], imageLinks: [String], location: CLLocation) {
        self.imageLink = imageLink
        self.id = id
        self.price = price
        self.reviews = reviews
        self.landlord = landlord
        self.overview = overview
        self.busyDates = busyDates
        self.facilities = facilities
        self.imageLinks = imageLinks
        self.location = location
    }
}
