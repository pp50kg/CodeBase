//
//  CalendarCollectionViewCell.h
//  CathayBank
//
//  Created by Marvin iOS on 2018/9/13.
//  Copyright © 2018年 YuChen Hsu. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSUInteger, CalendarCollectionViewCellType) {
    CalendarCollectionViewCellTypeForUnable = 0,
    CalendarCollectionViewCellTypeForNormal = 1,
    CalendarCollectionViewCellTypeForSelected = 2
};

@interface CalendarCollectionViewCell : UICollectionViewCell
@property (assign, nonatomic) CalendarCollectionViewCellType statusType;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIView *indicateView;

- (void)setSelectedState;

- (void)setNormalState;

- (void)setEmptyUI;

- (void)setUnableState;

@end
