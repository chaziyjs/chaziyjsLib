//
//  CustomDatePikerMainView.h
//  GeekRabbit
//
//  Created by FoxDog on 2018/12/4.
//  Copyright © 2018 FoxDog. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DatePikerTitleView.h"

NS_ASSUME_NONNULL_BEGIN

@interface CustomDatePikerMainView : UIView

@property (nonatomic, strong) UIDatePicker *datePiker;
@property (nonatomic, strong) DatePikerTitleView *titleView;

//相关参数
@property (nonatomic, strong) NSDate *minimumDate;
@property (nonatomic, strong) NSDate *maximumDate;
@property (nonatomic, strong) NSDate *date;

- (UIButton *)addLeftItemWithTitle:(nullable NSString *)title
                             Image:(nullable UIImage *)img
                            Target:(id)target
                          Selector:(SEL)selector;

- (UIButton *)addRightItemWithTitle:(nullable NSString *)title
                              Image:(nullable UIImage *)img
                             Target:(id)target
                           Selector:(SEL)selector;

@end

NS_ASSUME_NONNULL_END
