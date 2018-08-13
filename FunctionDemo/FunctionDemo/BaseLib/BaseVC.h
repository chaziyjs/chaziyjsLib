//
//  BaseVC.h
//  WetalkCommunity
//
//  Created by chaziyjs on 2017/9/15.
//  Copyright © 2017年 chaziyjs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SelectorConfig.h"
#import "UIViewController+EX.h"
#import "UIViewController+MBHUD.h"

typedef NS_ENUM (NSInteger, BasePopType){
    BasePopType_Root = 1000,
    BasePopType_My,
    BasePopType_Pop
};

@class HomeVC;

@interface BaseVC : UIViewController

@property (nonatomic, strong) UIButton *backbtn;

/**
 返回按钮压下

 @param btn 返回按钮
 */
- (void)backClick:(UIButton *)btn;

/**
 登录提示弹窗

 @param title Alert Title
 @param message  Alert Message
 @param type Dismiss Type
 */
- (void)alertLoginWithTitle:(NSString *)title
                    Message:(NSString *)message
                DismissType:(BasePopType)type;
/**
 跳转登录界面
 @param type 跳转源类型
 */
- (void)gotoLogin:(BasePopType)type;
//登录成功
- (void)loginSuccess:(NSNotification *)notice;

//已退出登录或掉线
- (void)loginLost:(NSNotification *)notice;

@end
