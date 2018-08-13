//
//  AnimationManager.h
//  demo
//
//  Created by 啾 on 2017/3/10.
//  Copyright © 2017年 qweewq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, KAnimationType){
    
    KAnimationTypeLeftToRight = 0,
    KAnimationTypeRightToLeft
};

@interface AnimationManager : NSObject<UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign) KAnimationType type;
- (instancetype)initWithType:(KAnimationType)type;

@end
