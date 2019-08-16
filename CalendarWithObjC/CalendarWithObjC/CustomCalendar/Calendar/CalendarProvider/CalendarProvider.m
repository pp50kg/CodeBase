//
//  CalendarProvider.m
//  CathayBank
//
//  Created by Marvin iOS on 2018/9/12.
//  Copyright © 2018年 YuChen Hsu. All rights reserved.
//

#import "CalendarProvider.h"

@implementation CalendarProvider


- (CalendarMonthModel*)getCalendarMonthModel:(NSDate*)date
                                      offset:(NSInteger)offset
{
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components: NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:date];
    
    NSDateComponents *inputDateComponents;
    
    if (offset == 0)
    {
        inputDateComponents = dateComponents;
    }
    else
    {
        NSDate *inputDate = [[NSCalendar currentCalendar] dateByAddingUnit:NSCalendarUnitMonth value:offset toDate:date options:0];
        
        inputDateComponents = [[NSCalendar currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:inputDate];
    }
    
    CalendarMonthModel *model = [CalendarMonthModel new];
    
    [self setMonthModal:model dateComponent:inputDateComponents];
    
    return model;
}

-(void)setMonthModal:(CalendarMonthModel*)monthModel
       dateComponent:(NSDateComponents*)dateComponent
{
    monthModel.dayRange = [self getDayRangeInThisMonth:dateComponent];
    monthModel.weekDayOfFirst = [self getWeekdayOfMonthFirst:dateComponent];
    monthModel.emptyCellCount = [self getEmptyCellCount:dateComponent];
    monthModel.totalItemCount = monthModel.emptyCellCount + monthModel.dayRange;
    // month label 放在 section 內
//    monthModel.monthLabelIndexPath = [self getMonthLabelIndex:dateComponent];
    monthModel.year = [dateComponent year];
    monthModel.month = [dateComponent month];
    
    // Array index 從 0 開始， month number 要減 1
    monthModel.monthLabelString = [[[NSDateFormatter new] monthSymbols] objectAtIndex:[dateComponent month] - 1];
}

- (int)getDayRangeInThisMonth:(NSDateComponents*)dateComponents
{
    
    [dateComponents setDay:1];
    NSDate *date = [[NSCalendar currentCalendar] dateFromComponents:dateComponents];
    NSRange range = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    
    return (int)range.length;
}

- (int)getEmptyCellCount:(NSDateComponents*)dateComponents
{
    int weekDayOfFirst = [self getWeekdayOfMonthFirst:dateComponents];
    return weekDayOfFirst - 1;
}


// month label 放在 section 內
//- (int)getMonthLabelIndex:(NSDateComponents*)dateComponents
//{
//    int weekDayOfFirst = [self getWeekdayOfMonthFirst:dateComponents];
//    return weekDayOfFirst - 1;
//}

- (int)getWeekdayOfMonthFirst:(NSDateComponents*)dateComponents
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *date = [calendar dateFromComponents:dateComponents];
    NSInteger weekDay = [calendar component:NSCalendarUnitWeekday
                                   fromDate:date];
    // Obj-c 裡面, Sunday 設定是 1, Staturday 是 7
    return (int)weekDay;
}

@end
