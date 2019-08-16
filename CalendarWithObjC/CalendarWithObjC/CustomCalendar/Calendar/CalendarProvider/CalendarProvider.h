//
//  CalendarProvider.h
//  CathayBank
//
//  Created by Marvin iOS on 2018/9/12.
//  Copyright © 2018年 YuChen Hsu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CalendarMonthModel.h"

@interface CalendarProvider : NSObject

@property (strong, nonatomic) NSDateComponents *selectedDate1;
@property (strong, nonatomic) NSDateComponents *selectedDate2;

- (CalendarMonthModel*)getCalendarMonthModel:(NSDate*)date offset:(NSInteger)offset;

@end
