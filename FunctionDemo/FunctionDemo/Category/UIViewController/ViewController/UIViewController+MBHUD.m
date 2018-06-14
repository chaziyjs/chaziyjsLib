//
//  UIViewController+MBHUD.m
//  WetalkCommunity
//
//  Created by chaziyjs on 2017/9/19.
//  Copyright © 2017年 chaziyjs. All rights reserved.
//

#import "UIViewController+MBHUD.h"

@implementation UIViewController (MBHUD)

- (void)displayHUDWithText:(NSString *)text Times:(CGFloat)times
{
    [MBProgressHUD showNotice:text view:self.view during:times];
}

- (void)hiddenHUD:(BOOL)animated
{
    [MBProgressHUD hideAllHUDsForView:self.view animated:animated];
}

- (void)displayLoadingAnimationWithText:(NSString *)text
{
    [MBProgressHUD showCustomAnimate:text imageName:@"TZloading" imageCounts:64 view:self.view];
}

- (void)displayImage:(NSString *)imageName WithText:(NSString *)text During:(CGFloat)times
{
    [MBProgressHUD show:text icon:imageName during:times view:self.view];
}

- (void)displayKeyFrameAnimationWithText:(NSString *)text
{
    [MBProgressHUD drawRoundLoadingView:text view:self.view];
}

- (void)displayAnimationSuccessWithText:(NSString *)text During:(CGFloat)times
{
    [MBProgressHUD drawRightViewWithText:text during:times view:self.view];
}

- (void)displayAnimationWrongWithText:(NSString *)text During:(CGFloat)times
{
    [MBProgressHUD drawErrorViewWithText:text during:times view:self.view];
}

- (void)displayHUDWithTitle:(NSString *)titleStr Detail:(NSString *)detailStr During:(CGFloat)times
{
    [MBProgressHUD showTitle:titleStr Detail:detailStr View:self.view During:times];
}

#pragma mark - 富文本显示HUD
- (void)displaySuccessWithAttributeTitle:(NSMutableAttributedString *)title During:(CGFloat)times
{
    [MBProgressHUD drawRightViewWithAttributedText:title during:times view:self.view];
}

- (void)displayWrongWithAttributeTitle:(NSMutableAttributedString *)title During:(CGFloat)times
{
    [MBProgressHUD drawErrorViewWithAttributedText:title during:times view:self.view];
}

- (void)displayAttributedTitle:(NSMutableAttributedString *)title AttributedDetail:(NSMutableAttributedString *)detail During:(CGFloat)times
{
    [MBProgressHUD showAttributedTitle:title AttributedDetail:detail View:self.view During:times];
}

- (void)displayAttributedNotice:(NSMutableAttributedString *)notice During:(CGFloat)times
{
    [MBProgressHUD showAttributedNotice:notice view:self.view during:times];
}

@end
