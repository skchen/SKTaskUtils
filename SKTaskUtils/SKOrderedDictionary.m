//
//  SKOrderedDictionary.m
//  SKTaskUtils
//
//  Created by Shin-Kai Chen on 2016/3/28.
//  Copyright © 2016年 SK. All rights reserved.
//

#import "SKOrderedDictionary.h"

@interface SKOrderedDictionary ()

@property(nonatomic, strong) NSMutableDictionary *dictionary;
@property(nonatomic, strong) NSMutableArray *array;

@end

@implementation SKOrderedDictionary

- (instancetype)init {
    self = [super init];
    _dictionary = [[NSMutableDictionary alloc] init];
    _array = [[NSMutableArray alloc] init];
    return self;
}

- (NSUInteger)count {
    return [_dictionary count];
}

- (void)removeAllObjects {
    [_dictionary removeAllObjects];
    [_array removeAllObjects];
}

- (void)setObject:(nonnull id)object forKey:(nonnull id<NSCopying>)key {
    [_dictionary setObject:object forKey:key];
    [_array addObject:object];
}

- (nullable id)objectForKey:(nonnull id<NSCopying>)key {
    return [_dictionary objectForKey:key];
}

- (void)removeObjectForKey:(nonnull id<NSCopying>)key {
    id object = [_dictionary objectForKey:key];
    
    [_dictionary removeObjectForKey:key];
    [_array removeObject:object];
}

- (nullable id)objectAtIndex:(NSUInteger)index {
    return [_array objectAtIndex:index];
}

- (void)removeObjectAtIndex:(NSUInteger)index {
    id object = [_array objectAtIndex:index];
    
    NSArray *keys = [_dictionary allKeys];
    for(NSObject *key in keys) {
        if([[_dictionary objectForKey:key] isEqual:object]) {
            [_dictionary removeObjectForKey:key];
            break;
        }
    }
    
    [_array removeObject:object];
}

@end
