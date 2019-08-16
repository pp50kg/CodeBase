//
//  ViewController.m
//  CalendarWithObjC
//
//  Created by YuChen Hsu on 2019/7/15.
//  Copyright © 2019 YuChen Hsu. All rights reserved.
//

#import "ViewController.h"
#import "CalendarViewController.h"

@interface ViewController ()<CalendarVCDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self updateStartLabel:[NSDate date]];
    [self updateEndLabel:[NSDate date]];
    // Do any additional setup after loading the view.
}

- (IBAction)openCalendarAction:(id)sender {
    UIButton *btn = (UIButton *)sender;
    CalendarViewController *calendarVC = [CalendarViewController new];
    [calendarVC setDelegate:self];
    [calendarVC setCalendarType:btn.tag];
    [calendarVC setModalPresentationStyle:UIModalPresentationCustom];
    [calendarVC setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    [self presentViewController:calendarVC animated:YES completion:nil];
    
}

#pragma mark - CalendarVCDelegate
- (void)calendarDidSelect:(NSDate*)date calendarType:(CalendarType)calendarType{
    switch (calendarType) {
        case Start:{
            [self updateStartLabel:date];
        }
            break;
        case End:{
            [self updateEndLabel:date];
        }
            break;
        default:
            break;
    }
}

- (void)updateStartLabel:(NSDate*)date {
    
    NSString *yearString = [DateGenerator getYearString:date];
    
    NSString *monthString = [DateGenerator getMonthString:date];
    
    NSString *dayString = [DateGenerator getDayString:date];
    
    [startDateLabel setText:[NSString stringWithFormat:@"%@/%@/%@",yearString,monthString,dayString]];
}

- (void)updateEndLabel:(NSDate*)date {
    
    NSString *yearString = [DateGenerator getYearString:date];
    
    NSString *monthString = [DateGenerator getMonthString:date];
    
    NSString *dayString = [DateGenerator getDayString:date];
    
    [endDateLabel setText:[NSString stringWithFormat:@"%@/%@/%@",yearString,monthString,dayString]];
}

@end
