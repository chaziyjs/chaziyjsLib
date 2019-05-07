//
//  BaseObject.m
//  FunctionDemo
//
//  Created by chaziyjs on 2018/6/5.
//  Copyright © 2018年 chaziyjs. All rights reserved.
//

#import "BaseObject.h"

void dynamicResolveMethod(id self, SEL _cmd) {
    NSLog(@"%@ Call method Named <%@> is Not Found", NSStringFromClass([self class]), NSStringFromSelector(_cmd));
}

@implementation BaseObject {
    NSMapTable *undefineProperty;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        undefineProperty = [NSMapTable mapTableWithKeyOptions:NSMapTableWeakMemory valueOptions:NSMapTableStrongMemory];
    }
    return self;
}

+ (BOOL)resolveInstanceMethod:(SEL)sel {
    unsigned int count;
    Method *methodList = class_copyMethodList(self, &count);
    for (unsigned int i = 0; i < count; i++) {
        Method method = methodList[i];
        if ([NSStringFromSelector(method_getName(method)) isEqualToString:NSStringFromSelector(sel)]) {
            return YES;
        }
    }
    const char *types = sel_getName(sel);
    class_addMethod([self class], sel, (IMP)dynamicResolveMethod, types);
    return YES;
}

#pragma mark - 访问未知属性(调用valueForKey方法)时,动态存储对象
- (id)valueForUndefinedKey:(NSString *)key
{
    //读取时,根据对象类型读取
    id value = [undefineProperty valueForKey:key];
    if ([value isKindOfClass:[NSObject class]]) {
        NSValue *obj_value = value;
        return obj_value.nonretainedObjectValue;
    } else {
        return value;
    }
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    //如果是对象类型的存储,使用弱引用方式,不强持有对象,以避免造成循环引用
    if ([value isKindOfClass:[NSObject class]]) {
        NSValue *weakValue = [NSValue valueWithNonretainedObject:value];
        [undefineProperty setObject:weakValue forKey:key];
    } else {
        [undefineProperty setObject:value forKey:key];
    }
}

- (void)dealloc
{
    [undefineProperty removeAllObjects];
    undefineProperty = nil;
}

@end
