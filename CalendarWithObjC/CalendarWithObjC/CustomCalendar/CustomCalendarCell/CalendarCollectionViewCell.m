//
//  CalendarCollectionViewCell.m
//  CathayBank
//
//  Created by Marvin iOS on 2018/9/13.
//  Copyright © 2018年 YuChen Hsu. All rights reserved.
//

#import "CalendarCollectionViewCell.h"

@implementation CalendarCollectionViewCell

- (void)setSelectedState {
    _dateLabel.hidden = NO;
    _dateLabel.textColor = UIColor.whiteColor;
    _indicateView.hidden = NO;
    CGFloat width = self.frame.size.width;
    _indicateView.layer.cornerRadius = width / 2.0;
    self.statusType = CalendarCollectionViewCellTypeForSelected;
}

- (void)setNormalState {
    _dateLabel.hidden = NO;
    _dateLabel.textColor = UIColor.blackColor;
    _indicateView.hidden = YES;
    self.statusType = CalendarCollectionViewCellTypeForNormal;
}

- (void)setEmptyUI {
    [_dateLabel setHidden:YES];
    _dateLabel.hidden = YES;
    _indicateView.hidden = YES;
}

- (void)setUnableState {
    _dateLabel.hidden = NO;
    _dateLabel.textColor = UIColor.lightGrayColor;
    _indicateView.hidden = YES;
    self.statusType = CalendarCollectionViewCellTypeForUnable;
}

@end
