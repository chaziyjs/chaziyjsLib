//
//  ObjectGetSubClass.m
//  FunctionDemo
//
//  Created by chaziyjs on 2018/6/11.
//  Copyright © 2018年 chaziyjs. All rights reserved.
//

#import "ObjectGetSubClass.h"

@implementation ObjectGetSubClass

+ (NSArray *)findSubClass:(Class)defaultClass
{
    int count = objc_getClassList(NULL, 0);
    if (count <= 0) {
        return [NSArray array];
    }
    NSMutableArray *output = [NSMutableArray arrayWithObject:defaultClass];
    Class *classes = (Class *)malloc(sizeof(Class) * count);
    objc_getClassList(classes, count);
    for (int i = 0; i < count; i ++) {
        if (defaultClass == class_getSuperclass(classes[i])) {
            [output addObject:classes[i]];
        }
    }
    free(classes);
    return output;
}

@end
