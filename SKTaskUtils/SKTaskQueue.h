//
//  SKTaskQueue.h
//  SKTaskUtils
//
//  Created by Shin-Kai Chen on 2016/3/26.
//  Copyright © 2016年 SK. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SKTask.h"

@interface SKTaskQueue : NSObject

@property(nonatomic, assign) BOOL suspended;

- (instancetype)initWithMutableArray:(NSMutableArray *)taskArray;

/**
 Insert task to head of task queue
 @param task    task to insert
 */
- (void)insertTask:(SKTask *)task;

/**
 Add task to the end of task queue
 @param task    task to add
 */
- (void)addTask:(SKTask *)task;

/**
 Remoev all tasks in task queue
 */
- (void)cancelAllTasks;

@end
