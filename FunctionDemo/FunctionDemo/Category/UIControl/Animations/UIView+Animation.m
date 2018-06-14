//
//  UIView+Animation.m
//  FunctionDemo
//
//  Created by chaziyjs on 2018/4/8.
//  Copyright © 2018年 chaziyjs. All rights reserved.
//

#import "UIView+Animation.h"

@implementation UIView (Animation)

- (void)fadeAnimation {
    CATransition *anima = [CATransition animation];
    anima.type = kCATransitionFade;//设置动画的类型
    anima.subtype = kCATransitionFromRight; //设置动画的方向
    //anima.startProgress = 0.3;//设置动画起点
    //anima.endProgress = 0.8;//设置动画终点
    anima.duration = 1.0f;
    [self.layer addAnimation:anima forKey:@"fadeAnimation"];
}

- (void)moveInAnimation {
    CATransition *anima = [CATransition animation];
    anima.type = kCATransitionMoveIn;//设置动画的类型
    anima.subtype = kCATransitionFromRight; //设置动画的方向
    anima.duration = 1.0f;
    [self.layer addAnimation:anima forKey:@"moveInAnimation"];
}

- (void)pushAnimation {
    CATransition *anima = [CATransition animation];
    anima.type = kCATransitionPush;//设置动画的类型
    anima.subtype = kCATransitionFromRight; //设置动画的方向
    anima.duration = 1.0f;
    [self.layer addAnimation:anima forKey:@"pushAnimation"];
}

- (void)revealAnimation {
    CATransition *anima = [CATransition animation];
    anima.type = kCATransitionReveal;//设置动画的类型
    anima.subtype = kCATransitionFromRight; //设置动画的方向
    anima.duration = 1.0f;
    [self.layer addAnimation:anima forKey:@"revealAnimation"];
}

- (void)cubeAnimation {
    CATransition *anima = [CATransition animation];
    anima.type = @"cube";//设置动画的类型
    anima.subtype = kCATransitionFromRight; //设置动画的方向
    anima.duration = 1.0f;
    [self.layer addAnimation:anima forKey:@"revealAnimation"];
}

- (void)suckEffectAnimation {
    CATransition *anima = [CATransition animation];
    anima.type = @"suckEffect";//设置动画的类型
    anima.subtype = kCATransitionFromRight; //设置动画的方向
    anima.duration = 1.0f;
    [self.layer addAnimation:anima forKey:@"suckEffectAnimation"];
}

- (void)oglFlipAnimation {
    CATransition *anima = [CATransition animation];
    anima.type = @"oglFlip";//设置动画的类型
    anima.subtype = kCATransitionFromRight; //设置动画的方向
    anima.duration = 1.0f;
    [self.layer addAnimation:anima forKey:@"oglFlipAnimation"];
}

- (void)rippleEffectAnimation {
    CATransition *anima = [CATransition animation];
    anima.type = @"rippleEffect";//设置动画的类型
    anima.subtype = kCATransitionFromRight; //设置动画的方向
    anima.duration = 1.0f;
    [self.layer addAnimation:anima forKey:@"rippleEffectAnimation"];
}

- (void)pageCurlAnimation {
    CATransition *anima = [CATransition animation];
    anima.type = @"pageCurl";//设置动画的类型
    anima.subtype = kCATransitionFromRight; //设置动画的方向
    anima.duration = 1.0f;
    [self.layer addAnimation:anima forKey:@"pageCurlAnimation"];
}

- (void)pageUnCurlAnimation {
    CATransition *anima = [CATransition animation];
    anima.type = @"pageUnCurl";//设置动画的类型
    anima.subtype = kCATransitionFromRight; //设置动画的方向
    anima.duration = 1.0f;
    [self.layer addAnimation:anima forKey:@"pageUnCurlAnimation"];
}

@end
