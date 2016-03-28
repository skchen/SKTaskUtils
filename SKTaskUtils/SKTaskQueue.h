//
//  SKTaskQueue.h
//  SKTaskUtils
//
//  Created by Shin-Kai Chen on 2016/3/26.
//  Copyright © 2016年 SK. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <SKUtils/SKOrderedDictionary.h>
#import "SKTask.h"

@interface SKTaskQueue : NSObject

@property(nonatomic, assign) BOOL suspended;

- (instancetype)initWithOrderedDictionary:(SKOrderedDictionary *)taskArray;

/**
 Insert task to the beginning of task queue
 @param task    task to insert
 */
- (void)insertTask:(SKTask *)task;

/**
 Add task to the end of task queue
 @param task    task to add
 */
- (void)addTask:(SKTask *)task;

/**
 Remove task
 @param task    task to remove
 */
- (void)removeTask:(SKTask *)task;

/**
 Remoev all tasks in task queue
 */
- (void)cancelAllTasks;

@end
