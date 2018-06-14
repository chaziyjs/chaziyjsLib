//
//  UILabel+FitSize.m
//  OneWillBuy
//
//  Created by 源叔 on 16/4/23.
//  Copyright © 2016年 anywide. All rights reserved.
//

#import "UILabel+FitSize.h"

@implementation UILabel (FitSize)

//适配高度
+ (CGFloat)getHeightByWidth:(CGFloat)width title:(NSString *)title font:(UIFont *)font {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, 0)];
    label.text = title;
    label.font = font;
    label.numberOfLines = 0;
    label.lineBreakMode = NSLineBreakByWordWrapping;
    [label sizeToFit];
    CGFloat height = label.frame.size.height;
    return height;
}

//适配宽度
+ (CGFloat)getWidthByHeight:(CGFloat)height title:(NSString *)title font:(UIFont *)font {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, height)];
    label.text = title;
    label.font = font;
    label.numberOfLines = 0;
    label.lineBreakMode = NSLineBreakByWordWrapping;
    [label sizeToFit];
    CGFloat width = label.frame.size.width;
    return width;
}

@end
