//
//  LaunchAdImageView.m
//  communityDemo
//
//  Created by chaziyjs on 2017/9/15.
//  Copyright © 2017年 chaziyjs. All rights reserved.
//

#import "LaunchAdImageView.h"

@implementation LaunchAdImageView {
    NSInteger leftTime;
}

- (instancetype)initWithFrame:(CGRect)frame Delegate:(id<LaunchAdDelegate>)delegate
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.ad_imageView];
        leftTime = 3;
        _delegate = delegate;
    }
    return self;
}

#pragma mark - 重新设置显示图片
- (void)setImagePath:(NSString *)path
{
    if ([path containsString:@"http"]) {
        [[SDWebImageManager sharedManager] loadImageWithURL:[NSURL URLWithString:path] options:SDWebImageAllowInvalidSSLCertificates | SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
            
        } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
            NSString *string = [path lowercaseString];
            if ([string containsString:@".gif"] && data.length > 0) {
                FLAnimatedImage *gifImage = [[FLAnimatedImage alloc] initWithAnimatedGIFData:data];
                [self.ad_imageView setAnimatedImage:gifImage];
                [self addTarget:self action:@selector(jumpToRedirect:) forControlEvents:UIControlEventTouchUpInside];
                [self startTimer];
            } else {
                if (image) {
                    [self.ad_imageView setImage:image];
                    [self addTarget:self action:@selector(jumpToRedirect:) forControlEvents:UIControlEventTouchUpInside];
                    [self startTimer];
                } else {
                    [self performSelector:@selector(jumpToRedirect:) withObject:nil afterDelay:1.0];
                    FLog(@"down load image error = %@", error);
                }
            }
        }];
    } else {
        if (path.length > 0) {
            [self setImage:[[UIImage imageWithContentsOfFile:path] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
            [self addTarget:self action:@selector(jumpToRedirect:) forControlEvents:UIControlEventTouchUpInside];
            [self startTimer];
        } else {
            [self performSelector:@selector(jumpToRedirect:) withObject:nil afterDelay:1.0];
        }
    }
}

#pragma mark - 开始定时
- (void)startTimer
{
    if (_countDownView == nil) {
        [self addSubview:self.countDownView];
    }
    if (_timer) {
        return;
    }
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(countDownAction:) userInfo:@{@"leftTime" : @(leftTime)} repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}

#pragma mark - 定时器倒计时方法
- (void)countDownAction:(NSTimer *)timer
{
    leftTime --;
    if (leftTime == 0) {
        [_timer invalidate];
        _timer = nil;
        __weak typeof(self) weak_self = self;
        [UIView animateWithDuration:0.3 animations:^{
            weak_self.alpha = 0.0;
            weak_self.countDownView.alpha = 0.0;
        } completion:^(BOOL finished) {
            if (_delegate && [_delegate respondsToSelector:@selector(launchAdCloseWithType:)]) {
                [_delegate launchAdCloseWithType:LaunchAdCloseWithoutTouch];
            }
        }];
    } else {
        _countDownView.text = [NSString stringWithFormat:@"%lds", (long)leftTime];
    }
}

#pragma mark - 点击广告并跳转
- (void)jumpToRedirect:(id)sender
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    [_timer invalidate];
    _timer = nil;
    __weak typeof(self) weak_self = self;
    [UIView animateWithDuration:0.3 animations:^{
        weak_self.alpha = 0.0;
        weak_self.countDownView.alpha = 0.0;
    } completion:^(BOOL finished) {
        if (_delegate && [_delegate respondsToSelector:@selector(launchAdCloseWithType:)]) {
            if (sender && [sender isKindOfClass:[UIButton class]]) {
                [_delegate launchAdCloseWithType:LaunchAdCloseWithTouch];
            } else {
                [_delegate launchAdCloseWithType:LaunchAdCloseWithoutAd];
            }
        }
    }];
}

#pragma mark - 点击倒计时按钮,停止倒计时并关闭页面
- (void)countDownStop
{
    [_timer invalidate];
    _timer = nil;
    __weak typeof(self) weak_self = self;
    [UIView animateWithDuration:0.3 animations:^{
        weak_self.alpha = 0.0;
        weak_self.countDownView.alpha = 0.0;
    } completion:^(BOOL finished) {
        if (_delegate && [_delegate respondsToSelector:@selector(launchAdCloseWithType:)]) {
            [_delegate launchAdCloseWithType:LaunchAdCloseWithoutTouch];
        }
    }];
}

#pragma mark - 懒加载
- (CountDownView *)countDownView
{
    if (_countDownView == nil) {
        _countDownView = [CountDownView new];
        _countDownView.times = leftTime;
        _countDownView.strokeColor = [UIColor cyanColor];
        _countDownView.text = [NSString stringWithFormat:@"%lds", (long)leftTime];
        _countDownView.flag = CountDownProcess;
        _countDownView.bounds = CGRectMake(0, 0, 40.f, 40.f);
        _countDownView.textColor = [UIColor orangeColor];
        _countDownView.center = CGPointMake(CGRectGetWidth(self.frame) - 40.f, kDevice_Is_iPhoneX ? 80.f : 40.f);
        _countDownView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(countDownStop)];
        [_countDownView addGestureRecognizer:tap];
    }
    return _countDownView;
}

- (FLAnimatedImageView *)ad_imageView
{
    if (_ad_imageView == nil) {
        _ad_imageView = [[FLAnimatedImageView alloc] initWithFrame:self.bounds];
        _ad_imageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _ad_imageView;
}

@end
