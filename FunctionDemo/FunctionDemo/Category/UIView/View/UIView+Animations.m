//
//  UIView+Animations.m
//  AnywideConvenience
//
//  Created by chaziyjs on 2018/6/21.
//  Copyright © 2018年 Anywide1948. All rights reserved.
//

#import "UIView+Animations.h"

@implementation UIView (Animations)

#pragma mark - 购物车动画
+ (void)addToShoppingCartWithGoodsImage:(UIImage *)goodsImage startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint completion:(void (^)(BOOL))completion {
    
    //------- 创建shapeLayer -------//
    CAShapeLayer *animationLayer = [[CAShapeLayer alloc] init];
    animationLayer.frame = CGRectMake(startPoint.x - 20, startPoint.y - 20, 40, 40);
    animationLayer.contents = (id)goodsImage.CGImage;
    
    // 获取window的最顶层视图控制器
    UIViewController *rootVC = [[UIApplication sharedApplication].delegate window].rootViewController;
    UIViewController *parentVC = rootVC;
    while ((parentVC = rootVC.presentedViewController) != nil ) {
        rootVC = parentVC;
    }
    while ([rootVC isKindOfClass:[UINavigationController class]]) {
        rootVC = [(UINavigationController *)rootVC topViewController];
    }
    
    // 添加layer到顶层视图控制器上
    [rootVC.view.layer addSublayer:animationLayer];
    
    
    //------- 创建移动轨迹 -------//
    UIBezierPath *movePath = [UIBezierPath bezierPath];
    [movePath moveToPoint:startPoint];
    [movePath addQuadCurveToPoint:endPoint controlPoint:CGPointMake(200,100)];
    // 轨迹动画
    CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    CGFloat durationTime = 1; // 动画时间1秒
    pathAnimation.duration = durationTime;
    pathAnimation.removedOnCompletion = NO;
    pathAnimation.fillMode = kCAFillModeForwards;
    pathAnimation.path = movePath.CGPath;
    
    
    //------- 创建缩小动画 -------//
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.fromValue = [NSNumber numberWithFloat:1.0];
    scaleAnimation.toValue = [NSNumber numberWithFloat:0.5];
    scaleAnimation.duration = 1.0;
    scaleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    scaleAnimation.removedOnCompletion = NO;
    scaleAnimation.fillMode = kCAFillModeForwards;
    
    
    // 添加轨迹动画
    [animationLayer addAnimation:pathAnimation forKey:nil];
    // 添加缩小动画
    [animationLayer addAnimation:scaleAnimation forKey:nil];
    
    
    //------- 动画结束后执行 -------//
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(durationTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [animationLayer removeFromSuperlayer];
        completion(YES);
    });
}

#pragma mark - 震动效果
- (void)shakeAnimation
{
    //------- 颤抖吧 -------//
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.fromValue = [NSNumber numberWithFloat:1.0];
    scaleAnimation.toValue = [NSNumber numberWithFloat:0.7];
    scaleAnimation.duration = 0.1;
    scaleAnimation.repeatCount = 2; // 颤抖两次
    scaleAnimation.autoreverses = YES;
    scaleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.layer addAnimation:scaleAnimation forKey:[NSString stringWithFormat:@"%@Aniamtion", [self class]]];
}

#pragma mark - 缩放效果
- (void)scaleAnimation:(float)scale
{
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.fromValue = [NSNumber numberWithFloat:1.0];
    scaleAnimation.toValue = [NSNumber numberWithFloat:scale];
    scaleAnimation.duration = 1.0;
    scaleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    scaleAnimation.removedOnCompletion = NO;
    scaleAnimation.fillMode = kCAFillModeForwards;
    [self.layer addAnimation:scaleAnimation forKey:[NSString stringWithFormat:@"%@Aniamtion", [self class]]];
}

#pragma mark - 雪花飘落效果
- (void)snowAnimation:(UIImage *)snow beginPoint:(CGPoint)startPoint
{
    CAEmitterLayer *snowEmitter = [CAEmitterLayer layer];
    //发射点的位置
    snowEmitter.emitterPosition = startPoint;
    //
    snowEmitter.emitterSize = CGSizeMake(self.bounds.size.width * 2.0, 0.0);
    snowEmitter.emitterShape = kCAEmitterLayerLine;
    snowEmitter.emitterMode = kCAEmitterLayerOutline;
    
    snowEmitter.shadowColor = [UIColor whiteColor].CGColor;
    snowEmitter.shadowOffset = CGSizeMake(0.0, 1.0);
    snowEmitter.shadowRadius = 0.0;
    snowEmitter.shadowOpacity = 1.0;
    
    CAEmitterCell *snowCell = [CAEmitterCell emitterCell];
    
    snowCell.birthRate = 1.0; //每秒出现多少个粒子
    snowCell.lifetime = 120.0; // 粒子的存活时间
    snowCell.velocity = -10; //速度
    snowCell.velocityRange = 10; // 平均速度
    snowCell.yAcceleration = 2;//粒子在y方向上的加速度
    snowCell.emissionRange = 0.5 * M_PI; //发射的弧度
    snowCell.spinRange = 0.25 * M_PI; // 粒子的平均旋转速度
    snowCell.contents = (id)snow.CGImage;
    snowCell.color = [UIColor colorWithRed:0.6 green:0.658 blue:0.743 alpha:1.0].CGColor;
    snowEmitter.emitterCells = @[snowCell];
    [self.layer insertSublayer:snowEmitter atIndex:0];
}

#pragma mark - 喷射效果
- (void)jetAnimation:(UIImage *)jetImg
{
    CAEmitterLayer *snowEmitter = [CAEmitterLayer layer];
    //发射点的位置
    snowEmitter.emitterPosition = self.center;
    //
    snowEmitter.emitterSize = CGSizeMake(10.0, 0.0);
    snowEmitter.emitterShape = kCAEmitterLayerLine;
    snowEmitter.emitterMode = kCAEmitterLayerOutline;
    
    CAEmitterCell *snowCell = [CAEmitterCell emitterCell];
    
    snowCell.birthRate = 50.0;
    snowCell.lifetime = 10.0;
    snowCell.velocity = 40;
    snowCell.velocityRange = 10;
    snowCell.yAcceleration = 2;
    snowCell.emissionRange =  M_PI / 9;
    snowCell.scale = 0.1; //缩小比例
    snowCell.scaleRange = 0.08;// 平均缩小比例
    snowCell.contents = (id)jetImg.CGImage;
    snowCell.color = [UIColor colorWithRed:0.6 green:0.658 blue:0.743 alpha:1.0].CGColor;
    
    snowEmitter.emitterCells = @[snowCell];
    
    [self.layer insertSublayer:snowEmitter atIndex:0];
}

#pragma mark - 烟火效果
- (void)fireworksAnimation:(UIImage *)fire
{
    CAEmitterLayer *emitter = [CAEmitterLayer layer];
    emitter.frame = self.bounds;
    [self.layer addSublayer:emitter];
    
    //configure emitter
    emitter.renderMode = kCAEmitterLayerAdditive;
    emitter.emitterPosition = self.center;
    emitter.emitterSize = CGSizeMake(25, 0);
    
    //create a particle template
    CAEmitterCell *cell = [[CAEmitterCell alloc] init];
    cell.contents = (id)fire.CGImage;
    cell.birthRate = 150;
    cell.lifetime = 5.0;
    cell.alphaSpeed = -0.4;
    cell.velocity = 50;
    cell.velocityRange = 50;
    cell.scale = 0.1;
    cell.scaleRange = 0.08;
    cell.emissionRange = M_PI * 2.0;
    
    emitter.emitterCells = @[cell];
}

#pragma mark - 水纹效果动画
- (void)waveAnimation:(UIColor *)waveColor
{
    self.layer.backgroundColor = [UIColor clearColor].CGColor;
    CAShapeLayer *pulseLayer = [CAShapeLayer layer];
    pulseLayer.frame = self.layer.bounds;
    pulseLayer.path = [UIBezierPath bezierPathWithOvalInRect:pulseLayer.bounds].CGPath;
    pulseLayer.fillColor = waveColor.CGColor;
    pulseLayer.opacity = 0.0;
    
    CAReplicatorLayer *replicatorLayer = [CAReplicatorLayer layer];
    replicatorLayer.frame = self.bounds;
    replicatorLayer.instanceCount = 8;
    replicatorLayer.instanceDelay = 0.5;
    [replicatorLayer addSublayer:pulseLayer];
    [self.layer addSublayer:replicatorLayer];
    
    CABasicAnimation *opacityAnima = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnima.fromValue = @(0.3);
    opacityAnima.toValue = @(0.0);
    
    CABasicAnimation *scaleAnima = [CABasicAnimation animationWithKeyPath:@"transform"];
    scaleAnima.fromValue = [NSValue valueWithCATransform3D:CATransform3DScale(CATransform3DIdentity, 0.0, 0.0, 0.0)];
    scaleAnima.toValue = [NSValue valueWithCATransform3D:CATransform3DScale(CATransform3DIdentity, 1.0, 1.0, 0.0)];
    
    CAAnimationGroup *groupAnima = [CAAnimationGroup animation];
    groupAnima.animations = @[opacityAnima, scaleAnima];
    groupAnima.duration = 4.0;
    groupAnima.autoreverses = NO;
    groupAnima.repeatCount = HUGE;
    [pulseLayer addAnimation:groupAnima forKey:@"groupAnimation"];
}

#pragma mark - 翻转效果
- (void)rotateAnimation
{
    CGFloat margin = 5.0;
    CGFloat width = self.layer.bounds.size.width;
    CGFloat dotW = (width - 2 * margin) / 3;
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.frame = CGRectMake(0, (width - dotW) * 0.5, dotW, dotW);
    shapeLayer.path = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, dotW, dotW)].CGPath;
    shapeLayer.fillColor = [UIColor redColor].CGColor;
    
    CAReplicatorLayer *replicatorLayer = [CAReplicatorLayer layer];
    replicatorLayer.frame = CGRectMake(0, 0, width, width);
    replicatorLayer.instanceDelay = 0.1;
    replicatorLayer.instanceCount = 3;
    CATransform3D transform = CATransform3DMakeTranslation(margin + dotW, 0, 0);
    
    replicatorLayer.instanceTransform = transform;
    [replicatorLayer addSublayer:shapeLayer];
    [self.layer addSublayer:replicatorLayer];
    
    CABasicAnimation *basicAnima = [CABasicAnimation animationWithKeyPath:@"transform"];
    basicAnima.fromValue = [NSValue valueWithCATransform3D:CATransform3DRotate(CATransform3DIdentity, 0, 0, 1.0, 0)];
    basicAnima.toValue = [NSValue valueWithCATransform3D:CATransform3DRotate(CATransform3DIdentity, M_PI, 0, 1.0, 0)];
    basicAnima.repeatCount = HUGE;
    basicAnima.duration = 0.6;
    
    [shapeLayer addAnimation:basicAnima forKey:@"scaleAnimation"];
}

#pragma mark - 闪烁效果
- (void)shineAnimation
{
    CGFloat margin = 5.0;
    CGFloat cols = 3;
    CGFloat width = self.layer.bounds.size.width;
    CGFloat dotW = (width - margin * (cols - 1)) / cols;
    
    CAShapeLayer *dotLayer = [CAShapeLayer layer];
    dotLayer.frame = CGRectMake(0, 0, dotW, dotW);
    dotLayer.path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, dotW, dotW)].CGPath;
    dotLayer.fillColor = [UIColor redColor].CGColor;
    
    CAReplicatorLayer *replicatorLayerX = [CAReplicatorLayer layer];
    replicatorLayerX.frame = CGRectMake(0, 0, width, width);
    replicatorLayerX.instanceDelay = 0.3;
    replicatorLayerX.instanceCount = cols;
    [replicatorLayerX addSublayer:dotLayer];
    
    CATransform3D transform = CATransform3DTranslate(CATransform3DIdentity, dotW + margin, 0, 0);
    replicatorLayerX.instanceTransform = transform;
    transform = CATransform3DScale(transform, 1, -1, 0);
    
    CAReplicatorLayer *replicatorLayerY = [CAReplicatorLayer layer];
    replicatorLayerY.frame = CGRectMake(0, 0, width, width);
    replicatorLayerY.instanceDelay = 0.3;
    replicatorLayerY.instanceCount = 3;
    [replicatorLayerY addSublayer:replicatorLayerX];
    
    CATransform3D transforY = CATransform3DTranslate(CATransform3DIdentity, 0, dotW + margin, 0);
    replicatorLayerY.instanceTransform = transforY;
    
    
    [self.layer addSublayer:replicatorLayerY];
    //    [self.layer addSublayer:replicatorLayerX];
    
    //添加动画
    CABasicAnimation *opacityAnima = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnima.fromValue = @(0.3);
    opacityAnima.toValue = @(0.3);
    
    CABasicAnimation *scaleAnima = [CABasicAnimation animationWithKeyPath:@"transform"];
    scaleAnima.fromValue = [NSValue valueWithCATransform3D:CATransform3DScale(CATransform3DIdentity, 1.0, 1.0, 0.0)];
    scaleAnima.toValue = [NSValue valueWithCATransform3D:CATransform3DScale(CATransform3DIdentity, 0.2, 0.2, 0.0)];
    
    CAAnimationGroup *groupAnima = [CAAnimationGroup animation];
    groupAnima.animations = @[opacityAnima, scaleAnima];
    groupAnima.duration = 1.0;
    groupAnima.autoreverses = YES;
    groupAnima.repeatCount = HUGE;
    [dotLayer addAnimation:groupAnima forKey:@"groupAnimation"];
}

@end
