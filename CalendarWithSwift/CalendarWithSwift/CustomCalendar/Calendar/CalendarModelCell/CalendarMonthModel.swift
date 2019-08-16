//
//  CalendarMonthModel.swift
//  CalendarWithSwift
//
//  Created by YuChen Hsu on 2019/7/22.
//  Copyright © 2019 YuChen Hsu. All rights reserved.
//

import Foundation

struct CalendarMonthModel {
    
    var weekDayOfFirst : NSInteger
    var dayRange : NSInteger
    var emptyCellCount : NSInteger
    var totalItemCount : NSInteger
    // 這個 project 的 月份寫在 section 內
    var monthLabelIndexPath : NSInteger
    var monthLabelString : String
    var year : NSInteger
    var month : NSInteger
}
