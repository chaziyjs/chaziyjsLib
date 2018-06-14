//
//  UIView+Animation.h
//  FunctionDemo
//
//  Created by chaziyjs on 2018/4/8.
//  Copyright © 2018年 chaziyjs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Animation)

#pragma mark - View的转场动画
- (void)fadeAnimation;

- (void)moveInAnimation;

- (void)pushAnimation;

- (void)revealAnimation;

- (void)cubeAnimation;

- (void)suckEffectAnimation;

- (void)oglFlipAnimation;

- (void)rippleEffectAnimation;

- (void)pageCurlAnimation;

- (void)pageUnCurlAnimation;

@end
