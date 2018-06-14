//
//  UIView+Corner.h
//  WetalkCommunity
//
//  Created by chaziyjs on 2017/9/22.
//  Copyright © 2017年 chaziyjs. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, CHAZICORNERSIT) {
    CORNERSETALL            =   ~0UL,
    CORNERSETLEFTTOP        =   1 << 0,
    CORNERSETLEFTBOTTOM     =   1 << 1,
    CORNERSETRIGHTTOP       =   1 << 2,
    CORNERSETRIGHTBOTTOM    =   1 << 3
};

@interface UIView (Corner)

- (void)drawRoundRectInContextWithRadius:(CGFloat)radius corners:(UIRectCorner)corners;

@end
