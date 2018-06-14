//
//  UIView+KeyFrameAnimation.h
//  FunctionDemo
//
//  Created by chaziyjs on 2018/4/9.
//  Copyright © 2018年 chaziyjs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>

typedef void(^AnimationCompleted)(BOOL finished);

@interface UIView (KeyFrameAnimation)<CAAnimationDelegate>

@property (nonatomic, copy) AnimationCompleted callback;

- (void)keyFrameAnimationWithPath:(NSArray *)paths
                           During:(float)during
                      RepeatCount:(float)repeat
                         CallBack:(AnimationCompleted)completed; //位移动画

- (void)circlePathAnimationWithFrame:(CGRect)rect
                              During:(float)during
                         RepeatCount:(float)repeat
                            CallBack:(AnimationCompleted)completed; //圆周动画

- (void)shakeAnimationWithAngle:(float)angle
                         During:(float)during
                    RepeatCount:(float)repeat
                       CallBack:(AnimationCompleted)completed; //左右摇摆动画

@end
