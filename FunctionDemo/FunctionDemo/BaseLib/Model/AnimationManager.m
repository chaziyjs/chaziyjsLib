 //
//  AnimationManager.m
//  demo
//
//  Created by 啾 on 2017/3/10.
//  Copyright © 2017年 qweewq. All rights reserved.
//

#import "AnimationManager.h"
#import "BaseNC.h"

@interface AnimationManager ()
@end

@implementation AnimationManager


- (instancetype)initWithType:(KAnimationType)type {
    
    if (self = [super init]) {
        
        _type = type;
    }
    return self;
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    return UINavigationControllerHideShowBarDuration;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    // 获取fromVc和toVc
    BaseNC *fromVc = (BaseNC *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    BaseNC *toVc = (BaseNC *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *fromV = fromVc.view;
    UIView *toV = toVc.view;
    
    // 转场环境
    UIView *containView = [transitionContext containerView];
    containView.backgroundColor = [UIColor whiteColor];
    
    // 判断滑动方向
    if (toVc.index > fromVc.index) {
    
        toV.frame = CGRectMake([UIScreen mainScreen].bounds.size.width, 0, containView.frame.size.width, containView.frame.size.height);
        
        [containView addSubview:toV];
        // 动画
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            
            fromV.transform = CGAffineTransformTranslate(fromV.transform, -[UIScreen mainScreen].bounds.size.width,0);// containView.frame.size.height
            toV.transform = CGAffineTransformTranslate(toV.transform, -[UIScreen mainScreen].bounds.size.width, 0);
            
        } completion:^(BOOL finished) {
            
            [transitionContext completeTransition:YES];
        }];
        
        
    }else if (toVc.index < fromVc.index) {
        
        toV.frame = CGRectMake(- [UIScreen mainScreen].bounds.size.width, 0, containView.frame.size.width, containView.frame.size.height);
        
        [containView addSubview:toV];
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            
            fromV.transform = CGAffineTransformTranslate(fromV.transform, [UIScreen mainScreen].bounds.size.width,0);
            toV.transform = CGAffineTransformTranslate(toV.transform, [UIScreen mainScreen].bounds.size.width, 0);
            
        } completion:^(BOOL finished) {
            
            [fromV removeFromSuperview];
            [transitionContext completeTransition:YES];

        }];
        
    }
}
@end
