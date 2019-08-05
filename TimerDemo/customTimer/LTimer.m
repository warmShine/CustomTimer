//
//  LTimer.m
//  TimerDemo
//
//  Created by L on 2019/8/5.
//  Copyright © 2019 L. All rights reserved.
//

#import "LTimer.h"

@implementation LTimer

static NSMutableDictionary *_timers;
dispatch_semaphore_t _semaphore;

+ (void)initialize {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _timers = [NSMutableDictionary dictionary];
        _semaphore = dispatch_semaphore_create(1);
    });
}

+ (NSString *)executeTask:(void (^)(void))task
                    start:(NSTimeInterval)start
                 interval:(NSTimeInterval)interval
                  repeats:(BOOL)repeats
                    async:(BOOL)async {
    if (!task || start < 0 || (interval <= 0 && repeats)) return nil;
    
    // 创建队列
    dispatch_queue_t queue = async ? dispatch_get_global_queue(0, 0) : dispatch_get_main_queue();
    // 创建定时器
    dispatch_source_t timer =
    dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    // 设置时间
    dispatch_source_set_timer(timer,
                              dispatch_time(DISPATCH_TIME_NOW, start * NSEC_PER_SEC),
                              interval * NSEC_PER_SEC, 0);
    
    
    dispatch_semaphore_wait(_semaphore, DISPATCH_TIME_FOREVER);
    // 定时器的唯一标识
    NSString *name = [NSString stringWithFormat:@"%zd", _timers.count];
    // 存放到字典中
    [_timers setObject:timer forKey:name];
    dispatch_semaphore_signal(_semaphore);
    // 设置回调
    dispatch_source_set_event_handler(timer, ^{
        task();
        if (!repeats) { // 不重复的任务
            [self cancelTask:name];
        }
    });
    // 启动定时器
    dispatch_resume(timer);
    
    return name;
}

+ (NSString *)executeTask:(id)target
                 selector:(SEL)selector
                    start:(NSTimeInterval)start
                 interval:(NSTimeInterval)interval
                  repeats:(BOOL)repeats
                    async:(BOOL)async {
    
    if (!target || !selector) return nil;
    
    return [self executeTask:^{
        if ([target respondsToSelector:selector]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [target performSelector:selector];
#pragma clang diagnostic pop
        }
    } start:start interval:interval repeats:repeats async:async];
}

+ (void)cancelTask:(NSString *)name {
    
    if (name.length == 0) return;
    
    dispatch_semaphore_wait(_semaphore, DISPATCH_TIME_FOREVER);
    
    dispatch_source_t timer = [_timers objectForKey:name];
    if (timer) {
        dispatch_source_cancel(timer);
        [_timers removeObjectForKey:name];
    }
    
    dispatch_semaphore_signal(_semaphore);
}



@end
