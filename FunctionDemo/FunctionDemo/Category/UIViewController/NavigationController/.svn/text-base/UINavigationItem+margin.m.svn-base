//
//  UINavigationItem+margin.m
//  OneWillBuy
//
//  Created by 源叔 on 16/5/23.
//  Copyright © 2016年 anywide. All rights reserved.
//

#import "UINavigationItem+margin.h"

@implementation UINavigationItem (margin)
- (void)buildleftBarButtonItem:(UIBarButtonItem *)_leftBarButtonItem
{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 11.0)
    {
        UIBarButtonItem *negativeSeperator = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        negativeSeperator.width = -16;
        
        if (_leftBarButtonItem)
        {
            [self setLeftBarButtonItems:@[negativeSeperator, _leftBarButtonItem]];
        } else {
            [self setLeftBarButtonItems:@[negativeSeperator]];
        }
    } else {
        [self setLeftBarButtonItem:_leftBarButtonItem animated:NO];
    }
}

- (void)buildrightBarButtonItem:(UIBarButtonItem *)_rightBarButtonItem
{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 11.0)
    {
        UIBarButtonItem *negativeSeperator = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        negativeSeperator.width = -16;
        if (_rightBarButtonItem)
        {
            [self setRightBarButtonItems:@[negativeSeperator, _rightBarButtonItem]];
        }
        else
        {
            [self setRightBarButtonItems:@[negativeSeperator]];
        }
    } else {
        [self setRightBarButtonItem:_rightBarButtonItem animated:NO];
    }
}

@end
