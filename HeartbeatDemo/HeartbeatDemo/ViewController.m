//
//  ViewController.m
//  HeartbeatDemo
//
//  Created by YuChen Hsu on 2018/7/2.
//  Copyright © 2018年 YuChen Hsu. All rights reserved.
//

#import "ViewController.h"
#import "TimerManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[TimerManager shared] startTimer];
    // Do any additional setup after loading the view, typically from a nib.
}


-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [[TimerManager shared] resetTimer];
    [[TimerManager shared] startTimer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
