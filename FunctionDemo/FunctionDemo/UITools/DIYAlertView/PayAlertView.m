//
//  PayAlertView.m
//  AnywideConvenience
//
//  Created by chaziyjs on 2018/6/15.
//  Copyright © 2018年 Anywide1948. All rights reserved.
//

#import "PayAlertView.h"

@implementation PayAlertView {
    NSMutableArray *actionArray;
    PayAlertStyle style;
}

+ (PayAlertView *)payAlertWithTitle:(NSString *)title Message:(NSString *)msg Image:(UIImage *)image ImageSize:(CGSize)imagesize AlertStyle:(PayAlertStyle)style
{
    PayAlertView *alertView = [[PayAlertView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) Style:style];
    [alertView.contentView createCountViewWithTitle:title ContentMessage:msg LoadImage:image imageSize:imagesize ContentStyle:style];
    return alertView;
}

- (instancetype)initWithFrame:(CGRect)frame Style:(PayAlertStyle)alertStyle
{
    self = [super initWithFrame:frame];
    if (self) {
        style = alertStyle;
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
        actionArray = [NSMutableArray array];
    }
    return self;
}

- (void)addAction:(PayAlertAction *)action
{
    if (action && actionArray) {
        [actionArray addObject:action];
    }
}

- (void)payAlertViewPresentComplete:(void (^)(BOOL finished))completed
{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [self addSubview:self.contentView];
    [self.contentView setButtonArray:actionArray];
    self.contentView.transform = CGAffineTransformConcat(CGAffineTransformIdentity, CGAffineTransformMakeScale(0.01, 0.01));
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.0];
    [UIView animateWithDuration:0.35 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:0.7 options:UIViewAnimationOptionShowHideTransitionViews animations:^{
        self.contentView.transform = CGAffineTransformConcat(CGAffineTransformIdentity, CGAffineTransformMakeScale(1., 1.));
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
    } completion:^(BOOL finished) {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
        [UIView animateWithDuration:0.2 animations:^{
            self.contentView.transform = CGAffineTransformIdentity;
        }];
        if (completed) {
            completed(finished);
        }
    }];
}

- (void)payAlertViewDismissComplete:(void (^)(BOOL finished))completed
{
    [UIView animateWithDuration:0.2 animations:^{
        self.contentView.transform = CGAffineTransformConcat(CGAffineTransformIdentity, CGAffineTransformMakeScale(1.2, 1.2));
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.25 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:0.7 options:UIViewAnimationOptionShowHideTransitionViews animations:^{
            self.contentView.transform = CGAffineTransformConcat(CGAffineTransformIdentity, CGAffineTransformMakeScale(0.01, 0.01));
        } completion:^(BOOL finished) {
            self.alpha = 0;
            [self.contentView removeFromSuperview];
            [self removeFromSuperview];
            if (completed) {
                completed(finished);
            }
        }];
    }];
}

#pragma mark - 懒加载
- (PayAlertContentView *)contentView
{
    if (_contentView == nil) {
        _contentView = [PayAlertContentView new];
    }
    return _contentView;
}

- (void)dealloc
{
    _contentView = nil;
}

@end
