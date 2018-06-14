//
//  UILabel+FitSize.h
//  OneWillBuy
//
//  Created by 源叔 on 16/4/23.
//  Copyright © 2016年 anywide. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (FitSize)

+ (CGFloat)getHeightByWidth:(CGFloat)width title:(NSString *)title font:(UIFont *)font;
+ (CGFloat)getWidthByHeight:(CGFloat)height title:(NSString *)title font:(UIFont *)font;

@end
