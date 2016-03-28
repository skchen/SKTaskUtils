//
//  SKTask.h
//  SKTaskUtils
//
//  Created by Shin-Kai Chen on 2016/3/27.
//  Copyright © 2016年 SK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SKTask : NSObject

@property(nonatomic, copy, readonly, nonnull) NSString *name;
@property(nonatomic, copy, readonly, nonnull) void (^block)(void);

@end
