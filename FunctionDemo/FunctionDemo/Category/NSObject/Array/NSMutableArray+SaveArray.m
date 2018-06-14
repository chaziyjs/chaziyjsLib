//
//  NSMutableArray+SaveArray.m
//  FunctionDemo
//
//  Created by chaziyjs on 2018/6/1.
//  Copyright © 2018年 chaziyjs. All rights reserved.
//

#import "NSMutableArray+SaveArray.h"

@implementation NSMutableArray (SaveArray)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method fromMethod = class_getInstanceMethod(objc_getClass("__NSArrayM"), @selector(objectAtIndex:));
        Method toMethod = class_getInstanceMethod(objc_getClass("__NSArrayM"), @selector(save_objectAtIndex:));
        method_exchangeImplementations(fromMethod, toMethod);
        
        Method fromMethod_2 = class_getInstanceMethod(objc_getClass("__NSArrayM"), @selector(removeObjectAtIndex:));
        Method toMethod_2 = class_getInstanceMethod(objc_getClass("__NSArrayM"), @selector(save_removeObjectAtIndex:));
        method_exchangeImplementations(fromMethod_2, toMethod_2);
    });
    
}

- (id)save_objectAtIndex:(NSUInteger)index
{
    if (self.count - 1 < index) {
        @try {
            return [self save_objectAtIndex:index];
        } @catch(NSException *exception) {
            FLog(@"---------- %s Crash Because Method %s ----------\n", class_getName(self.class), __func__);
#ifdef      DEBUG
            NSAssert(self.count - 1 > index, @"NSMutableArray select object index beyond array count [0 ~ %ld] index = %ld", (long)self.count, index);
#else
#endif
            return nil;
        } @finally {
            
        }
    } else {
        return [self save_objectAtIndex:index];
    }
}

- (void)save_removeObjectAtIndex:(NSUInteger)index
{
    if (self.count - 1 < index) {
        @try {
            [self save_removeObjectAtIndex:index];
        } @catch(NSException *exception) {
            FLog(@"---------- %s Crash Because Method %s ----------\n", class_getName(self.class), __func__);
#ifdef      DEBUG
            NSAssert(self.count - 1 > index, @"NSMutableArray remove object index beyond array count [0 ~ %ld] index = %ld", (long)self.count, index);
#else
#endif
        } @finally {
            
        }
    } else {
        [self save_removeObjectAtIndex:index];
    }
}

@end
