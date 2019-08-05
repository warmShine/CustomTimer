//
//  ViewController.m
//  TimerDemo
//
//  Created by L on 2019/8/5.
//  Copyright © 2019 L. All rights reserved.
//

#import "ViewController.h"
#import "LTimer.h"

@interface ViewController ()

@property (nonatomic, strong) NSString *task;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.task = [LTimer executeTask:self
                           selector:@selector(doTask)
                              start:2.0
                           interval:1.0
                            repeats:YES
                              async:NO];
    
    //    self.task = [MJTimer execTask:^{
    //        NSLog(@"111111 - ");
    //    } start:2.0 interval:2 repeats:NO async:NO];
}

- (void)doTask
{
    NSLog(@"doTask - %@", [NSThread currentThread]);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [LTimer cancelTask:self.task];
}

@end
