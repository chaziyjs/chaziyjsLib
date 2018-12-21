//
//  CustomInputView.h
//  GeekRabbit
//
//  Created by FoxDog on 2018/11/7.
//  Copyright © 2018 FoxDog. All rights reserved.
//

#import <UIKit/UIKit.h>
#define     VIEWHEIGHT      (64.f)
#define     IPADMAXWIDTH    (285.f)

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, CustomInputStyleModel)
{
    CustomInputSecureTextEntryModel     =   1,
    CustomInputNormalTextEntryModel     =   0
};

@class CustomInputView;
@protocol CustomInputViewDelegate <NSObject>

@optional
- (void)inputViewWillBeginEditing:(CustomInputView * _Nonnull)inputView;
- (void)inputView:(CustomInputView * _Nonnull)inputView DidEndEditing:(NSString *)content;
- (void)inputViewIsEdting:(CustomInputView * _Nonnull)inputView CurrentText:(NSString *)text;

@end

@interface CustomInputView : UIView<UITextFieldDelegate, CAAnimationDelegate>

@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UILabel *titleView;

@property (nonatomic, copy) NSString *titleStr;
/// 标题
@property (nonatomic, strong) UIFont *textFont;
/// 输入文字的字体样式
@property (nonatomic, strong) UIColor *textColor;
/// 输入文字的样色样式
@property (nonatomic, copy) NSString *placeholder;
/// 占位文字内容
@property (nonatomic, strong) UIColor *placeholderColor;
/// 占位文字颜色样式
@property (nonatomic, strong) UIFont *placeholderFont;
/// 占位文字字体样式
@property (nonatomic, assign) UIKeyboardType keyboardType;
/// 唤起键盘样式
@property (nonatomic, strong) UIImage *clearBtn_img;
/// 清空按钮图片
@property (nonatomic, strong) UIColor *sepline_normalColor;
/// 一般情况下底线颜色
@property (nonatomic, strong) UIColor *sepline_editColor;
/// 编辑状态下底线颜色
@property (nonatomic, assign) NSUInteger inputMaxLength;
/// 可输入最长字符串长度
@property (nonatomic, assign) CustomInputStyleModel styleModel;
/// 输入内容的现实模式 : 正常现实, 隐藏现实

@property (nonatomic, weak) id<CustomInputViewDelegate> delegate;


+ (CustomInputView *)createInputViewInPoint:(CGPoint)point
                                  WithWidth:(CGFloat)width;

@end

NS_ASSUME_NONNULL_END
