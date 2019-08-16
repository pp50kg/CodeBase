//
//  CalendarViewController.h
//  CathayBank
//
//  Created by Marvin iOS on 2018/9/12.
//  Copyright © 2018年 YuChen Hsu. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CalendarProvider.h"
#import "CalendarCollectionViewCell.h"
#import "CalendarHeaderCollectionViewCell.h"
#import "DateGenerator.h"


typedef NS_ENUM(NSUInteger, CalendarType) {
    Start = 1,
    End
};

@protocol CalendarVCDelegate <NSObject>

- (void)calendarDidSelect:(NSDate*)date calendarType:(CalendarType)calendarType;

@optional
- (void)cancelSelectedDate;

@end

@interface CalendarViewController : UIViewController
<UICollectionViewDelegate,
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout> {
    
    NSString *headerIdentifier;
    NSString *cellIdentifier;
    CalendarProvider *calendarProvider;
    NSArray *monthsString;
    NSMutableArray *calendarModels;
    NSMutableArray *selectedIndexes;
    NSDate *selectedDate;
    NSDate *today;
    
    __weak IBOutlet UIView *contentView;
    __weak IBOutlet UIView *shadowView;
}

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *containerTopConstraint;
@property (weak, nonatomic) IBOutlet UILabel *yearLabel;

@property (weak, nonatomic) IBOutlet UILabel *sundayLabel;
@property (weak, nonatomic) IBOutlet UILabel *mondayLabel;
@property (weak, nonatomic) IBOutlet UILabel *tuesdayLabel;
@property (weak, nonatomic) IBOutlet UILabel *wednesdayLabel;
@property (weak, nonatomic) IBOutlet UILabel *thursdayLabel;
@property (weak, nonatomic) IBOutlet UILabel *fridayLabel;
@property (weak, nonatomic) IBOutlet UILabel *saturdayLabel;



@property (weak, nonatomic) IBOutlet UICollectionView *calendarCollectionView;

@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIButton *okButton;

@property (weak, nonatomic) id<CalendarVCDelegate>delegate;
@property (nonatomic) CalendarType calendarType;
@property (strong, nonatomic) NSDate *firstDate;
@property (strong, nonatomic) NSMutableDictionary *customDuration;


#pragma mark - override method
- (NSInteger)maxYear;
- (NSInteger)minYear;

- (CalendarCollectionViewCell *)canbeSelectCell:(CalendarCollectionViewCell *)cell
                                     monthModel:(CalendarMonthModel *)model
                                            day:(NSInteger)day;


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath;

- (void)initCalendar;

@end
