//
//  PayAlertView.h
//  AnywideConvenience
//
//  Created by chaziyjs on 2018/6/15.
//  Copyright © 2018年 Anywide1948. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PayAlertContentView.h"

@interface PayAlertView : UIView

@property (nonatomic, strong) PayAlertContentView *contentView;

+ (PayAlertView *)payAlertWithTitle:(NSString *)title Message:(NSString *)msg Image:(UIImage *)image ImageSize:(CGSize)imagesize AlertStyle:(PayAlertStyle)style;

- (void)addAction:(PayAlertAction *)action;

- (void)payAlertViewPresentComplete:(void (^)(BOOL finished))completed;

- (void)payAlertViewDismissComplete:(void (^)(BOOL finished))completed;

@end
