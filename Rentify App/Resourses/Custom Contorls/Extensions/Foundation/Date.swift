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
    
    init(_ dateString:String) {
        let dateStringFormatter = DateFormatter()
        dateStringFormatter.dateFormat = "yyyy-MM-dd"
        dateStringFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale
        let date = dateStringFormatter.date(from: dateString)!
        self.init(timeInterval:0, since:date)
    }
    
        
}
