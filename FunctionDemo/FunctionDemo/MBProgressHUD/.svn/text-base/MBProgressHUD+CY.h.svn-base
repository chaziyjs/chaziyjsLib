//
//  MBProgressHUD.h
//  WetalkCommunity
//
//  Created by chaziyjs on 2017/9/15.
//  Copyright © 2017年 chaziyjs. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (CY)


+ (MBProgressHUD *)createHUD:(UIView *)view;
+ (MBProgressHUD *)defaultMBProgress:(UIView *)view;
+ (MBProgressHUD *)defaultMBProgressWithText:(NSString *)text view:(UIView *)view;
+ (MBProgressHUD *)circleMBProgressWithText:(NSString *)text view:(UIView *)view;

+ (void)show:(NSString *)text icon:(NSString *)icon during:(CGFloat)times view:(UIView *)view;
+ (void)showSuccess:(NSString *)error during:(CGFloat)times view:(UIView *)view;
+ (void)showError:(NSString *)error during:(CGFloat)times view:(UIView *)view;
+ (MBProgressHUD *)showNotice:(NSString *)notice view:(UIView *)view during:(CGFloat)times;
+ (void)showTitle:(NSString *)title Detail:(NSString *)detail View:(UIView *)view During:(CGFloat)times;

/*****帧动画*****/
+ (MBProgressHUD *)showCustomAnimate:(NSString *)text imageName:(NSString *)imageName imageCounts:(NSInteger)imageCounts view:(UIView *)view;

+ (void)drawRightViewWithText:(NSString *)text during:(CGFloat)times view:(UIView *)view;
+ (void)drawErrorViewWithText:(NSString *)text during:(CGFloat)times view:(UIView *)view;
+ (MBProgressHUD *)drawRoundLoadingView:(NSString *)tex view:(UIView *)viewt;

/****富文本*****/
+ (void)drawRightViewWithAttributedText:(NSMutableAttributedString *)text
                                 during:(CGFloat)times
                                   view:(UIView *)view;
+ (void)drawErrorViewWithAttributedText:(NSMutableAttributedString *)text
                                 during:(CGFloat)times
                                   view:(UIView *)view;
+ (MBProgressHUD *)drawRoundLoadingViewWithAttributedString:(NSMutableAttributedString *)text
                                                       view:(UIView *)view;
+ (MBProgressHUD *)showAttributedNotice:(NSMutableAttributedString *)notice
                                   view:(UIView *)view
                                 during:(CGFloat)times;
+ (void)showAttributedTitle:(NSMutableAttributedString *)title
           AttributedDetail:(NSMutableAttributedString *)detail
                       View:(UIView *)view
                     During:(CGFloat)times;

@end
