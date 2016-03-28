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

@property(nonatomic, strong) SKOrderedDictionary *mockTaskArray;
@property(nonatomic, strong) SKTask *mockTask;

@end

static NSString *const kTaskName1 = @"Test Task 1";

@implementation SKTaskQueueTest

- (void)setUp {
    [super setUp];
    
    _mockTaskArray = mock([SKOrderedDictionary class]);
    
    _mockTask = mock([SKTask class]);
    [given([_mockTask name]) willReturn:kTaskName1];
    
    _taskQueue = [[SKTaskQueue alloc] initWithOrderedDictionary:_mockTaskArray];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)test_shouldAddTask {
    // given
    [given([_mockTaskArray count]) willReturnInt:0];
    
    // when
    [_taskQueue addTask:_mockTask];
    
    // should
    [verify(_mockTaskArray) addObject:_mockTask forKey:kTaskName1];
}

- (void)test_taskShouldStartImmediately_whenTaskAddedWithEmptyTaskArray {
    // given
    [given([_mockTaskArray count]) willReturnInt:0];
    
    // when
    [_taskQueue addTask:_mockTask];
    
    // should
    [verify(_mockTaskArray) addObject:_mockTask forKey:kTaskName1];
}

- (void)test_shouldInsertTask {
    // given
    [given([_mockTaskArray count]) willReturnInt:0];
    
    // when
    [_taskQueue insertTask:_mockTask];
    
    // should
    [verify(_mockTaskArray) insertObject:_mockTask atIndex:0 forKey:kTaskName1];
}

- (void)test_shouldClearTaskQueue_whenClearCalled {
    // when
    [_taskQueue cancelAllTasks];
    
    // should
    [verify(_mockTaskArray) removeAllObjects];
}

@end
