//
//  UIView+Corner.h
//  WetalkCommunity
//
//  Created by chaziyjs on 2017/9/22.
//  Copyright © 2017年 chaziyjs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Corner)

- (void)drawRoundRectInContextWithRadius:(CGFloat)radius corners:(UIRectCorner)corners LineWidth:(CGFloat)lineWidth LineColor:(UIColor *)lineColor;

@end
