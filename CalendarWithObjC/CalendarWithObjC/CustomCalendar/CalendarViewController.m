//
//  CalendarViewController.m
//  CathayBank
//
//  Created by Marvin iOS on 2018/9/12.
//  Copyright © 2018年 YuChen Hsu. All rights reserved.
//

#import "CalendarViewController.h"


@interface CalendarViewController ()

@end

@implementation CalendarViewController

@synthesize delegate, calendarType, firstDate, customDuration;

- (void)viewDidLoad {
    [super viewDidLoad];
    monthsString = [NSArray new];
    calendarModels = [NSMutableArray new];
    selectedIndexes = [NSMutableArray new];
    today = [NSDate date];
    
    if (customDuration && customDuration.count > 0) {
        // 有選擇過日期
        if (customDuration.count == 2) {
            // 起迄都選過了,依照進入點
            
            NSDate *startDate = customDuration[@"start"];
            NSDate *endDate = customDuration[@"end"];
            
            if (calendarType == Start && startDate) {
                firstDate = startDate;
            }
            else {
                firstDate = endDate;
            }
        }
        else {
            //只選過一個
            
            NSArray *keys = customDuration.allKeys;
            firstDate = customDuration[keys[0]];
        }
        
    }
    else {
        // 如果沒有選擇,就從今天
        firstDate = [NSDate date];
    }
    
    [self registerCell];
    [self setupUI];
    
    calendarProvider = [CalendarProvider new];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.calendarCollectionView reloadData];
    [self initCalendar];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    // 防止跑版
    if (@available(iOS 11.0, *)) {
        _containerTopConstraint.constant = 57.0;
    }
    else {
        _containerTopConstraint.constant = 77.0;
    }
    
    [self.view layoutIfNeeded];
}

#pragma mark - Setup UI
- (void)registerCell {
    
    cellIdentifier = @"DateCell";
    [_calendarCollectionView registerNib:[UINib nibWithNibName:@"CalendarCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:cellIdentifier];
    
    headerIdentifier = @"HeaderCell";
    [_calendarCollectionView registerNib:[UINib nibWithNibName:@"CalendarHeaderCollectionViewCell" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerIdentifier];
}

- (void)setupUI {
    [_cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
    [_okButton setTitle:@"Confirm" forState:UIControlStateNormal];
    [_sundayLabel setText:@"Sun"];
    [_mondayLabel setText:@"Mon"];
    [_tuesdayLabel setText:@"Tue"];
    [_wednesdayLabel setText:@"Wed"];
    [_thursdayLabel setText:@"Thu"];
    [_fridayLabel setText:@"Fri"];
    [_saturdayLabel setText:@"Sat"];
    
    _cancelButton.layer.borderWidth = 1.0;
    _cancelButton.layer.borderColor = [UIColor colorWithRed:0.0f/255.0f green:158.0f/255.0f blue:73.0f/255.0f alpha:1.0f].CGColor;
    
    shadowView.layer.shadowRadius  = 5;
    shadowView.layer.shadowColor   = [UIColor blackColor].CGColor;
    shadowView.layer.shadowOffset  = CGSizeMake(0.0f, 0.0f);
    shadowView.layer.shadowOpacity = 0.1f;
    shadowView.layer.masksToBounds = NO;
    
    UIEdgeInsets shadowInsets     = UIEdgeInsetsMake(0, 0, -1.5f, 0);
    UIBezierPath *shadowPath      = [UIBezierPath bezierPathWithRect:UIEdgeInsetsInsetRect(shadowView.bounds, shadowInsets)];
    shadowView.layer.shadowPath    = shadowPath.CGPath;
    
}


#pragma mark - Override method
- (NSInteger)maxYear {
    return NSIntegerMax;
}

- (NSInteger)minYear {
    return 1975;
}

- (CalendarCollectionViewCell *)canbeSelectCell:(CalendarCollectionViewCell *) cell
                                     monthModel:(CalendarMonthModel *) model
                                            day:(NSInteger) day {
    //child class canbe override method
    //implement on child class
    [cell setUserInteractionEnabled:YES];
    [cell setNormalState];
    return cell;
}

//- (CalendarCollectionViewCell *)canbeSelectCell:(CalendarCollectionViewCell *)cell
//                                     monthModel:(CalendarMonthModel *)model
//                                            day:(NSInteger)day {
//    NSDate *dateAtCell = [DateGenerator getDateFromInt:model.year month:model.month day:day];
//
//    // 這邊處理起迄不同要反灰的 UI
//
//    NSDate *compareDate;
//    NSDate *threeMonthLimit;
//    NSDate *oneYearLimit = [[NSCalendar currentCalendar] dateByAddingUnit:NSCalendarUnitMonth value:-12 toDate:today options:0];
//
//    if (self.calendarType == Start) {
//
//        if (self.customDuration[@"end"]) {
//            compareDate = self.customDuration[@"end"];
//            threeMonthLimit = [[NSCalendar currentCalendar] dateByAddingUnit:NSCalendarUnitMonth value:-3 toDate:compareDate options:0];
//        }
//        else
//        {
//            compareDate = self.firstDate;
//        }
//
//        //        if ([dateAtCell compare:compareDate] == NSOrderedDescending && self.customDuration.count > 0) {
//        //            // 在起始日之前,灰色且不能選
//        //            [cell setUserInteractionEnabled:NO];
//        //            [cell setUnableState];
//        //        }
//        //        else if ([dateAtCell compare:today] == NSOrderedDescending) {
//        //            // 在今天之後的日期不能選
//        //            [cell setUserInteractionEnabled:NO];
//        //            [cell setUnableState];
//        //        }
//        //        else if (threeMonthLimit && [dateAtCell compare:threeMonthLimit] == NSOrderedAscending) {
//        //            // 超過迄日前三個月,灰色且不能選
//        //            [cell setUserInteractionEnabled:NO];
//        //            [cell setUnableState];
//        //        }
//        //        else if (oneYearLimit && [dateAtCell compare:oneYearLimit] == NSOrderedAscending) {
//        //            // 超過當日前一年,灰色且不能選
//        //            [cell setUserInteractionEnabled:NO];
//        //            [cell setUnableState];
//        //        }
//        //        else {
//        [cell setUserInteractionEnabled:YES];
//        [cell setNormalState];
//        //        }
//    }
//    else {
//
//        if (self.customDuration[@"start"]) {
//            compareDate = self.customDuration[@"start"];
//            threeMonthLimit = [[NSCalendar currentCalendar] dateByAddingUnit:NSCalendarUnitMonth value:3 toDate:compareDate options:0];
//        }
//        else {
//            compareDate = self.firstDate;
//        }
//
//        //        if ([dateAtCell compare:compareDate] == NSOrderedAscending && self.customDuration.count > 0) {
//        //            // 在迄日之後,灰色且不能選
//        //            [cell setUserInteractionEnabled:NO];
//        //            [cell setUnableState];
//        //        }
//        //        else if (threeMonthLimit && [dateAtCell compare:threeMonthLimit] == NSOrderedDescending) {
//        //            [cell setUserInteractionEnabled:NO];
//        //            [cell setUnableState];
//        //        }
//        //        else if (oneYearLimit && [dateAtCell compare:oneYearLimit] == NSOrderedAscending) {
//        //            // 超過當日前一年,灰色且不能選
//        //            [cell setUserInteractionEnabled:NO];
//        //            [cell setUnableState];
//        //        }
//        //        else if ([dateAtCell compare:today] == NSOrderedDescending) {
//        //            // 在今天之後的日期不能選
//        //            [cell setUserInteractionEnabled:NO];
//        //            [cell setUnableState];
//        //        }
//        //        else {
//        [cell setUserInteractionEnabled:YES];
//        [cell setNormalState];
//        //        }
//    }
//
//    return cell;
//}

#pragma mark - UICollectionViewFlowlayoutDelegate
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(_calendarCollectionView.frame.size.width, 50.0);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0.0f;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0.0f;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat itemWidth = _calendarCollectionView.frame.size.width / 7.0;
    
    CGFloat itemHeight = itemWidth;
    
    return CGSizeMake(itemWidth, itemHeight);
}

#pragma mark - CollectionView Delegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CalendarCollectionViewCell *cell = (CalendarCollectionViewCell*)[collectionView cellForItemAtIndexPath:indexPath];
    
    if ([selectedIndexes containsObject:indexPath]&&selectedIndexes.count!=0) {
        [cell setNormalState];
        [selectedIndexes removeObject:indexPath];
        selectedDate = nil;
    }
    else {
        // 只讓使用者選 1 點
        if (selectedIndexes.count > 0) {
            NSIndexPath *previousIndex = [selectedIndexes firstObject];
            
            if ([_calendarCollectionView.indexPathsForVisibleItems containsObject:previousIndex]) {
                CalendarCollectionViewCell *previousCell = (CalendarCollectionViewCell*)[collectionView cellForItemAtIndexPath:previousIndex];
                [previousCell setNormalState];
            }
            
            [selectedIndexes removeAllObjects];
            [selectedIndexes addObject:indexPath];
            [cell setSelectedState];
        }
        else {
            [selectedIndexes addObject:indexPath];
            [cell setSelectedState];
        }
    }
    
    CalendarMonthModel *monthModel = calendarModels[indexPath.section];
    
    NSInteger dayInt = [cell.dateLabel.text integerValue];
    
    if (monthModel && dayInt) {
        selectedDate = [DateGenerator getDateFromInt:monthModel.year month:monthModel.month day:dayInt];
    }
        
        // 下面是要選 2 點的邏輯,未來如果確定了就打開
//        if (selectedIndexes.count > 2) {
//            NSArray *sortedArray = [selectedIndexes sortedArrayUsingSelector:@selector(compare:)];
//            selectedIndexes = [NSMutableArray arrayWithArray:sortedArray];
//            NSIndexPath *lastIndexPath = [selectedIndexes lastObject];
//
//            NSIndexPath *deselectIndexPath;
        
            // 有可能 UI 邏輯還會更改,之後再修
//            if (indexPath == lastIndexPath) {
//                // 最後一個點擊 index 在前兩點之後,則移掉中間那個 index 為 1 的
//                deselectIndexPath = [sortedArray objectAtIndex:1];
//            }
//            else if (indexPath == [selectedIndexes firstObject]) {
//                // 最後一個點擊的在 index 之前,則移掉最後面那個
//                deselectIndexPath = lastIndexPath;
//            }
//            else {
//                // 最後一個點擊的,在兩者之間,則移掉最後一個
//                deselectIndexPath = lastIndexPath;
//            }
//
//            [selectedIndexes removeObject:deselectIndexPath];
//
//            if ([_calendarCollectionView.indexPathsForVisibleItems containsObject:deselectIndexPath]) {
//                CalendarCollectionViewCell *deselectCell = (CalendarCollectionViewCell*)[collectionView cellForItemAtIndexPath:deselectIndexPath];
//                [deselectCell setNormalState];
//            }1
//    }
}

#pragma mark - CollectionView DataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return calendarModels.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    if (!calendarModels || calendarModels.count == 0) {
        return 0;
    }
    
    CalendarMonthModel *monthModel = [calendarModels objectAtIndex:section];
    
    return monthModel.totalItemCount;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    if (kind == UICollectionElementKindSectionHeader) {
        
        id header = [_calendarCollectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerIdentifier forIndexPath:indexPath];
        
        CalendarHeaderCollectionViewCell *headerCell = (CalendarHeaderCollectionViewCell*)header;
        
        NSString *month = [monthsString objectAtIndex:indexPath.section];
        
        if (month) {
//            
//            month = [month stringByReplacingOccurrencesOfString:@"月" withString:GetStringWithKey(@"月")];
            headerCell.monthLabel.text = month;
        }
        
        return (UICollectionReusableView*)headerCell;
        
    }
    
    return nil;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CalendarCollectionViewCell *cell = [_calendarCollectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    CalendarMonthModel *monthModel = [calendarModels objectAtIndex:indexPath.section];
    
    NSInteger row = indexPath.row;
    NSInteger emptyCount = monthModel.emptyCellCount;
    
    cell.dateLabel.text = @"";
    
    if (row < monthModel.emptyCellCount) {
        [cell setEmptyUI];
        [cell setUserInteractionEnabled:NO];
    }
    else {
        NSInteger day = indexPath.row - emptyCount + 1;
        
        cell.dateLabel.text = [NSString stringWithFormat:@"%ld", (long)day];
        
        [self canbeSelectCell:cell monthModel:monthModel day:day];
        NSDate *dateAtCell = [DateGenerator getDateFromInt:monthModel.year month:monthModel.month day:day];
        
        //讀取預設日期
        NSString *dateKey = self.calendarType == Start? @"start":@"end";
        
        if ([self isEqualDay:dateAtCell CompareDate: customDuration[dateKey]] &&
            selectedIndexes.count == 0 &&
            ![selectedIndexes containsObject:indexPath]) {
            [selectedIndexes removeAllObjects];
            [selectedIndexes addObject:indexPath];
        }
        
        if (cell.statusType == CalendarCollectionViewCellTypeForNormal && [selectedIndexes containsObject:indexPath]) {
            [cell setSelectedState];
        }
    }
    return cell;
}

- (BOOL)isEqualDay:(NSDate *)data CompareDate:(NSDate *)compareDate {
    if (data == nil || compareDate == nil) {
        return NO;
    }
    
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *components = [cal components:(NSCalendarUnitEra | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:data];
    NSDate *_date = [cal dateFromComponents:components];
    components = [cal components:(NSCalendarUnitEra | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:compareDate];
    NSDate *_compareDate = [cal dateFromComponents:components];
    return [_date isEqualToDate:_compareDate];
}

#pragma mark - Date Method
- (void)initCalendar {
    
    monthsString = [DateGenerator getMonthsNameArray];
    
    if (!firstDate) {
        firstDate = [NSDate date];
    }
    
    NSDateComponents *components = [DateGenerator getDateComponentsFrom:firstDate];
    
    NSInteger year = components.year;
    
    [self reloadCalendarModels:year];
}

- (void)reloadCalendarModels:(NSInteger)year {
    
    NSDate *firstDate = [DateGenerator getDateFromInt:year month:1 day:1];
    
    self.yearLabel.text = [NSString stringWithFormat:@"%ld", year];
    
    [calendarModels removeAllObjects];
    
    for (int i = 0; i < 12; i++) {
        CalendarMonthModel *model = [calendarProvider getCalendarMonthModel:firstDate offset:i];
        [calendarModels addObject:model];
    }
    
    [_calendarCollectionView reloadData];
    int monthInt = [[DateGenerator getMonthString:[NSDate date]] intValue]-1;
    NSUInteger indexs2[] = {monthInt, 1};
    NSIndexPath *datePath = [NSIndexPath indexPathWithIndexes:indexs2 length:2];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.calendarCollectionView scrollToItemAtIndexPath:datePath
                                        atScrollPosition:UICollectionViewScrollPositionTop
                                                animated:YES];
    });
    
}

#pragma mark - Btn Action

- (IBAction)lastYearButtonTapped:(id)sender {
    
    CalendarMonthModel *firstModel = [calendarModels firstObject];
    
    NSInteger currentYear = firstModel.year;
    
    if (currentYear > [self minYear]) {
        currentYear -= 1;
        [self reloadCalendarModels:currentYear];
    }
    
}

- (IBAction)nextYearButtonTapped:(id)sender {
    
    CalendarMonthModel *firstModel = [calendarModels firstObject];

    NSInteger currentYear = firstModel.year;
    
//    if ([self maxYear] > currentYear) {
        currentYear += 1;
        [self reloadCalendarModels: currentYear];
//    }
    
}

- (IBAction)cancelButtonTapped:(id)sender {
    if (delegate && [delegate respondsToSelector: @selector(cancelSelectedDate)]) {
        [delegate cancelSelectedDate];
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (IBAction)okButtonTapped:(id)sender {
    
    // 沒選到要不要發動?
    if (delegate && selectedDate) {
        [delegate calendarDidSelect:selectedDate calendarType:calendarType];
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
