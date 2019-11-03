//
//  DateGenerator.swift
//  CalendarWithSwift
//
//  Created by YuChen Hsu on 2019/7/22.
//  Copyright © 2019 YuChen Hsu. All rights reserved.
//

import Foundation

struct DateGenerator {
    
    static func getDateFrom(year:Int, month:Int, day: Int) -> Date! {
        let calendar = Calendar.autoupdatingCurrent
        
        var components = DateComponents.init()
        components.year = year
        components.month = month
        components.day = day
        components.calendar = calendar
        
        if !components.isValidDate {
            return Date()
        }
        
        let returnDate = calendar.date(from: components)
        
        return returnDate
    }
    
    static func getDateComponentsFrom(date:Date) -> DateComponents {
        
        let units: Set<Calendar.Component> = [.day, .month, .year]
        let components = Calendar.current.dateComponents(units, from: date)
        
        return components
    }
    
    static func getMonthsNameArray() -> [String] {
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        
        return dateFormatter.shortMonthSymbols as [String]
    }
    
    static func getYearString(date:Date) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        
        return dateFormatter.string(from: date)
    }
    
    static func getMonthString(date:Date) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM"
        
        return dateFormatter.string(from: date)
    }
    
    static func getDayString(date:Date) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd"
        
        return dateFormatter.string(from: date)
    }
}
