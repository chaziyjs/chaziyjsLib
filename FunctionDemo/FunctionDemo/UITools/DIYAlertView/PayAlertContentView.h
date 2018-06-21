//
//  PayAlertContentView.h
//  AnywideConvenience
//
//  Created by chaziyjs on 2018/6/15.
//  Copyright © 2018年 Anywide1948. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PayAlertAction.h"

typedef NS_ENUM(NSUInteger, PayAlertStyle)
{
    PayAlertTitleWithImage      =   10,
    PayAlertWithoutImage        =   100
};

@interface PayAlertContentView : UIView

@property (nonatomic, copy) NSString *titleStr;
@property (nonatomic, copy) NSString *detailStr;
@property (nonatomic, strong) UIImage *iconImg;

- (void)createCountViewWithTitle:(NSString *)title
                  ContentMessage:(NSString *)message
                       LoadImage:(UIImage *)image
                       imageSize:(CGSize)imageSize
                    ContentStyle:(PayAlertStyle)contentStyle;

- (void)setButtonArray:(NSMutableArray <__kindof PayAlertAction *> *)buttonArray;

@end
