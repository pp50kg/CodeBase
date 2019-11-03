//
//  CalendarProvider.swift
//  CalendarWithSwift
//
//  Created by YuChen Hsu on 2019/7/25.
//  Copyright © 2019 YuChen Hsu. All rights reserved.
//

import Foundation

struct CalendarProvider {
//    let selectedDate1 : DateComponents
//    let selectedDate2 : DateComponents
    
    func getCalendarMonthModel(date:Date, offset:NSInteger) -> CalendarMonthModel {
        let dateComponents = Calendar.current.dateComponents([Calendar.Component.year,Calendar.Component.month,Calendar.Component.day], from: date)
        
        var inputDateComponents : DateComponents
        
        if offset == 0 {
            inputDateComponents = dateComponents
        }else{
            let inputDate:Date = Calendar.current.date(byAdding: Calendar.Component.month, value: offset, to: date)!
            
            inputDateComponents = Calendar.current.dateComponents([Calendar.Component.year,Calendar.Component.month,Calendar.Component.day], from: inputDate)
        }
        
        var model = CalendarMonthModel.init(weekDayOfFirst: 0, dayRange: 0, emptyCellCount: 0, totalItemCount: 0, monthLabelIndexPath: 0, monthLabelString: "", year: 0, month: 0)
        
        self.setMonthModal(monthModel: &model, dateComponent: inputDateComponents)
        
        return model
        
        
    }
    
    func setMonthModal(monthModel:inout CalendarMonthModel,dateComponent:DateComponents){
        var inputDateComponents = dateComponent
        
        monthModel.dayRange = self.getDayRangeInThisMonth(dateComponents:&inputDateComponents)
        monthModel.weekDayOfFirst = self.getWeekdayOfMonthFirst(dateComponents: inputDateComponents)
        monthModel.emptyCellCount = self.getEmptyCellCount(dateComponents: inputDateComponents)
        monthModel.totalItemCount = monthModel.emptyCellCount + monthModel.dayRange
//        monthModel.monthLabelIndexPath = self.getMonthLabelIndex(dateComponents: dateComponent)
        monthModel.year = inputDateComponents.year!
        monthModel.month = inputDateComponents.month!
        // Array index 從 0 開始， month number 要減 1
        monthModel.monthLabelString = DateFormatter.init().monthSymbols[inputDateComponents.month!-1]
    }
    
    func getDayRangeInThisMonth (dateComponents: inout DateComponents) -> Int!{
        
        dateComponents.day = 1
        let date = Calendar.current.date(from: dateComponents)
        
        let range = Calendar.current.range(of: Calendar.Component.day, in: Calendar.Component.month, for: date!)
        return range?.count
    }

    func getWeekdayOfMonthFirst (dateComponents:DateComponents) -> Int!{
        
        let date = Calendar.current.date(from: dateComponents)
        
        let weekDay = Calendar.current.component(Calendar.Component.weekday, from: date!)
        
        return weekDay
    }
    
    // month label 放在 section 內
    func getMonthLabelIndex (dateComponents:DateComponents) -> Int!{

        let weekDayOfFirst = self.getWeekdayOfMonthFirst(dateComponents: dateComponents) - 1

        return weekDayOfFirst
    }
    
    func getEmptyCellCount (dateComponents:DateComponents) -> Int!{
        
        let weekDayOfFirst:Int = self.getWeekdayOfMonthFirst(dateComponents: dateComponents)
        
        return weekDayOfFirst - 1
    }
}
