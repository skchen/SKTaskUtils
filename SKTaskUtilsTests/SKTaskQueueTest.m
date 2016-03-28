//
//  SKTaskQueueTest.m
//  SKTaskUtils
//
//  Created by Shin-Kai Chen on 2016/3/26.
//  Copyright © 2016年 SK. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "SKTaskQueue.h"

@import OCMockito;

@interface SKTaskQueueTest : XCTestCase

@property(nonatomic, strong) SKTaskQueue *taskQueue;

@property(nonatomic, strong) SKOrderedDictionary *taskArray;
@property(nonatomic, strong) SKTask *task;
@property(nonatomic, strong) SKTask *mockTask1;
@property(nonatomic, strong) SKTask *mockTask2;

@end

static NSString *const kTaskName1 = @"Test Task 1";
static NSString *const kTaskName2 = @"Test Task 2";

@implementation SKTaskQueueTest

- (void)setUp {
    [super setUp];
    
    _taskArray = [[SKOrderedDictionary alloc] init];
    
    _mockTask1 = mock([SKTask class]);
    [given([_mockTask1 id]) willReturn:kTaskName1];
    [given([_mockTask1 block]) willReturn:^{
        NSLog(@"My name is %@", kTaskName1);
    }];
    
    _mockTask2 = mock([SKTask class]);
    [given([_mockTask2 id]) willReturn:kTaskName2];
    [given([_mockTask2 block]) willReturn:^{
        NSLog(@"My name is %@", kTaskName2);
    }];
    
    _taskQueue = [[SKTaskQueue alloc] initWithOrderedDictionary:_taskArray];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)test_shouldAddTask {
    // given
    _taskQueue.suspended = YES;
    
    // when
    [_taskQueue addTask:_mockTask1];
    [_taskQueue addTask:_mockTask2];
    _taskQueue.suspended = NO;
    
    // should
    [NSThread sleepForTimeInterval:(double)1];
    [verify(_mockTask1) block];
    [verify(_mockTask2) block];
}

- (void)test_shouldInsertTask {
    // given
    _taskQueue.suspended = YES;
    
    // when
    [_taskQueue insertTask:_mockTask1];
    [_taskQueue insertTask:_mockTask2];
    _taskQueue.suspended = NO;
    
    // should
    [NSThread sleepForTimeInterval:(double)1];
    [verify(_mockTask1) block];
    [verify(_mockTask2) block];
}

@end
