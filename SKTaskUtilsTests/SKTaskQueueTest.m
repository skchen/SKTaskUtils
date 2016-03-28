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
@property(nonatomic, strong) SKTask *mockTask1;
@property(nonatomic, strong) SKTask *mockTask2;
@property(nonatomic, strong) SKTask *mockTask3;

@end

static NSString *const kTaskName1 = @"Test Task 1";
static NSString *const kTaskName2 = @"Test Task 2";
static NSString *const kTaskName3 = @"Test Task 3";

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
    
    _mockTask3 = mock([SKTask class]);
    [given([_mockTask3 id]) willReturn:kTaskName3];
    [given([_mockTask3 block]) willReturn:^{
        NSLog(@"My name is %@", kTaskName3);
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
    [_taskQueue addTask:_mockTask3];
    _taskQueue.suspended = NO;
    
    // should
    [NSThread sleepForTimeInterval:(double)1];
    [verify(_mockTask1) block];
    [verify(_mockTask2) block];
    [verify(_mockTask3) block];
}

- (void)test_shouldInsertTask {
    // given
    _taskQueue.suspended = YES;
    
    // when
    [_taskQueue insertTask:_mockTask1];
    [_taskQueue insertTask:_mockTask2];
    [_taskQueue insertTask:_mockTask3];
    _taskQueue.suspended = NO;
    
    // should
    [NSThread sleepForTimeInterval:(double)1];
    [verify(_mockTask3) block];
    [verify(_mockTask2) block];
    [verify(_mockTask1) block];
}

- (void)test_shouldInsertTask_whenTaskIsAlreadyInQueue {
    // given
    _taskQueue.suspended = YES;
    
    // when
    [_taskQueue addTask:_mockTask1];
    [_taskQueue addTask:_mockTask2];
    [_taskQueue insertTask:_mockTask3];
    [_taskQueue insertTask:_mockTask2];
    _taskQueue.suspended = NO;
    
    // should
    [NSThread sleepForTimeInterval:(double)1];
    [verify(_mockTask2) block];
    [verify(_mockTask3) block];
    [verify(_mockTask1) block];
}

- (void)test_shouldAddTask_whenTaskIsAlreadyInQueue {
    // given
    _taskQueue.suspended = YES;
    
    // when
    [_taskQueue addTask:_mockTask1];
    [_taskQueue addTask:_mockTask2];
    [_taskQueue addTask:_mockTask3];
    [_taskQueue addTask:_mockTask2];
    _taskQueue.suspended = NO;
    
    // should
    [NSThread sleepForTimeInterval:(double)1];
    [verify(_mockTask2) block];
    [verify(_mockTask3) block];
    [verify(_mockTask1) block];
}

@end
