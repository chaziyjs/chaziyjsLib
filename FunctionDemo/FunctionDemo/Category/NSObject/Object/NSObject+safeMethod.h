//
//  NSObject+safeMethod.h
//  FunctionDemo
//
//  Created by chaziyjs on 2018/6/1.
//  Copyright © 2018年 chaziyjs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

typedef void(^KVOBlock)(void);

@interface NSObject (safeMethod)

- (void)addEOCObsever:(NSObject *)observer ForKeypath:(NSString *)keypath Block:(KVOBlock)block;

@end
