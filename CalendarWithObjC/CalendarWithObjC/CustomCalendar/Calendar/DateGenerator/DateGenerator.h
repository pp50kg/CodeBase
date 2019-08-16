//
//  DateGenerator.h
//  CathayBank
//
//  Created by Marvin iOS on 2018/9/12.
//  Copyright © 2018年 YuChen Hsu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateGenerator : NSObject

+ (NSDate*)getDateFromInt:(NSInteger)year month:(NSInteger)month day:(NSInteger)day;

+ (NSDateComponents*)getDateComponentsFrom:(NSDate*)date;

+ (NSArray*)getMonthsNameArray;

+ (NSString*)getYearString:(NSDate*)date;

+ (NSString*)getMonthString:(NSDate*)date;

+ (NSString*)getDayString:(NSDate*)date;

@end
