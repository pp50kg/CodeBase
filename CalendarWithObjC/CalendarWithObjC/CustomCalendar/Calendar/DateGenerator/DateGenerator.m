//
//  DateGenerator.m
//  CathayBank
//
//  Created by Marvin iOS on 2018/9/12.
//  Copyright © 2018年 YuChen Hsu. All rights reserved.
//

#import "DateGenerator.h"

@implementation DateGenerator

+ (NSDate *)getDateFromInt:(NSInteger)year month:(NSInteger)month day:(NSInteger)day {
    
    if (!year || !month || !day) {
        return nil;
    }
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *components = [NSDateComponents new];
    
    components.year = year;
    components.month = month;
    components.day = day;
    components.calendar = calendar;
    
    if (![components isValidDate]) {
        return nil;
    }
    
    NSDate *returnDate = [calendar dateFromComponents:components];
    return returnDate;
}

+ (NSDateComponents *)getDateComponentsFrom:(NSDate *)date {
    
    if (!date) {
        return nil;
    }
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:date];
    
    return components;
    
}

+ (NSArray *)getMonthsNameArray {
    
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
   
    return [dateFormatter shortMonthSymbols];
}

+ (NSString*)getYearString:(NSDate*)date {
    
    if (!date) {
        return nil;
    }
    
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"yyyy"];
    
    return [formatter stringFromDate:date];
}

+ (NSString*)getMonthString:(NSDate *)date {
    
    if (!date) {
        return nil;
    }
    
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"MM"];
    
    return [formatter stringFromDate:date];
    
}

+ (NSString*)getDayString:(NSDate*)date {
    
    if (!date) {
        return nil;
    }
    
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"dd"];
    
    return [formatter stringFromDate:date];
}

@end
