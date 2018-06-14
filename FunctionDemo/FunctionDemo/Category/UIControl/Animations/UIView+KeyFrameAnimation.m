//
//  UIView+KeyFrameAnimation.m
//  FunctionDemo
//
//  Created by chaziyjs on 2018/4/9.
//  Copyright © 2018年 chaziyjs. All rights reserved.
//

#import "UIView+KeyFrameAnimation.h"

@implementation UIView (KeyFrameAnimation)

static const void *callbackKey = &callbackKey;

- (void)keyFrameAnimationWithPath:(NSArray *)paths
                           During:(float)during
                      RepeatCount:(float)repeat
                         CallBack:(AnimationCompleted)completed
{
    CAKeyframeAnimation *anima = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    anima.values = paths;
    anima.duration = during;
    anima.repeatCount = repeat;
    anima.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    anima.delegate = self;
    completed = self.callback;
    [self.layer addAnimation:anima forKey:@"keyFrameAnimation"];
}

- (void)circlePathAnimationWithFrame:(CGRect)rect
                              During:(float)during
                         RepeatCount:(float)repeat
                            CallBack:(AnimationCompleted)completed
{
    CAKeyframeAnimation *anima = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:rect];
    anima.path = path.CGPath;
    anima.duration = during;
    anima.repeatCount = repeat;
    completed = self.callback;
    [self.layer addAnimation:anima forKey:@"pathAnimation"];
}

- (void)shakeAnimationWithAngle:(float)angle
                         During:(float)during
                    RepeatCount:(float)repeat
                       CallBack:(AnimationCompleted)completed
{
    CAKeyframeAnimation *anima = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation"];
    NSValue *value1 = [NSNumber numberWithFloat:-angle];
    NSValue *value2 = [NSNumber numberWithFloat:angle];
    NSValue *value3 = [NSNumber numberWithFloat:-angle];
    anima.values = @[value1,value2,value3];
    anima.duration = during;
    anima.repeatCount = repeat;
    completed = self.callback;
    [self.layer addAnimation:anima forKey:@"shakeAnimation"];
}

#pragma mark - CAAnimationDelegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    [self.layer removeAllAnimations];
    self.callback(flag);
}

#pragma mark - getter & setter
- (void)setCallback:(AnimationCompleted)callback
{
    objc_setAssociatedObject(self, callbackKey, callback, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (AnimationCompleted)callback
{
    return objc_getAssociatedObject(self, callbackKey);
}

@end
