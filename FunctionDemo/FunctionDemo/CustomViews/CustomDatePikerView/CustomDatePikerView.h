//
//  CustomDatePikerView.h
//  GeekRabbit
//
//  Created by FoxDog on 2018/12/5.
//  Copyright © 2018 FoxDog. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomDatePikerMainView.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^PikerDismissBlock)(NSDate *date);

@interface CustomDatePikerView : UIView

@property (nonatomic, strong) NSDate *currentDate;

@property (nonatomic, strong) CustomDatePikerMainView *pickerView;
@property (nonatomic, copy) PikerDismissBlock dismissBlaock;

/**
 便利构造器

 @param completed 关闭之后的callback
 @return 初始化后的CustomDatePikerView对象
 */
+ (CustomDatePikerView *)datePikerViewWithCompleted:(PikerDismissBlock)completed;
/**
 视图弹出
 */
- (void)datePikerViewPresentView;

/**
 视图隐藏
 */
- (void)datePikerViewDismissView;

@end

NS_ASSUME_NONNULL_END
