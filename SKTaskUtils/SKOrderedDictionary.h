//
//  SKOrderedDictionary.h
//  SKTaskUtils
//
//  Created by Shin-Kai Chen on 2016/3/28.
//  Copyright © 2016年 SK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SKOrderedDictionary : NSObject

@property (readonly) NSUInteger count;

- (void)removeAllObjects;

- (void)setObject:(nonnull id)object forKey:(nonnull id<NSCopying>)key;
- (nullable id)objectForKey:(nonnull id<NSCopying>)key;
- (void)removeObjectForKey:(nonnull id<NSCopying>)key;

- (nullable id)objectAtIndex:(NSUInteger)index;
- (void)removeObjectAtIndex:(NSUInteger)index;

@end
