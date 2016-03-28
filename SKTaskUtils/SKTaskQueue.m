//
//  SKTaskQueue.m
//  SKTaskUtils
//
//  Created by Shin-Kai Chen on 2016/3/26.
//  Copyright © 2016年 SK. All rights reserved.
//

#import "SKTaskQueue.h"

@interface SKTaskQueue ()

@property(nonatomic, strong) NSMutableArray *taskArray;
@property(nonatomic, strong) dispatch_queue_t queue;

@end

@implementation SKTaskQueue

- (instancetype)initWithMutableArray:(NSMutableArray *)taskArray {
    self = [super init];
    
    _taskArray = taskArray;
    _suspended = NO;
    
    NSString *bundleIdentifier = [[NSBundle mainBundle] bundleIdentifier];
    _queue = dispatch_queue_create([bundleIdentifier UTF8String], NULL);
    
    return self;
}

- (void)insertTask:(SKTask *)task {
    [_taskArray insertObject:task atIndex:0];
}

- (void)addTask:(SKTask *)task {
    [_taskArray addObject:task];
}

- (void)cancelAllTasks {
    [_taskArray removeAllObjects];
}

@end
