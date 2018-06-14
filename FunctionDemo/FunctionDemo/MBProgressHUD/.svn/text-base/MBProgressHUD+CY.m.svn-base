//
//  MBProgressHUD+CY.m
//  WetalkCommunity
//
//  Created by chaziyjs on 2017/9/15.
//  Copyright © 2017年 chaziyjs. All rights reserved.
//

#import "MBProgressHUD+CY.h"

@implementation MBProgressHUD (CY)

+ (MBProgressHUD *)createHUD:(UIView *)view
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    if (view == nil) view = window;
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithWindow:window];
    HUD.labelFont = CUSTOMFONT(13.f);
    [view addSubview:HUD];
    [HUD show:YES];
    HUD.animationType = MBProgressHUDAnimationZoom;
    HUD.removeFromSuperViewOnHide = YES;
    return HUD;
}


+ (void)show:(NSString *)text icon:(NSString *)icon during:(CGFloat)times view:(UIView *)view
{
    // 快速显示一个提示信息
    MBProgressHUD *HUD = [MBProgressHUD createHUD:view];
    if (icon) {
        HUD.square = YES;
    }
    HUD.labelFont = CUSTOMFONT(14.f);
    
    HUD.labelText = text;
    // 设置图片
    HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:icon]];
    // 再设置模式
    HUD.mode = MBProgressHUDModeCustomView;
    HUD.animationType = MBProgressHUDAnimationZoom;
    
    // 隐藏时候从父控件中移除
    HUD.removeFromSuperViewOnHide = YES;
    
    [HUD hide:YES afterDelay:times];
    
}

+ (MBProgressHUD *)showCustomAnimate:(NSString *)text imageName:(NSString *)imageName imageCounts:(NSInteger)imageCounts view:(UIView *)view
{
    MBProgressHUD *HUD = [MBProgressHUD createHUD:view];
    HUD.color = [UIColor clearColor];
    HUD.labelText = text;
    HUD.square = YES;
    HUD.labelColor = kColorBlackBean;
    HUD.labelFont = CUSTOMFONT(14.f);
    HUD.mode = MBProgressHUDModeCustomView;
    
    NSString *image_path = [[NSBundle mainBundle] pathForResource:@"Loading" ofType:@"bundle"];
    UIImageView *animateGifView = [[UIImageView alloc] initWithImage:[[UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@", image_path, [NSString stringWithFormat:@"%@00.png",imageName]]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    animateGifView.frame = CGRectMake(0, 0, 60, 60);
    animateGifView.contentMode = UIViewContentModeScaleAspectFit;
    NSMutableArray *gifArray = [NSMutableArray array];
    for (int i = 1; i <= imageCounts; i ++) {
        NSString *image_name = [NSString stringWithFormat:@"%@00%zd.png", imageName, i];
        UIImage *images = [[UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@", image_path, image_name]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [gifArray addObject:images];
    }
    
    [animateGifView setAnimationImages:gifArray];
    [animateGifView setAnimationDuration:2.0];
    [animateGifView setAnimationRepeatCount:0];
    [animateGifView startAnimating];
    
    HUD.customView = animateGifView;

    return HUD;
}


+ (void)drawErrorViewWithText:(NSString *)text during:(CGFloat)times view:(UIView *)view
{
    MBProgressHUD *HUD = [MBProgressHUD createHUD:view];
    HUD.color = kcolorTVGrayBorder;
    HUD.mode = MBProgressHUDModeCustomView;
    HUD.labelText = text;
    HUD.labelColor = kColorBlackBean;
    HUD.square = YES;
    CAShapeLayer *layer = [CAShapeLayer layer];
    UIImageView *iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 55, 55)];
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.frame = iconImageView.bounds;
    [iconImageView.layer addSublayer: layer];
    layer.strokeColor = kColorWithCode(@"#FF7E00").CGColor;
    HUD.customView = iconImageView;
    [HUD hide:YES afterDelay:times];

    const int STROKE_WIDTH = 3;// 默认的划线线条宽度
    
    // 绘制外部透明的圆形
    UIBezierPath *circlePath = [UIBezierPath bezierPath];
    [circlePath addArcWithCenter: CGPointMake(layer.frame.size.width / 2, layer.frame.size.height / 2) radius:layer.frame.size.width / 2 - STROKE_WIDTH startAngle:  0 * M_PI/180 endAngle: 360 * M_PI/180 clockwise: NO];
    // 创建外部透明圆形的图层
    CAShapeLayer *alphaLineLayer = [CAShapeLayer layer];
    alphaLineLayer.path = circlePath.CGPath;// 设置透明圆形的绘图路径
    alphaLineLayer.strokeColor = [[UIColor colorWithCGColor: layer.strokeColor] colorWithAlphaComponent: 0.1].CGColor;
    // ↑ 设置图层的透明圆形的颜色，取图标颜色之后设置其对应的0.1透明度的颜色
    alphaLineLayer.lineWidth = STROKE_WIDTH;// 设置圆形的线宽
    alphaLineLayer.fillColor = [UIColor clearColor].CGColor;// 填充颜色透明
    
    [layer addSublayer: alphaLineLayer];// 把外部半透明圆形的图层加到当前图层上
    
    // 开始画叉的两条线，首先画逆时针旋转的线
    CAShapeLayer *leftLayer = [CAShapeLayer layer];
    // 设置当前图层的绘制属性
    leftLayer.frame = layer.bounds;
    leftLayer.fillColor = [UIColor clearColor].CGColor;
    leftLayer.lineCap = kCALineCapRound;// 圆角画笔
    leftLayer.lineWidth = STROKE_WIDTH;
    leftLayer.strokeColor = layer.strokeColor;
    
    // 半圆+动画的绘制路径初始化
    UIBezierPath *leftPath = [UIBezierPath bezierPath];
    // 绘制大半圆
    [leftPath addArcWithCenter: CGPointMake(layer.frame.size.width / 2, layer.frame.size.height / 2) radius:layer.frame.size.width / 2 - STROKE_WIDTH startAngle:  -43 * M_PI / 180 endAngle: -315 * M_PI / 180 clockwise: NO];
    [leftPath addLineToPoint: CGPointMake(layer.frame.size.width * 0.35, layer.frame.size.width * 0.35)];
    // 把路径设置为当前图层的路径
    leftLayer.path = leftPath.CGPath;
    
    [layer addSublayer: leftLayer];
    
    // 逆时针旋转的线
    CAShapeLayer *rightLayer = [CAShapeLayer layer];
    // 设置当前图层的绘制属性
    rightLayer.frame = layer.bounds;
    rightLayer.fillColor = [UIColor clearColor].CGColor;
    rightLayer.lineCap = kCALineCapRound;// 圆角画笔
    rightLayer.lineWidth = STROKE_WIDTH;
    rightLayer.strokeColor = layer.strokeColor;
    
    // 半圆+动画的绘制路径初始化
    UIBezierPath *rightPath = [UIBezierPath bezierPath];
    // 绘制大半圆
    [rightPath addArcWithCenter: CGPointMake(layer.frame.size.width / 2, layer.frame.size.height / 2) radius:layer.frame.size.width / 2 - STROKE_WIDTH  startAngle:  -128 * M_PI / 180 endAngle: 133 * M_PI / 180 clockwise: YES];
    [rightPath addLineToPoint: CGPointMake(layer.frame.size.width * 0.65, layer.frame.size.width * 0.35)];
    // 把路径设置为当前图层的路径
    rightLayer.path = rightPath.CGPath;
    
    [layer addSublayer: rightLayer];
    
    
    CAMediaTimingFunction *timing = [[CAMediaTimingFunction alloc] initWithControlPoints:0.3 :0.6 :0.8 :1.1];
    // 创建路径顺序绘制的动画
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath: @"strokeEnd"];
    animation.duration = 0.5;// 动画使用时间
    animation.fromValue = [NSNumber numberWithInt: 0.0];// 从头
    animation.toValue = [NSNumber numberWithInt: 1.0];// 画到尾
    // 创建路径顺序从结尾开始消失的动画
    CABasicAnimation *strokeStartAnimation = [CABasicAnimation animationWithKeyPath: @"strokeStart"];
    strokeStartAnimation.duration = 0.4;// 动画使用时间
    strokeStartAnimation.beginTime = CACurrentMediaTime() + 0.2;// 延迟0.2秒执行动画
    strokeStartAnimation.fromValue = [NSNumber numberWithFloat: 0.0];// 从开始消失
    strokeStartAnimation.toValue = [NSNumber numberWithFloat: 0.84];// 一直消失到整个绘制路径的84%，这个数没有啥技巧，一点点调试看效果，希望看此代码的人不要被这个数值怎么来的困惑
    strokeStartAnimation.timingFunction = timing;
    
    leftLayer.strokeStart = 0.84;// 设置最终效果，防止动画结束之后效果改变
    leftLayer.strokeEnd = 1.0;
    rightLayer.strokeStart = 0.84;// 设置最终效果，防止动画结束之后效果改变
    rightLayer.strokeEnd = 1.0;
    
    
    [leftLayer addAnimation: animation forKey: @"strokeEnd"];// 添加俩动画
    [leftLayer addAnimation: strokeStartAnimation forKey: @"strokeStart"];
    [rightLayer addAnimation: animation forKey: @"strokeEnd"];// 添加俩动画
    [rightLayer addAnimation: strokeStartAnimation forKey: @"strokeStart"];
    
}

+ (void)drawRightViewWithText:(NSString *)text during:(CGFloat)times view:(UIView *)view
{
    MBProgressHUD *HUD = [MBProgressHUD createHUD:view];
    HUD.color = kcolorTVGrayBorder;
    HUD.mode = MBProgressHUDModeCustomView;
    HUD.labelText = text;
    HUD.labelColor = kColorBlackBean;
    HUD.square = YES;
    CAShapeLayer *layer = [CAShapeLayer layer];
    UIImageView *iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 55, 55)];
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.frame = iconImageView.bounds;
    [iconImageView.layer addSublayer: layer];
    layer.strokeColor = kColorWithCode(@"#FF7E00").CGColor;
    HUD.customView = iconImageView;
    [HUD hide:YES afterDelay:times];

    
    const int STROKE_WIDTH = 3;// 默认的划线线条宽度
    
    // 绘制外部透明的圆形
    UIBezierPath *circlePath = [UIBezierPath bezierPath];
    [circlePath addArcWithCenter: CGPointMake(layer.frame.size.width / 2, layer.frame.size.height / 2) radius:layer.frame.size.width / 2 - STROKE_WIDTH startAngle:  0 * M_PI/180 endAngle: 360 * M_PI/180 clockwise: NO];
    // 创建外部透明圆形的图层
    CAShapeLayer *alphaLineLayer = [CAShapeLayer layer];
    alphaLineLayer.path = circlePath.CGPath;// 设置透明圆形的绘图路径
    alphaLineLayer.strokeColor = [[UIColor colorWithCGColor: layer.strokeColor] colorWithAlphaComponent: 0.1].CGColor;// 设置图层的透明圆形的颜色
    alphaLineLayer.lineWidth = STROKE_WIDTH;// 设置圆形的线宽
    alphaLineLayer.fillColor = [UIColor clearColor].CGColor;// 填充颜色透明
    
    [layer addSublayer: alphaLineLayer];// 把外部半透明圆形的图层加到当前图层上
    
    // 设置当前图层的绘制属性
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.lineCap = kCALineCapRound;// 圆角画笔
    layer.lineWidth = STROKE_WIDTH;
    
    // 半圆+动画的绘制路径初始化
    UIBezierPath *path = [UIBezierPath bezierPath];
    // 绘制大半圆
    [path addArcWithCenter: CGPointMake(layer.frame.size.width / 2, layer.frame.size.height / 2) radius:layer.frame.size.width / 2 - STROKE_WIDTH startAngle:  67 * M_PI / 180 endAngle: -158 * M_PI / 180 clockwise: NO];
    // 绘制对号第一笔
    [path addLineToPoint: CGPointMake(layer.frame.size.width * 0.42, layer.frame.size.width * 0.68)];
    // 绘制对号第二笔
    [path addLineToPoint: CGPointMake(layer.frame.size.width * 0.75, layer.frame.size.width * 0.35)];
    // 把路径设置为当前图层的路径
    layer.path = path.CGPath;
    
    CAMediaTimingFunction *timing = [[CAMediaTimingFunction alloc] initWithControlPoints:0.3 :0.6 :0.8 :1.1];
    // 创建路径顺序绘制的动画
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath: @"strokeEnd"];
    animation.duration = 0.5;// 动画使用时间
    animation.fromValue = [NSNumber numberWithInt: 0.0];// 从头
    animation.toValue = [NSNumber numberWithInt: 1.0];// 画到尾
    // 创建路径顺序从结尾开始消失的动画
    CABasicAnimation *strokeStartAnimation = [CABasicAnimation animationWithKeyPath: @"strokeStart"];
    strokeStartAnimation.duration = 0.4;// 动画使用时间
    strokeStartAnimation.beginTime = CACurrentMediaTime() + 0.2;// 延迟0.2秒执行动画
    strokeStartAnimation.fromValue = [NSNumber numberWithFloat: 0.0];// 从开始消失
    strokeStartAnimation.toValue = [NSNumber numberWithFloat: 0.74];// 一直消失到整个绘制路径的74%，这个数没有啥技巧，一点点调试看效果，希望看此代码的人不要被这个数值怎么来的困惑
    strokeStartAnimation.timingFunction = timing;
    
    layer.strokeStart = 0.74;// 设置最终效果，防止动画结束之后效果改变
    layer.strokeEnd = 1.0;
    
    [layer addAnimation: animation forKey: @"strokeEnd"];// 添加俩动画
    [layer addAnimation: strokeStartAnimation forKey: @"strokeStart"];
}



+ (MBProgressHUD *)drawRoundLoadingView:(NSString *)text view:(UIView *)view {
    
    MBProgressHUD *HUD = [MBProgressHUD createHUD:view];
    HUD.color = kcolorTVGrayBorder;
    HUD.mode = MBProgressHUDModeCustomView;
    HUD.labelText = text;
    HUD.labelColor = kColorBlackBean;
    HUD.square = YES;
    CAShapeLayer *layer = [CAShapeLayer layer];
    UIImageView *iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 55, 55)];
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.frame = iconImageView.bounds;
    [iconImageView.layer addSublayer: layer];
    layer.strokeColor = kColorWithCode(@"#FF7E00").CGColor;
    HUD.customView = iconImageView;

    const int STROKE_WIDTH = 3;
    
    // 绘制外部透明的圆形
    UIBezierPath *circlePath = [UIBezierPath bezierPath];
    [circlePath addArcWithCenter: CGPointMake(layer.frame.size.width / 2, layer.frame.size.height / 2) radius:layer.frame.size.width / 2 - STROKE_WIDTH startAngle:  0 * M_PI/180 endAngle: 360 * M_PI/180 clockwise: NO];
    // 创建外部透明圆形的图层
    CAShapeLayer *alphaLineLayer = [CAShapeLayer layer];
    alphaLineLayer.path = circlePath.CGPath;// 设置透明圆形的绘图路径
    alphaLineLayer.strokeColor = [[UIColor colorWithCGColor: layer.strokeColor] colorWithAlphaComponent: 0.1].CGColor;// 设置图层的透明圆形的颜色
    alphaLineLayer.lineWidth = STROKE_WIDTH;// 设置圆形的线宽
    alphaLineLayer.fillColor = [UIColor clearColor].CGColor;// 填充颜色透明
    
    [layer addSublayer: alphaLineLayer];// 把外部半透明圆形的图层加到当前图层上
    
    CAShapeLayer *drawLayer = [CAShapeLayer layer];
    UIBezierPath *progressPath = [UIBezierPath bezierPath];
    [progressPath addArcWithCenter: CGPointMake(layer.frame.size.width / 2, layer.frame.size.height / 2) radius:layer.frame.size.width / 2 - STROKE_WIDTH startAngle: 0 * M_PI / 180 endAngle: 360 * M_PI / 180 clockwise: YES];
    
    drawLayer.lineWidth = STROKE_WIDTH;
    drawLayer.fillColor = [UIColor clearColor].CGColor;
    drawLayer.path = progressPath.CGPath;
    drawLayer.frame = drawLayer.bounds;
    drawLayer.strokeColor = layer.strokeColor;
    [layer addSublayer: drawLayer];
    
    CAMediaTimingFunction *progressRotateTimingFunction = [CAMediaTimingFunction functionWithControlPoints:0.25 :0.80 :0.75 :1.00];
    
    // 开始划线的动画
    CABasicAnimation *progressLongAnimation = [CABasicAnimation animationWithKeyPath: @"strokeEnd"];
    progressLongAnimation.fromValue = [NSNumber numberWithFloat: 0.0];
    progressLongAnimation.toValue = [NSNumber numberWithFloat: 1.0];
    progressLongAnimation.duration = 2;
    progressLongAnimation.timingFunction = progressRotateTimingFunction;
    progressLongAnimation.repeatCount = 10000;
    // 线条逐渐变短收缩的动画
    CABasicAnimation *progressLongEndAnimation = [CABasicAnimation animationWithKeyPath: @"strokeStart"];
    progressLongEndAnimation.fromValue = [NSNumber numberWithFloat: 0.0];
    progressLongEndAnimation.toValue = [NSNumber numberWithFloat: 1.0];
    progressLongEndAnimation.duration = 2;
    CAMediaTimingFunction *strokeStartTimingFunction = [[CAMediaTimingFunction alloc] initWithControlPoints: 0.65 : 0.0 :1.0 : 1.0];
    progressLongEndAnimation.timingFunction = strokeStartTimingFunction;
    progressLongEndAnimation.repeatCount = 10000;
    // 线条不断旋转的动画
    CABasicAnimation *progressRotateAnimation = [CABasicAnimation animationWithKeyPath: @"transform.rotation.z"];
    progressRotateAnimation.fromValue = [NSNumber numberWithFloat: 0.0];
    progressRotateAnimation.toValue = [NSNumber numberWithFloat: M_PI / 180 * 360];
    progressRotateAnimation.repeatCount = 1000000;
    progressRotateAnimation.duration = 6;
    
    [drawLayer addAnimation:progressLongAnimation forKey: @"strokeEnd"];
    [layer addAnimation:progressRotateAnimation forKey: @"transfrom.rotation.z"];
    [drawLayer addAnimation: progressLongEndAnimation forKey: @"strokeStart"];
    
    return HUD;
}

+ (void)showError:(NSString *)error during:(CGFloat)times view:(UIView *)view
{
    [self show:error icon:@"error" during:times view:view];
}

+ (void)showSuccess:(NSString *)success during:(CGFloat)times view:(UIView *)view
{
    [self show:success icon:@"success" during:times view:view];
}

+ (void)showTitle:(NSString *)title Detail:(NSString *)detail View:(UIView *)view During:(CGFloat)times
{
    MBProgressHUD *HUD = [MBProgressHUD createHUD:view];
    HUD.color = kcolorTVGrayBorder;
    HUD.mode = MBProgressHUDModeText;
    HUD.labelText = title;
    HUD.detailsLabelText = detail;
    HUD.detailsLabelFont = CUSTOMFONT(10.f);
    HUD.labelFont = CUSTOMFONT(14.f);
    HUD.labelColor = kColorBlackBean;
    [HUD hide:YES afterDelay:times];
}

+ (MBProgressHUD *)showNotice:(NSString *)notice view:(UIView *)view during:(CGFloat)times
{
    MBProgressHUD *HUD = [MBProgressHUD createHUD:view];
    HUD.mode = MBProgressHUDModeText;
    HUD.color = kcolorTVGrayBorder;
    HUD.labelText = notice;
    HUD.labelFont = CUSTOMFONT(14.f);
    HUD.labelColor = kColorBlackBean;
    [HUD hide:YES afterDelay:times];
    return HUD;
}

+ (MBProgressHUD *)defaultMBProgress:(UIView *)view
{
    MBProgressHUD *HUD = [MBProgressHUD createHUD:view];
    HUD.mode = MBProgressHUDModeIndeterminate;
    HUD.color = kcolorTVGrayBorder;//默认黑色
    HUD.activityIndicatorColor = kColorWithCode(@"#FF7E00");//菊花颜色
    return HUD;
}

+ (MBProgressHUD *)defaultMBProgressWithText:(NSString *)text view:(UIView *)view
{
    MBProgressHUD *HUD = [MBProgressHUD createHUD:view];
    HUD.color = kcolorTVGrayBorder;
    HUD.mode = MBProgressHUDModeIndeterminate;
    HUD.square = YES;
    HUD.labelFont = CUSTOMFONT(14.f);
    HUD.labelText = text;
    HUD.labelColor = kColorBlackBean;
    
    return HUD;
}


+ (MBProgressHUD *)circleMBProgressWithText:(NSString *)text view:(UIView *)view
{
    MBProgressHUD *HUD = [MBProgressHUD createHUD:view];
    HUD.mode = MBProgressHUDModeDeterminate;
    HUD.square = YES;
    HUD.labelFont = CUSTOMFONT(13.f);
    HUD.labelText = text;
    
    return HUD;
}

#pragma mark - 富文本文字显示
+ (void)drawRightViewWithAttributedText:(NSMutableAttributedString *)text during:(CGFloat)times view:(UIView *)view
{
    MBProgressHUD *HUD = [MBProgressHUD createHUD:view];
    HUD.color = kcolorTVGrayBorder;
    HUD.mode = MBProgressHUDModeCustomView;
    HUD.labelColor = kColorBlackBean;
    HUD.labelAttributedString = text;
    HUD.square = YES;
    CAShapeLayer *layer = [CAShapeLayer layer];
    UIImageView *iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 55, 55)];
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.frame = iconImageView.bounds;
    [iconImageView.layer addSublayer: layer];
    layer.strokeColor = kColorWithCode(@"#FF7E00").CGColor;
    HUD.customView = iconImageView;
    [HUD hide:YES afterDelay:times];
    
    const int STROKE_WIDTH = 3;// 默认的划线线条宽度
    
    // 绘制外部透明的圆形
    UIBezierPath *circlePath = [UIBezierPath bezierPath];
    [circlePath addArcWithCenter: CGPointMake(layer.frame.size.width / 2, layer.frame.size.height / 2) radius:layer.frame.size.width / 2 - STROKE_WIDTH startAngle:  0 * M_PI/180 endAngle: 360 * M_PI/180 clockwise: NO];
    // 创建外部透明圆形的图层
    CAShapeLayer *alphaLineLayer = [CAShapeLayer layer];
    alphaLineLayer.path = circlePath.CGPath;// 设置透明圆形的绘图路径
    alphaLineLayer.strokeColor = [[UIColor colorWithCGColor: layer.strokeColor] colorWithAlphaComponent: 0.1].CGColor;// 设置图层的透明圆形的颜色
    alphaLineLayer.lineWidth = STROKE_WIDTH;// 设置圆形的线宽
    alphaLineLayer.fillColor = [UIColor clearColor].CGColor;// 填充颜色透明
    
    [layer addSublayer: alphaLineLayer];// 把外部半透明圆形的图层加到当前图层上
    
    // 设置当前图层的绘制属性
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.lineCap = kCALineCapRound;// 圆角画笔
    layer.lineWidth = STROKE_WIDTH;
    
    // 半圆+动画的绘制路径初始化
    UIBezierPath *path = [UIBezierPath bezierPath];
    // 绘制大半圆
    [path addArcWithCenter: CGPointMake(layer.frame.size.width / 2, layer.frame.size.height / 2) radius:layer.frame.size.width / 2 - STROKE_WIDTH startAngle:  67 * M_PI / 180 endAngle: -158 * M_PI / 180 clockwise: NO];
    // 绘制对号第一笔
    [path addLineToPoint: CGPointMake(layer.frame.size.width * 0.42, layer.frame.size.width * 0.68)];
    // 绘制对号第二笔
    [path addLineToPoint: CGPointMake(layer.frame.size.width * 0.75, layer.frame.size.width * 0.35)];
    // 把路径设置为当前图层的路径
    layer.path = path.CGPath;
    
    CAMediaTimingFunction *timing = [[CAMediaTimingFunction alloc] initWithControlPoints:0.3 :0.6 :0.8 :1.1];
    // 创建路径顺序绘制的动画
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath: @"strokeEnd"];
    animation.duration = 0.5;// 动画使用时间
    animation.fromValue = [NSNumber numberWithInt: 0.0];// 从头
    animation.toValue = [NSNumber numberWithInt: 1.0];// 画到尾
    // 创建路径顺序从结尾开始消失的动画
    CABasicAnimation *strokeStartAnimation = [CABasicAnimation animationWithKeyPath: @"strokeStart"];
    strokeStartAnimation.duration = 0.4;// 动画使用时间
    strokeStartAnimation.beginTime = CACurrentMediaTime() + 0.2;// 延迟0.2秒执行动画
    strokeStartAnimation.fromValue = [NSNumber numberWithFloat: 0.0];// 从开始消失
    strokeStartAnimation.toValue = [NSNumber numberWithFloat: 0.74];// 一直消失到整个绘制路径的74%，这个数没有啥技巧，一点点调试看效果，希望看此代码的人不要被这个数值怎么来的困惑
    strokeStartAnimation.timingFunction = timing;
    
    layer.strokeStart = 0.74;// 设置最终效果，防止动画结束之后效果改变
    layer.strokeEnd = 1.0;
    
    [layer addAnimation: animation forKey: @"strokeEnd"];// 添加俩动画
    [layer addAnimation: strokeStartAnimation forKey: @"strokeStart"];
}

+ (void)drawErrorViewWithAttributedText:(NSMutableAttributedString *)text during:(CGFloat)times view:(UIView *)view
{
    MBProgressHUD *HUD = [MBProgressHUD createHUD:view];
    HUD.color = kcolorTVGrayBorder;
    HUD.mode = MBProgressHUDModeCustomView;
    HUD.labelColor = kColorBlackBean;
    HUD.labelAttributedString = text;
    HUD.square = YES;
    CAShapeLayer *layer = [CAShapeLayer layer];
    UIImageView *iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 55, 55)];
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.frame = iconImageView.bounds;
    [iconImageView.layer addSublayer: layer];
    layer.strokeColor = kColorWithCode(@"#FF7E00").CGColor;
    HUD.customView = iconImageView;
    [HUD hide:YES afterDelay:times];
    
    const int STROKE_WIDTH = 3;// 默认的划线线条宽度
    
    // 绘制外部透明的圆形
    UIBezierPath *circlePath = [UIBezierPath bezierPath];
    [circlePath addArcWithCenter: CGPointMake(layer.frame.size.width / 2, layer.frame.size.height / 2) radius:layer.frame.size.width / 2 - STROKE_WIDTH startAngle:  0 * M_PI/180 endAngle: 360 * M_PI/180 clockwise: NO];
    // 创建外部透明圆形的图层
    CAShapeLayer *alphaLineLayer = [CAShapeLayer layer];
    alphaLineLayer.path = circlePath.CGPath;// 设置透明圆形的绘图路径
    alphaLineLayer.strokeColor = [[UIColor colorWithCGColor: layer.strokeColor] colorWithAlphaComponent: 0.1].CGColor;
    // ↑ 设置图层的透明圆形的颜色，取图标颜色之后设置其对应的0.1透明度的颜色
    alphaLineLayer.lineWidth = STROKE_WIDTH;// 设置圆形的线宽
    alphaLineLayer.fillColor = [UIColor clearColor].CGColor;// 填充颜色透明
    
    [layer addSublayer: alphaLineLayer];// 把外部半透明圆形的图层加到当前图层上
    
    // 开始画叉的两条线，首先画逆时针旋转的线
    CAShapeLayer *leftLayer = [CAShapeLayer layer];
    // 设置当前图层的绘制属性
    leftLayer.frame = layer.bounds;
    leftLayer.fillColor = [UIColor clearColor].CGColor;
    leftLayer.lineCap = kCALineCapRound;// 圆角画笔
    leftLayer.lineWidth = STROKE_WIDTH;
    leftLayer.strokeColor = layer.strokeColor;
    
    // 半圆+动画的绘制路径初始化
    UIBezierPath *leftPath = [UIBezierPath bezierPath];
    // 绘制大半圆
    [leftPath addArcWithCenter: CGPointMake(layer.frame.size.width / 2, layer.frame.size.height / 2) radius:layer.frame.size.width / 2 - STROKE_WIDTH startAngle:  -43 * M_PI / 180 endAngle: -315 * M_PI / 180 clockwise: NO];
    [leftPath addLineToPoint: CGPointMake(layer.frame.size.width * 0.35, layer.frame.size.width * 0.35)];
    // 把路径设置为当前图层的路径
    leftLayer.path = leftPath.CGPath;
    
    [layer addSublayer: leftLayer];
    
    // 逆时针旋转的线
    CAShapeLayer *rightLayer = [CAShapeLayer layer];
    // 设置当前图层的绘制属性
    rightLayer.frame = layer.bounds;
    rightLayer.fillColor = [UIColor clearColor].CGColor;
    rightLayer.lineCap = kCALineCapRound;// 圆角画笔
    rightLayer.lineWidth = STROKE_WIDTH;
    rightLayer.strokeColor = layer.strokeColor;
    
    // 半圆+动画的绘制路径初始化
    UIBezierPath *rightPath = [UIBezierPath bezierPath];
    // 绘制大半圆
    [rightPath addArcWithCenter: CGPointMake(layer.frame.size.width / 2, layer.frame.size.height / 2) radius:layer.frame.size.width / 2 - STROKE_WIDTH  startAngle:  -128 * M_PI / 180 endAngle: 133 * M_PI / 180 clockwise: YES];
    [rightPath addLineToPoint: CGPointMake(layer.frame.size.width * 0.65, layer.frame.size.width * 0.35)];
    // 把路径设置为当前图层的路径
    rightLayer.path = rightPath.CGPath;
    
    [layer addSublayer: rightLayer];
    
    
    CAMediaTimingFunction *timing = [[CAMediaTimingFunction alloc] initWithControlPoints:0.3 :0.6 :0.8 :1.1];
    // 创建路径顺序绘制的动画
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath: @"strokeEnd"];
    animation.duration = 0.5;// 动画使用时间
    animation.fromValue = [NSNumber numberWithInt: 0.0];// 从头
    animation.toValue = [NSNumber numberWithInt: 1.0];// 画到尾
    // 创建路径顺序从结尾开始消失的动画
    CABasicAnimation *strokeStartAnimation = [CABasicAnimation animationWithKeyPath: @"strokeStart"];
    strokeStartAnimation.duration = 0.4;// 动画使用时间
    strokeStartAnimation.beginTime = CACurrentMediaTime() + 0.2;// 延迟0.2秒执行动画
    strokeStartAnimation.fromValue = [NSNumber numberWithFloat: 0.0];// 从开始消失
    strokeStartAnimation.toValue = [NSNumber numberWithFloat: 0.84];// 一直消失到整个绘制路径的84%，这个数没有啥技巧，一点点调试看效果，希望看此代码的人不要被这个数值怎么来的困惑
    strokeStartAnimation.timingFunction = timing;
    
    leftLayer.strokeStart = 0.84;// 设置最终效果，防止动画结束之后效果改变
    leftLayer.strokeEnd = 1.0;
    rightLayer.strokeStart = 0.84;// 设置最终效果，防止动画结束之后效果改变
    rightLayer.strokeEnd = 1.0;
    
    
    [leftLayer addAnimation: animation forKey: @"strokeEnd"];// 添加俩动画
    [leftLayer addAnimation: strokeStartAnimation forKey: @"strokeStart"];
    [rightLayer addAnimation: animation forKey: @"strokeEnd"];// 添加俩动画
    [rightLayer addAnimation: strokeStartAnimation forKey: @"strokeStart"];
    
}

+ (MBProgressHUD *)drawRoundLoadingViewWithAttributedString:(NSMutableAttributedString *)text view:(UIView *)view
{
    MBProgressHUD *HUD = [MBProgressHUD createHUD:view];
    HUD.color = kcolorTVGrayBorder;
    HUD.mode = MBProgressHUDModeCustomView;
    HUD.labelColor = kColorBlackBean;
    HUD.labelAttributedString = text;
    HUD.square = YES;
    CAShapeLayer *layer = [CAShapeLayer layer];
    UIImageView *iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 55, 55)];
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.frame = iconImageView.bounds;
    [iconImageView.layer addSublayer: layer];
    layer.strokeColor = kColorWithCode(@"#FF7E00").CGColor;
    HUD.customView = iconImageView;
    
    const int STROKE_WIDTH = 3;
    
    // 绘制外部透明的圆形
    UIBezierPath *circlePath = [UIBezierPath bezierPath];
    [circlePath addArcWithCenter: CGPointMake(layer.frame.size.width / 2, layer.frame.size.height / 2) radius:layer.frame.size.width / 2 - STROKE_WIDTH startAngle:  0 * M_PI/180 endAngle: 360 * M_PI/180 clockwise: NO];
    // 创建外部透明圆形的图层
    CAShapeLayer *alphaLineLayer = [CAShapeLayer layer];
    alphaLineLayer.path = circlePath.CGPath;// 设置透明圆形的绘图路径
    alphaLineLayer.strokeColor = [[UIColor colorWithCGColor: layer.strokeColor] colorWithAlphaComponent: 0.1].CGColor;// 设置图层的透明圆形的颜色
    alphaLineLayer.lineWidth = STROKE_WIDTH;// 设置圆形的线宽
    alphaLineLayer.fillColor = [UIColor clearColor].CGColor;// 填充颜色透明
    
    [layer addSublayer: alphaLineLayer];// 把外部半透明圆形的图层加到当前图层上
    
    CAShapeLayer *drawLayer = [CAShapeLayer layer];
    UIBezierPath *progressPath = [UIBezierPath bezierPath];
    [progressPath addArcWithCenter: CGPointMake(layer.frame.size.width / 2, layer.frame.size.height / 2) radius:layer.frame.size.width / 2 - STROKE_WIDTH startAngle: 0 * M_PI / 180 endAngle: 360 * M_PI / 180 clockwise: YES];
    
    drawLayer.lineWidth = STROKE_WIDTH;
    drawLayer.fillColor = [UIColor clearColor].CGColor;
    drawLayer.path = progressPath.CGPath;
    drawLayer.frame = drawLayer.bounds;
    drawLayer.strokeColor = layer.strokeColor;
    [layer addSublayer: drawLayer];
    
    CAMediaTimingFunction *progressRotateTimingFunction = [CAMediaTimingFunction functionWithControlPoints:0.25 :0.80 :0.75 :1.00];
    
    // 开始划线的动画
    CABasicAnimation *progressLongAnimation = [CABasicAnimation animationWithKeyPath: @"strokeEnd"];
    progressLongAnimation.fromValue = [NSNumber numberWithFloat: 0.0];
    progressLongAnimation.toValue = [NSNumber numberWithFloat: 1.0];
    progressLongAnimation.duration = 2;
    progressLongAnimation.timingFunction = progressRotateTimingFunction;
    progressLongAnimation.repeatCount = 10000;
    // 线条逐渐变短收缩的动画
    CABasicAnimation *progressLongEndAnimation = [CABasicAnimation animationWithKeyPath: @"strokeStart"];
    progressLongEndAnimation.fromValue = [NSNumber numberWithFloat: 0.0];
    progressLongEndAnimation.toValue = [NSNumber numberWithFloat: 1.0];
    progressLongEndAnimation.duration = 2;
    CAMediaTimingFunction *strokeStartTimingFunction = [[CAMediaTimingFunction alloc] initWithControlPoints: 0.65 : 0.0 :1.0 : 1.0];
    progressLongEndAnimation.timingFunction = strokeStartTimingFunction;
    progressLongEndAnimation.repeatCount = 10000;
    // 线条不断旋转的动画
    CABasicAnimation *progressRotateAnimation = [CABasicAnimation animationWithKeyPath: @"transform.rotation.z"];
    progressRotateAnimation.fromValue = [NSNumber numberWithFloat: 0.0];
    progressRotateAnimation.toValue = [NSNumber numberWithFloat: M_PI / 180 * 360];
    progressRotateAnimation.repeatCount = 1000000;
    progressRotateAnimation.duration = 6;
    
    [drawLayer addAnimation:progressLongAnimation forKey: @"strokeEnd"];
    [layer addAnimation:progressRotateAnimation forKey: @"transfrom.rotation.z"];
    [drawLayer addAnimation: progressLongEndAnimation forKey: @"strokeStart"];
    
    return HUD;
}

+ (MBProgressHUD *)showAttributedNotice:(NSMutableAttributedString *)notice view:(UIView *)view during:(CGFloat)times
{
    MBProgressHUD *HUD = [MBProgressHUD createHUD:view];
    HUD.mode = MBProgressHUDModeText;
    HUD.color = kcolorTVGrayBorder;
    HUD.labelColor = kColorBlackBean;
    HUD.labelAttributedString = notice;
    HUD.labelFont = CUSTOMFONT(14.f);
    [HUD hide:YES afterDelay:times];
    return HUD;
}

+ (void)showAttributedTitle:(NSMutableAttributedString *)title AttributedDetail:(NSMutableAttributedString *)detail View:(UIView *)view During:(CGFloat)times
{
    MBProgressHUD *HUD = [MBProgressHUD createHUD:view];
    HUD.color = kcolorTVGrayBorder;
    HUD.mode = MBProgressHUDModeText;
    HUD.detailsLabelFont = CUSTOMFONT(10.f);
    HUD.labelFont = CUSTOMFONT(14.f);
    HUD.labelColor = kColorBlackBean;
    HUD.labelAttributedString = title;
    HUD.detailAttributedString = detail;
    [HUD hide:YES afterDelay:times];
}

@end
