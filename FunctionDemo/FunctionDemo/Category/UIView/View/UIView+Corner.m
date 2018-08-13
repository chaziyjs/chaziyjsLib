//
//  UIView+Corner.m
//  WetalkCommunity
//
//  Created by chaziyjs on 2017/9/22.
//  Copyright © 2017年 chaziyjs. All rights reserved.
//

#import "UIView+Corner.h"

@implementation UIView (Corner)

- (void)drawRoundRectInContextWithRadius:(CGFloat)radius corners:(UIRectCorner)corners LineWidth:(CGFloat)lineWidth LineColor:(UIColor *)lineColor
{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:CGSizeMake(radius, radius)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    if (lineWidth != 0.f) {
        maskLayer.lineWidth = lineWidth;
        maskLayer.strokeColor = lineColor.CGColor;
    }
    self.layer.mask = maskLayer;
}

@end
