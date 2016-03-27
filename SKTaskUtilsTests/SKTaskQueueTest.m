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

@end

@implementation SKTaskQueueTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)test_shouldAddTask_whenTaskQueueIsEmpty {
    // given
    NSMutableArray *mockTaskArray = mock([NSMutableArray class]);
    [given([mockTaskArray count]) willReturnInt:0];
    SKTask *mockTask = mock([SKTask class]);
    SKTaskQueue *taskQueue = [[SKTaskQueue alloc] initWithMutableArray:mockTaskArray];
    
    // when
    [taskQueue addTask:mockTask];
    
    // should
    [verify(mockTaskArray) addObject:mockTask];
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
