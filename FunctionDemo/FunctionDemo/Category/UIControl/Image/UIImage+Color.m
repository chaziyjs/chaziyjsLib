//
//  UIImage+Color.m
//  WetalkCommunity
//
//  Created by chaziyjs on 2017/9/15.
//  Copyright © 2017年 chaziyjs. All rights reserved.
//

#import "UIImage+Color.h"

@implementation UIImage (Color)

+ (UIImage *)ImageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0, 0, 1.0, 1.0);
    UIGraphicsBeginImageContextWithOptions(rect.size, false, 0);
    [color setFill];
    UIRectFill(rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
