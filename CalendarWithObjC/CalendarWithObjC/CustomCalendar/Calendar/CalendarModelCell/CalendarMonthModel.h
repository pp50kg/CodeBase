//
//  CalendarMonthModel.h
//  CathayBank
//
//  Created by Marvin iOS on 2018/9/12.
//  Copyright © 2018年 YuChen Hsu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalendarMonthModel : NSObject

@property (nonatomic) NSInteger weekDayOfFirst;
@property (nonatomic) NSInteger dayRange;
@property (nonatomic) NSInteger emptyCellCount;
@property (nonatomic) NSInteger totalItemCount;
// 這個 project 的 月份寫在 section 內
//@property (nonatomic) NSInteger monthLabelIndexPath;
@property (strong, nonatomic) NSString *monthLabelString;
@property (nonatomic) NSInteger year;
@property (nonatomic) NSInteger month;

@end
