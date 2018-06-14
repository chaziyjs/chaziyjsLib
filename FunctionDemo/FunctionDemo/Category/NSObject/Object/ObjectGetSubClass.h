//
//  ObjectGetSubClass.h
//  FunctionDemo
//
//  Created by chaziyjs on 2018/6/11.
//  Copyright © 2018年 chaziyjs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@interface ObjectGetSubClass : NSObject

+ (NSArray *)findSubClass:(Class)defaultClass;

@end
