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

@end

@implementation SKTaskQueue

- (instancetype)initWithMutableArray:(NSMutableArray *)taskArray {
    self = [super init];
    
    _taskArray = taskArray;
    
    return self;
}

- (void)addTask:(SKTask *)task {
    [_taskArray addObject:task];
}

@end
