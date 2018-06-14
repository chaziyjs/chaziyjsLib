//
//  UIView+Additions.h
//  Additions
//
//  Created by Johnil on 13-6-7.
//  Copyright (c) 2013年 Johnil. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^touchBlock)(UITouch *t, UIView *target);

@interface UIView (Additions)
- (float)x;
- (float)y;
- (float)width;
- (float)height;

- (void)setX:(float)x;
- (void)setY:(float)y;
- (void)setWidth:(float)w;
- (void)setHeight:(float)h;

- (float)boundsWidth;
- (float)boundsHeight;
- (void)setBoundsWidth:(float)w;
- (void)setBoundsHeight:(float)h;
//
- (void)fadeIn;
- (void)fadeOut;
- (void)fadeInOnComplet:(void(^)(BOOL f))complet;
- (void)fadeOutOnComplet:(void(^)(BOOL f))complet;

- (void)removeAllSubviews;
- (void)removeSubviewWithTag:(NSInteger)tag;
- (void)removeSubviewExceptTag:(NSInteger)tag;
- (void)removeSubviewExceptClass:(Class)viewClass;

- (UIImage *)toAlphaRetinaImageRealTime;
- (UIImage *)toRetinaImage;
- (UIImage *)toAlphaRetinaImage;

+ (UIImage *)viewShot:(UIView *)currentView;

- (UIImage *)toImageWithRect:(CGRect)frame withAlpha:(BOOL)alpha;
- (UIImage *)visbleToImage;


- (void)addShadowWithColor:(UIColor *)color;
- (void)addShadow;
- (void)addShadowWithAlpha:(float)alpha;
- (void)removeShadow;
- (UIView *)findAndResignFirstResponder;

- (UIView *)addLine:(UIColor *)color frame:(CGRect)frame;

- (void)addCorner;
- (void)shake:(float)range;
- (void)shakeRepeat:(float)range;
- (void)shakeX:(float)range;


+ (void)vveboAnimations:(void (^)(void))animations;
+ (void)vveboAnimations:(void (^)(void))animations completion:(void (^)(BOOL finished))completion;

+ (void)vveboAnimateWithDuration:(NSTimeInterval)duration animations:(void (^)(void))animations;
+ (void)vveboAnimateWithDuration:(NSTimeInterval)duration animations:(void (^)(void))animations completion:(void (^)(BOOL finished))completion;
+ (void)vveboAnimateWithDuration:(NSTimeInterval)duration delay:(NSTimeInterval)delay animations:(void (^)(void))animations completion:(void (^)(BOOL finished))completion;
+ (void)vveboAnimateWithDuration:(NSTimeInterval)duration delay:(NSTimeInterval)delay options:(UIViewAnimationOptions)options animations:(void (^)(void))animations completion:(void (^)(BOOL finished))completion;

- (BOOL)hasActionSheetOrAlert;
- (UIView *)subviewWithTag:(NSInteger)tag;
@end
