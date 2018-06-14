//
//  UIViewController+MBHUD.h
//  WetalkCommunity
//
//  Created by chaziyjs on 2017/9/19.
//  Copyright © 2017年 chaziyjs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (MBHUD)

- (void)displayHUDWithText:(NSString *)text
                     Times:(CGFloat)times;

- (void)hiddenHUD:(BOOL)animated;

- (void)displayLoadingAnimationWithText:(NSString *)text;

- (void)displayImage:(NSString *)imageName
            WithText:(NSString *)text
              During:(CGFloat)times;

- (void)displayKeyFrameAnimationWithText:(NSString *)text;

- (void)displayAnimationSuccessWithText:(NSString *)text
                                 During:(CGFloat)times;

- (void)displayAnimationWrongWithText:(NSString *)text
                               During:(CGFloat)times;

- (void)displayHUDWithTitle:(NSString *)titleStr
                     Detail:(NSString *)detailStr
                     During:(CGFloat)times;

#pragma mark - 富文本显示内容
- (void)displaySuccessWithAttributeTitle:(NSMutableAttributedString *)title
                                  During:(CGFloat)times;

- (void)displayWrongWithAttributeTitle:(NSMutableAttributedString *)title
                                During:(CGFloat)times;

- (void)displayAttributedTitle:(NSMutableAttributedString *)title
              AttributedDetail:(NSMutableAttributedString *)detail
                        During:(CGFloat)times;

- (void)displayAttributedNotice:(NSMutableAttributedString *)notice
                         During:(CGFloat)times;

@end
