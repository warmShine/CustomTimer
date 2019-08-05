//
//  LTimer.h
//  TimerDemo
//
//  Created by L on 2019/8/5.
//  Copyright © 2019 L. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LTimer : NSObject

/**
 设置定时器

 @param task block
 @param start 开始时间
 @param interval 间隔
 @param repeats 是否重复执行
 @param async 是否在子线程开始定时器
 @return 返回定时器名称
 */
+ (NSString *)executeTask:(void(^)(void))task
                    start:(NSTimeInterval)start
                 interval:(NSTimeInterval)interval
                  repeats:(BOOL)repeats
                    async:(BOOL)async;

/**
 设置定时器
 
 @param target  执行者
 @param selector 任务方法
 @param start 开始时间
 @param interval 间隔
 @param repeats 是否重复执行
 @param async 是否在子线程开始定时器
 @return 返回定时器名称
 */
+ (NSString *)executeTask:(id)target
                 selector:(SEL)selector
                    start:(NSTimeInterval)start
                 interval:(NSTimeInterval)interval
                  repeats:(BOOL)repeats
                    async:(BOOL)async;

/**
 取消定时器

 @param name 定时器名称
 */
+ (void)cancelTask:(NSString *)name;


@end

