//
//  TimerManager.h
//  HeartbeatDemo
//
//  Created by YuChen Hsu on 2018/7/3.
//  Copyright © 2018年 YuChen Hsu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TimerManager : NSObject
SINGLETON_FOR_HEADER(TimerManager);

@property (strong, nonatomic) NSTimer *timer;

-(void)startTimer;

-(void)resetTimer;

@end
