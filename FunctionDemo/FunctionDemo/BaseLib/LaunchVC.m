//
//  LaunchVC.m
//  communityDemo
//
//  Created by chaziyjs on 2017/9/14.
//  Copyright © 2017年 chaziyjs. All rights reserved.
//

#import "LaunchVC.h"

#define SCREEN_WIDTH  ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HIGHT  ([UIScreen mainScreen].bounds.size.height)

@interface LaunchVC ()

@end

@implementation LaunchVC

- (instancetype)initWithStyle:(LaunchStyle)style
{
    self = [super init];
    if (self) {
        _currentStyle = style;
        self.launch_array = [NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    LaunchScreenSize size = [LaunchStyleModel currenDeviceSize];
    switch (_currentStyle) {
        case LaunchScrollStyle:
            [self.view addSubview:self.launch_scroll];
            [self.view addSubview:self.pageControl];
            break;
        case LaunchAdImageStyle:
            [self.view addSubview:self.ad_animation];
            break;
        case LaunchNumStyle:
            [self.view addSubview:self.ad_animation];
            break;
        default:
            break;
    }
    // Do any additional setup after loading the view.
    switch (size) {
        case LaunchScreeniPhone4: {
            _openImageURL = [[NSBundle mainBundle] pathForResource:@"LaunchImage.bundle/LaunchVC_35_bg" ofType:@"png"];
//            NSArray *image_array = @[[[NSBundle mainBundle] pathForResource:@"LoadImage.bundle/35/launchImage1-35" ofType:@"png"], [[NSBundle mainBundle] pathForResource:@"LoadImage.bundle/35/launchImage2-35" ofType:@"png"], [[NSBundle mainBundle] pathForResource:@"LoadImage.bundle/35/launchImage3-35" ofType:@"png"]];
            self.launch_array = [NSMutableArray arrayWithArray:@[]];
        }
            break;
        case LaunchScreeniPhone5: {
            _openImageURL = [[NSBundle mainBundle] pathForResource:@"LaunchImage.bundle/LaunchVC_4_bg" ofType:@"png"];
//            NSArray *image_array = @[[[NSBundle mainBundle] pathForResource:@"LoadImage.bundle/4/launchImage1-4" ofType:@"png"], [[NSBundle mainBundle] pathForResource:@"LoadImage.bundle/4/launchImage2-4" ofType:@"png"], [[NSBundle mainBundle] pathForResource:@"LoadImage.bundle/4/launchImage3-4" ofType:@"png"]];
            self.launch_array = [NSMutableArray arrayWithArray:@[]];
            
        }
            break;
        case LaunchScreeniPhone6: {
            _openImageURL = [[NSBundle mainBundle] pathForResource:@"LaunchImage.bundle/LaunchVC_47_bg" ofType:@"png"];
//            NSArray *image_array = @[[[NSBundle mainBundle] pathForResource:@"LoadImage.bundle/47/launchImage1-47" ofType:@"png"], [[NSBundle mainBundle] pathForResource:@"LoadImage.bundle/47/launchImage2-47" ofType:@"png"], [[NSBundle mainBundle] pathForResource:@"LoadImage.bundle/47/launchImage3-47" ofType:@"png"]];
            self.launch_array = [NSMutableArray arrayWithArray:@[]];
        }
            break;
        case LaunchScreeniPhone6P: {
            _openImageURL = [[NSBundle mainBundle] pathForResource:@"LaunchImage.bundle/LaunchVC_55_bg" ofType:@"png"];
//            NSArray *image_array = @[[[NSBundle mainBundle] pathForResource:@"LoadImage.bundle/55/launchImage1-55" ofType:@"png"], [[NSBundle mainBundle] pathForResource:@"LoadImage.bundle/55/launchImage2-55" ofType:@"png"], [[NSBundle mainBundle] pathForResource:@"LoadImage.bundle/55/launchImage3-55" ofType:@"png"]];
            self.launch_array = [NSMutableArray arrayWithArray:@[]];
        }
            break;
        case LaunchScreeniPhoneX: {
            _openImageURL = [[NSBundle mainBundle] pathForResource:@"LaunchImage.bundle/LaunchVC_58_bg" ofType:@"png"];
//            NSArray *image_array = @[[[NSBundle mainBundle] pathForResource:@"LoadImage.bundle/58/launchImage1-58" ofType:@"png"], [[NSBundle mainBundle] pathForResource:@"LoadImage.bundle/58/launchImage2-58" ofType:@"png"], [[NSBundle mainBundle] pathForResource:@"LoadImage.bundle/58/launchImage3-58" ofType:@"png"]];
            self.launch_array = [NSMutableArray arrayWithArray:@[]];
        }
            break;
        default: {
            _openImageURL = [[NSBundle mainBundle] pathForResource:@"LaunchImage.bundle/LaunchVC_47_bg" ofType:@"png"];
//            NSArray *image_array = @[[[NSBundle mainBundle] pathForResource:@"LoadImage.bundle/47/launchImage1-47" ofType:@"png"], [[NSBundle mainBundle] pathForResource:@"LoadImage.bundle/47/launchImage2-47" ofType:@"png"], [[NSBundle mainBundle] pathForResource:@"LoadImage.bundle/47/launchImage3-47" ofType:@"png"]];
            self.launch_array = [NSMutableArray arrayWithArray:@[]];
        }
            break;
    }
    if (_currentStyle == LaunchScrollStyle) {
        self.launch_scroll.contentSize = CGSizeMake(kScreenWidth * self.launch_array.count, kScreenHeight);
        for (int i = 0; i < self.launch_array.count; i ++) {
            UIImage *launchImage = [[UIImage imageWithContentsOfFile:kStringWithFormat(@"%@", [self.launch_array objectAtIndex:i])] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            UIImageView *launchView = [[UIImageView alloc] initWithImage:launchImage];
            launchView.frame = CGRectMake(SCREEN_WIDTH * i, 0, SCREEN_WIDTH, SCREEN_HIGHT);
            if (i == _launch_array.count - 1) {
                launchView.userInteractionEnabled = YES;
                UITapGestureRecognizer *tap_touch = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeLaunchView)];
                [launchView addGestureRecognizer:tap_touch];
            }
            [self.launch_scroll addSubview:launchView];
        }
    } else if (_currentStyle == LaunchAdImageStyle) {
        [self.ad_animation setImagePath:_openImageURL];
    } else {
        [self.ad_animation.ad_imageView setImage:[[UIImage imageWithContentsOfFile:_openImageURL] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    }
}

#pragma mark - 引导页点击按钮
- (void)closeLaunchView
{
    UIImageView *lastImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    [lastImage setImage:[[UIImage imageWithContentsOfFile:kStringWithFormat(@"%@", [self.launch_array lastObject])] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [[UIApplication sharedApplication].keyWindow addSubview:lastImage];
    self.view.hidden = YES;
    [UIView animateWithDuration:UINavigationControllerHideShowBarDuration delay:0.0 usingSpringWithDamping:1 initialSpringVelocity:1 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
        lastImage.frame = CGRectMake(- kScreenWidth, 0, kScreenWidth, kScreenHeight);
        lastImage.alpha = 0;
    } completion:^(BOOL finished) {
        [lastImage removeFromSuperview];
    }];
    self.callback(YES);
}

#pragma mark - 修改当前显示样式(LaunchStyle)
- (void)changeCurrentStyle:(LaunchStyle)style
{
    _currentStyle = style;
    switch (_currentStyle) {
        case LaunchScrollStyle:
        {
            if (_launch_scroll == nil) {
                [self.view addSubview:self.launch_scroll];
            }
            self.launch_scroll.contentSize = CGSizeMake(kScreenWidth * self.launch_array.count, kScreenHeight);
            for (int i = 0; i < self.launch_array.count; i ++) {
                UIImage *launchImage = [[UIImage imageWithContentsOfFile:kStringWithFormat(@"%@", [self.launch_array objectAtIndex:i])] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
                UIImageView *launchView = [[UIImageView alloc] initWithImage:launchImage];
                launchView.frame = CGRectMake(SCREEN_WIDTH * i, 0, SCREEN_WIDTH, SCREEN_HIGHT);
                if (i == _launch_array.count - 1) {
                    launchView.userInteractionEnabled = YES;
                    UITapGestureRecognizer *tap_touch = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeLaunchView)];
                    [launchView addGestureRecognizer:tap_touch];
                }
                [self.launch_scroll addSubview:launchView];
            }
            [self.ad_animation removeFromSuperview];
            _ad_animation = nil;
            [self.view addSubview:self.pageControl];
        }
            break;
        case LaunchAdImageStyle:
        {
            [self.ad_animation setImagePath:_openImageURL];
        }
            break;
        default:
            break;
    }
}

#pragma mark - 引导页--显示完成后关闭回调
- (void)launchShowEnd:(LaunchShowEndBlock)block
{
    self.callback = block;
    if (_currentStyle == LaunchNumStyle) {
        UIImageView *subView = [[UIImageView alloc] initWithImage:_ad_animation.imageView.image];
        subView.frame = _ad_animation.bounds;
        [[UIApplication sharedApplication].keyWindow addSubview:subView];
        [UIView animateWithDuration:0.35 delay:0 usingSpringWithDamping:0.9 initialSpringVelocity:0.7 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
            subView.frame = CGRectMake(-kScreenWidth, 0, kScreenWidth, kScreenHeight);
        } completion:^(BOOL finished) {
            [subView removeFromSuperview];
            [self.view removeAllSubviews];
            [self.view removeFromSuperview];
        }];
        self.callback(YES);
    }
}

#pragma mark - LaunchAdDelegete
- (void)launchAdCloseWithType:(LaunchCloseType)type
{
    UIImageView *subView = [[UIImageView alloc] initWithImage:_ad_animation.imageView.image];
    subView.frame = _ad_animation.bounds;
    [[UIApplication sharedApplication].keyWindow addSubview:subView];
    [UIView animateWithDuration:0.35 delay:0 usingSpringWithDamping:0.9 initialSpringVelocity:0.7 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
        subView.frame = CGRectMake(-kScreenWidth, 0, kScreenWidth, kScreenHeight);
    } completion:^(BOOL finished) {
        [subView removeFromSuperview];
        [self.view removeAllSubviews];
        [self.view removeFromSuperview];
    }];
    switch (type) {
        case LaunchAdCloseWithoutAd:
        {
            self.callback(YES);
        }
            break;
        case LaunchAdCloseWithTouch:
        {
            self.callback(YES);
        }
            break;
        case LaunchAdCloseWithoutTouch:
        {
            self.callback(YES);
        }
            break;
        default:
            break;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger page = scrollView.contentOffset.x / kScreenWidth;
    if (_pageControl.hidden == NO) {
        _pageControl.currentPage = page;
    }
}

#pragma mark - lazy load
- (UIScrollView *)launch_scroll
{
    if (_launch_scroll == nil) {
        _launch_scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HIGHT)];
        _launch_scroll.backgroundColor = [UIColor whiteColor];
        _launch_scroll.showsVerticalScrollIndicator = NO;
        _launch_scroll.showsHorizontalScrollIndicator = NO;
        _launch_scroll.pagingEnabled = YES;
        _launch_scroll.delegate = self;
    }
    return _launch_scroll;
}

- (UIPageControl *)pageControl
{
    if (_pageControl == nil) {
        _pageControl = [UIPageControl new];
        _pageControl.bounds = CGRectMake(0, 0, kScreenWidth, 10);
        _pageControl.center = CGPointMake(kScreenWidth * 0.5, (kDevice_Is_iPhoneX ? kScreenHeight - 60.f : kScreenHeight - 40));
        _pageControl.numberOfPages = 3;
        _pageControl.currentPage = 0;
        _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
        _pageControl.pageIndicatorTintColor = [UIColor grayColor];
        _pageControl.userInteractionEnabled = NO;
        _pageControl.hidden = YES;
    }
    return _pageControl;
}

- (LaunchAdImageView *)ad_animation
{
    if (_ad_animation == nil) {
        _ad_animation = [[LaunchAdImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HIGHT)  Delegate:self];
        _ad_animation.backgroundColor = [UIColor whiteColor];
        _ad_animation.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _ad_animation;
}

- (void)dealloc
{
    FLog(@"launch dealloc");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
