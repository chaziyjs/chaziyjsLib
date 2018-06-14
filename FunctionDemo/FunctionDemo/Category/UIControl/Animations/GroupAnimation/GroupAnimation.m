//
//  GroupAnimation.m
//  FunctionDemo
//
//  Created by chaziyjs on 2018/4/9.
//  Copyright © 2018年 chaziyjs. All rights reserved.
//

#import "GroupAnimation.h"

@implementation GroupAnimation {
    NSMutableArray *animations;
    NSMutableArray *seq_aninmations;
    CAAnimationGroup *groupAnimation;
    CFTimeInterval currentTime;
}

+ (GroupAnimation *)createGroupAnimationWithType:(GroupAnimationActionType)type
{
    GroupAnimation *g_animation = [GroupAnimation new];
    g_animation.type = type;
    return g_animation;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        animations = [NSMutableArray array];
        seq_aninmations = [NSMutableArray array];
        groupAnimation = [CAAnimationGroup animation];
        groupAnimation.delegate = self;
    }
    return self;
}

- (void)GroupAnimationStartInView:(UIView *)targetView Callback:(GroupAnimationCompleted)callback
{
    callback = self.callback;
    if (_type == GroupAnimationActionGroup) {
        [groupAnimation setAnimations:animations];
        groupAnimation.duration = _during;
        [targetView.layer addAnimation:groupAnimation forKey:@"GroupAnimation"];
    } else if (_type == GroupAnimationActionSequence) {
        int count = arc4random() % 100 + 1;
        for (CABasicAnimation *baseAnimate in seq_aninmations) {
            count ++;
            [targetView.layer addAnimation:baseAnimate forKey:[NSString stringWithFormat:@"Animation_%d", count]];
        }
    }
    
}

- (void)resetAnimation
{
    [animations removeAllObjects];
    [seq_aninmations removeAllObjects];
    _postion_path = nil;
    _scaleFromValue = 0.f;
    _scaleToValue = 0.f;
    _rotation_angle = 0.f;
    _during = 0.f;
    _type = GroupAnimationActionNuN;
    currentTime = 0.f;
}

#pragma mark - CAAnimationDelegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    self.callback(flag);
}

#pragma mark - 点语法组合动画
- (GroupAnimation *)scale
{
    if (_type == GroupAnimationActionGroup) {
        CABasicAnimation *anima2 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        anima2.fromValue = [NSNumber numberWithFloat:_scaleFromValue];
        anima2.toValue = [NSNumber numberWithFloat:_scaleToValue];
        [animations addObject:anima2];
    } else if (_type == GroupAnimationActionSequence) {
        if (currentTime == 0) {
            currentTime = CACurrentMediaTime();
        } else {
            currentTime += _during;
        }
        CABasicAnimation *anima2 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        anima2.fromValue = [NSNumber numberWithFloat:0.8f];
        anima2.toValue = [NSNumber numberWithFloat:2.0f];
        anima2.beginTime = currentTime;
        anima2.duration = _during;
        anima2.fillMode = kCAFillModeForwards;
        anima2.removedOnCompletion = NO;
        [seq_aninmations addObject:anima2];
    }
    return self;
}

- (GroupAnimation *)rotation
{
    if (_type == GroupAnimationActionGroup) {
        CABasicAnimation *anima3 = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
        anima3.toValue = [NSNumber numberWithFloat:_rotation_angle];
        [animations addObject:anima3];
    } else if (_type == GroupAnimationActionSequence) {
        if (currentTime == 0) {
            currentTime = CACurrentMediaTime();
        } else {
            currentTime += _during;
        }
        CABasicAnimation *anima3 = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
        anima3.toValue = [NSNumber numberWithFloat:_rotation_angle];
        anima3.beginTime = currentTime;
        anima3.duration = _during;
        anima3.fillMode = kCAFillModeForwards;
        anima3.removedOnCompletion = NO;
        [seq_aninmations addObject:anima3];
    }
    return self;
}

- (GroupAnimation *)position
{
    if (_type == GroupAnimationActionGroup) {
        if (_postion_path.count > 0) {
            CAKeyframeAnimation *anima1 = [CAKeyframeAnimation animationWithKeyPath:@"position"];
            anima1.values = _postion_path;
            [animations addObject:anima1];
        }
    } else if (_type == GroupAnimationActionSequence) {
        if (currentTime == 0) {
            currentTime = CACurrentMediaTime();
        } else {
            currentTime += _during;
        }
        CAKeyframeAnimation *anima1 = [CAKeyframeAnimation animationWithKeyPath:@"position"];
        anima1.values = _postion_path;
        anima1.beginTime = currentTime;
        anima1.duration = _during;
        anima1.fillMode = kCAFillModeForwards;
        anima1.removedOnCompletion = NO;
        [animations addObject:anima1];
    }
    
    return self;
}

@end
