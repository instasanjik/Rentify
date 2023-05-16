//
//  Date.swift
//  ARnums
//
//  Created by Sanzhar Koshkarbayev on 01.01.2023.
//

import Foundation

extension Date {
    
    static var dateTime: String {
        get {
            return Date.now.ISO8601Format()
        }
    }
    
    var dayOfWeek: String {
        get {
            let weekDayNamesShort = ["Sn", "Mn", "Tu", "Wd", "Th", "Fr", "St"]
            let dayNumber = Calendar.current.dateComponents([.weekday], from: self).weekday
            guard let dayNumber = dayNumber else { return "" }
            return weekDayNamesShort[dayNumber-1]
        }
    }
    
    init(_ dateString: String) {
        let dateStringFormatter = DateFormatter()
        dateStringFormatter.dateFormat = "yyyy-MM-dd"
        dateStringFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale
        let date = dateStringFormatter.date(from: dateString)!
        self.init(timeInterval:0, since:date)
    }
    
    init(timeStamp: String) {
        let dateStringFormatter = DateFormatter()
        dateStringFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        dateStringFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        let date = dateStringFormatter.date(from: timeStamp)!
        self.init(timeIntervalSince1970: date.timeIntervalSince1970)
    }
    
        
}
