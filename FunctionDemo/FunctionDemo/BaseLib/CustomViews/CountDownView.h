//
//  CountDownView.h
//  communityDemo
//
//  Created by chaziyjs on 2017/9/14.
//  Copyright © 2017年 chaziyjs. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, CountDownType)
{
    CountDownTrack      =   1,
    CountDownProcess    =   2
};

@interface CountDownView : UILabel

@property (nonatomic, assign) CountDownType flag;
@property (nonatomic, strong) UIColor *strokeColor;
@property (nonatomic, assign) CGFloat times;

@end
