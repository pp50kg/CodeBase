//
//  TimerManager.m
//  HeartbeatDemo
//
//  Created by YuChen Hsu on 2018/7/3.
//  Copyright © 2018年 YuChen Hsu. All rights reserved.
//

#import "TimerManager.h"
#import <UIKit/UIKit.h>

@implementation TimerManager
{
    int timeCount;
}
SINGLETON_FOR_CLASS(TimerManager);

- (instancetype)init
{
    if (self = [super init])
    {

    }
    return self;
}

-(void)startTimer
{
    timeCount = 0;
    // 创建NSTimer對象
    _timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(timerAction:) userInfo:nil repeats:YES];
    // 加入RunLoop中
    [[NSRunLoop mainRunLoop] addTimer:_timer forMode: NSRunLoopCommonModes];
    [_timer fire];
}

-(void)resetTimer
{
    [_timer invalidate];
}

- (void)timerAction:(NSTimer *)sender {
    NSLog(@"NSTimer: %d",timeCount);
    if (timeCount%5==0&&timeCount!=0) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"登出" message:@"閒置5秒" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"確認" style:UIAlertActionStyleCancel handler:nil];
        [alertController addAction:cancelAction];
        
        UIWindow *keyWindow = [[UIApplication sharedApplication]keyWindow];
        UIViewController *mainController = [keyWindow rootViewController];
        [mainController presentViewController:alertController animated:YES completion:nil];
    }
    timeCount++;
}

@end
