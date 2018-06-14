//
//  GroupAnimation.h
//  FunctionDemo
//
//  Created by chaziyjs on 2018/4/9.
//  Copyright © 2018年 chaziyjs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^GroupAnimationCompleted)(BOOL finished);

typedef NS_ENUM(NSInteger, GroupAnimationActionType)
{
    GroupAnimationActionGroup,
    GroupAnimationActionSequence,
    GroupAnimationActionNuN
};

@interface GroupAnimation : NSObject<CAAnimationDelegate>

//执行动作 ---> 使用点语法添加动画动作
@property (nonatomic, weak) GroupAnimation *scale;
@property (nonatomic, weak) GroupAnimation *rotation;
@property (nonatomic, weak) GroupAnimation *position;

//动作参数 ---> 先设置参数,再执行动作
@property (nonatomic, strong) NSArray *postion_path;
@property (nonatomic, assign) float scaleFromValue;
@property (nonatomic, assign) float scaleToValue;
@property (nonatomic, assign) float rotation_angle;
@property (nonatomic, assign) float during;
@property (nonatomic, assign) GroupAnimationActionType type;

@property (nonatomic, copy) GroupAnimationCompleted callback;

+ (GroupAnimation *)createGroupAnimationWithType:(GroupAnimationActionType)type;

- (void)GroupAnimationStartInView:(UIView *)targetView Callback:(GroupAnimationCompleted)callback; //动画组是将多个动画同事执行的 -> 完成后别忘清除动画

- (void)resetAnimation; //清空参数

@end
