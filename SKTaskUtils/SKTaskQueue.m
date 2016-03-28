//
//  SKTaskQueue.m
//  SKTaskUtils
//
//  Created by Shin-Kai Chen on 2016/3/26.
//  Copyright © 2016年 SK. All rights reserved.
//

#import "SKTaskQueue.h"

@interface SKTaskQueue ()

@property(nonatomic, strong) SKTask *executing;
@property(nonatomic, strong) SKOrderedDictionary *taskArray;
@property(nonatomic, strong) dispatch_queue_t queue;

- (SKTask *)popTask;
- (void)dispatchTasks;

@end

@implementation SKTaskQueue

- (instancetype)initWithOrderedDictionary:(SKOrderedDictionary *)taskArray {
    self = [super init];
    
    _taskArray = taskArray;
    _suspended = NO;
    _executing = nil;
    
    NSString *bundleIdentifier = [[NSBundle mainBundle] bundleIdentifier];
    _queue = dispatch_queue_create([bundleIdentifier UTF8String], NULL);
    
    return self;
}

- (void)insertTask:(SKTask *)task {
    [_taskArray insertObject:task atIndex:0 forKey:task.name];
    [self dispatchTasks];
}

- (void)addTask:(SKTask *)task {
    [_taskArray addObject:task forKey:task.name];
    [self dispatchTasks];
}

- (void)removeTask:(SKTask *)task {
    [_taskArray removeObjectForKey:task.name];
}

- (void)cancelAllTasks {
    [_taskArray removeAllObjects];
}

- (SKTask *)popTask {
    SKTask *task = [_taskArray objectAtIndex:0];
    if(task) {
        [_taskArray removeObjectForKey:task.name];
    }
    return task;
}

- (void)dispatchTasks {
    if(!_executing) {
        SKTask *firstTask = [self popTask];
        if(firstTask) {
            _executing = firstTask;
            dispatch_async(_queue, ^{
                _executing.block();
                _executing = nil;
                
                [self dispatchTasks];
            });
        }
    }
}

@end
