//
//  LaunchVC.h
//  communityDemo
//
//  Created by chaziyjs on 2017/9/14.
//  Copyright © 2017年 chaziyjs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+EX.h"
#import "CountDownView.h"
#import "LaunchAdImageView.h"
#import "LaunchStyleModel.h"

typedef void(^LaunchShowEndBlock)(BOOL completed);

@interface LaunchVC : UIViewController<UIScrollViewDelegate, LaunchAdDelegate>

@property (nonatomic, strong) UIScrollView      *launch_scroll;
@property (nonatomic, strong) UIPageControl     *pageControl;
@property (nonatomic, strong) LaunchAdImageView *ad_animation;
@property (nonatomic, strong) UIWindow *launchWindow;
@property (nonatomic, copy) NSString *openImageURL;

@property (nonatomic, strong) NSMutableArray    *launch_array;
@property (nonatomic, assign, readonly) LaunchStyle       currentStyle;
@property (nonatomic, copy) NSString            *imageURLString;
@property (nonatomic, assign, readonly) NSUInteger        counts;
@property (nonatomic, copy) LaunchShowEndBlock callback;

- (instancetype)initWithStyle:(LaunchStyle)style;

- (void)launchShowEnd:(LaunchShowEndBlock)block;

- (void)changeCurrentStyle:(LaunchStyle)style;

@end
