//
//  UIView+Animations.h
//  AnywideConvenience
//
//  Created by chaziyjs on 2018/6/21.
//  Copyright © 2018年 Anywide1948. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Animations)

+ (void)addToShoppingCartWithGoodsImage:(UIImage *)goodsImage startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint completion:(void (^)(BOOL))completion;

- (void)shakeAnimation;

- (void)scaleAnimation:(float)scale;

- (void)snowAnimation:(UIImage *)snow beginPoint:(CGPoint)startPoint;

- (void)jetAnimation:(UIImage *)jetImg;

- (void)fireworksAnimation:(UIImage *)fire;

- (void)waveAnimation:(UIColor *)waveColor;

- (void)rotateAnimation;

- (void)shineAnimation;

@end
