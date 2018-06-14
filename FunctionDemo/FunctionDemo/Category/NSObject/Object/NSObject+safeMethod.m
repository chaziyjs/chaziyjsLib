//
//  NSObject+safeMethod.m
//  FunctionDemo
//
//  Created by chaziyjs on 2018/6/1.
//  Copyright © 2018年 chaziyjs. All rights reserved.
//

#import "NSObject+safeMethod.h"

@interface NSObject ()

@property (nonatomic, strong) NSMutableDictionary *dict;
@property (nonatomic, strong) NSMutableDictionary *kvoDict;

@end

@implementation NSObject (safeMethod)

- (void)addEOCObsever:(NSObject *)observer ForKeypath:(NSString *)keypath Block:(KVOBlock)block
{
    NSString *key = [NSString stringWithFormat:@"%@%@", self, keypath];
    observer.dict[key] = block;
    
    NSMutableArray *array = self.kvoDict[keypath];
    if (!array) {
        array = [NSMutableArray array];
        [array addObject:[NSValue valueWithNonretainedObject:observer]];
        self.kvoDict[keypath] = array;
    }
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        method_exchangeImplementations(class_getInstanceMethod([self class], @selector(EOCDealloc)), class_getInstanceMethod([self class], NSSelectorFromString(@"dealloc")));
    });
    
    [self addObserver:observer forKeyPath:keypath options:NSKeyValueObservingOptionNew context:NULL];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    /// 字典保存 observer.dic : key=keyPath value=block
    NSString *key = [NSString stringWithFormat:@"%@%@", object, keyPath];
    KVOBlock block = self.dict[key];
    if (block) {
        block();
    }
}

- (BOOL)isKVO
{
    if (objc_getAssociatedObject(self, @selector(kvoDict))) {
        return YES;
    }
    return NO;
}

- (void)EOCDealloc
{
    if ([self isKVO]) {
        for (NSString *keypath in self.kvoDict.allKeys) {
            NSMutableArray *key = self.kvoDict[keypath];
            for (NSValue *obsever in key) {
                [self removeObserver:obsever.nonretainedObjectValue forKeyPath:keypath];
            }
        }
    }
    [self EOCDealloc];
}

#pragma mark - get方法
- (NSMutableDictionary *)dict
{
    NSMutableDictionary *tmpDict = objc_getAssociatedObject(self, _cmd);
    if (!tmpDict) {
        tmpDict = [NSMutableDictionary dictionary];
        objc_setAssociatedObject(self, _cmd, tmpDict, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return tmpDict;
}

- (NSMutableDictionary *)kvoDict
{
    NSMutableDictionary *tmpDict = objc_getAssociatedObject(self, _cmd);
    if (!tmpDict) {
        tmpDict = [NSMutableDictionary dictionary];
        objc_setAssociatedObject(self, _cmd, tmpDict, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return tmpDict;
}

@end
