//
//  CountDownView.m
//  communityDemo
//
//  Created by chaziyjs on 2017/9/14.
//  Copyright © 2017年 chaziyjs. All rights reserved.
//

#import "CountDownView.h"

@implementation CountDownView {
    BOOL draw;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.textAlignment = NSTextAlignmentCenter;
        draw = NO;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    if (draw == NO) {
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        shapeLayer.frame = self.bounds;
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(CGRectGetWidth(self.frame) * 0.5, CGRectGetHeight(self.frame) * 0.5) radius:CGRectGetHeight(self.frame) * 0.5 startAngle:-M_PI_2 endAngle:M_PI * 3 / 2 clockwise:1];
        shapeLayer.path = path.CGPath;
        shapeLayer.fillColor = [UIColor clearColor].CGColor;
        shapeLayer.lineWidth = 2.0f;
        shapeLayer.strokeColor = kColorThemeGreen.CGColor;
        
        if (self.flag == CountDownTrack) {
            //每个虚线长度为2，间隔为3
            shapeLayer.lineDashPattern = [NSArray arrayWithObjects:[NSNumber numberWithInt:2], [NSNumber numberWithInt:3], nil];
        }
        
        [self.layer addSublayer:shapeLayer];
        
        CABasicAnimation *pathAnima = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        pathAnima.duration = self.times;
        pathAnima.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
        pathAnima.fromValue = [NSNumber numberWithFloat:0.0f];
        pathAnima.toValue = [NSNumber numberWithFloat:1.0f];
        pathAnima.fillMode = kCAFillModeForwards;
        pathAnima.removedOnCompletion = NO;
        [shapeLayer addAnimation:pathAnima forKey:@"strokeEndAnimation"];
        draw = YES;
    }
}


@end
