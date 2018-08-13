//
//  LaunchAdImageView.h
//  communityDemo
//
//  Created by chaziyjs on 2017/9/15.
//  Copyright © 2017年 chaziyjs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CountDownView.h"
#import <FLAnimatedImage/FLAnimatedImageView.h>
#import <FLAnimatedImage/FLAnimatedImage.h>

typedef NS_ENUM(NSUInteger, LaunchCloseType)
{
    LaunchAdCloseWithTouch          =   1000,
    LaunchAdCloseWithoutTouch       =   1001,
    LaunchAdCloseWithoutAd          =   1002
};

@protocol LaunchAdDelegate <NSObject>

- (void)launchAdCloseWithType:(LaunchCloseType)type;

@end

@interface LaunchAdImageView : UIButton

@property (nonatomic, strong) CountDownView *countDownView;
@property (nonatomic, weak) id<LaunchAdDelegate> delegate;
@property (nonatomic, strong, readonly) NSTimer *timer;
@property (nonatomic, strong) FLAnimatedImageView *ad_imageView;

#pragma mark - 接口部分
- (instancetype)initWithFrame:(CGRect)frame
                     Delegate:(id<LaunchAdDelegate>)delegate;

- (void)setImagePath:(NSString *)path;

- (void)startTimer;

@end
