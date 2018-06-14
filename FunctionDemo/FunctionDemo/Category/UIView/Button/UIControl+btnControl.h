//
//  UIControl+btnControl.h
//  WetalkCommunity
//
//  Created by chaziyjs on 2017/11/8.
//  Copyright © 2017年 chaziyjs. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <objc/runtime.h>

#define     defaultInterval         .5//默认时间间隔
@interface UIControl (btnControl)

@property(nonatomic, assign) NSTimeInterval timeInterval;//用这个给重复点击加间隔
@property(nonatomic, assign) BOOL isIgnoreEvent;//YES不允许点击NO允许点击

@end
