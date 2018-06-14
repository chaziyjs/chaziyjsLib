//
//  SelectorConfig.h
//  WetalkCommunity
//
//  Created by chaziyjs on 2017/9/13.
//  Copyright © 2017年 chaziyjs. All rights reserved.
//

#ifndef SelectorConfig_h
#define SelectorConfig_h
#import "UIColor+Color.h"

#define kScreenWidth ([[UIScreen mainScreen] bounds].size.width)
#define kScreenHeight ([[UIScreen mainScreen] bounds].size.height)

//Color
#define kColorWithRGB(_R,_G,_B)                 ((UIColor *)[UIColor colorWithRed:_R/255.0 green:_G/255.0 blue:_B/255.0 alpha:1.0])
#define kColorWithRGBA(_R,_G,_B,_A)             ((UIColor *)[UIColor colorWithRed:_R/255.0 green:_G/255.0 blue:_B/255.0 alpha:_A])
#define kColorWithCode(string)                  ((UIColor *)[UIColor colorWithString:string])


#define kColorShowOffRedRP                      kColorWithCode(@"#DB2844")
#define kColorGrayBG                            kColorWithCode(@"#f4f4f4")  //主要用于原tv.bg ||view.bg ||非细cell分割线  的 f1eeec 颜色替换
#define kColorGraySPLine                        kColorWithCode(@"#ECECEC")  //用于原细分割线替换
#define kColorBlackContent                      kColorWithCode(@"#323232") //用于原黑色字体替换 1f1f1f
#define kColorBlueContent                       kColorWithCode(@"#5a97d0")  //用于原蓝色字体替换 0084ff
#define kColorGrayContent                       kColorWithCode(@"#8F8F8F")  //用于原灰色字体替换 999999
#define kColorDeepWhite                         kColorWithCode(@"#ffffff")
#define kColorRedContent                        kColorWithCode(@"#d91d36") //红色文字共通 label&&btn
#define kColorGraySpecialContent                kColorWithCode(@"#c3c3c3") //进度条下面灰色
#define kColorGreenGoldBean                     kColorWithCode(@"#40bb0a") //我的竞猜绿色金豆
#define kcolorTVGrayBorder                      kColorWithCode(@"#eeeeee") //支付列表TV边框颜色
#define kColorOrange                            kColorWithCode(@"#ffba00") //橙色（礼品中心头部）
#define kColorBlackBean                         kColorWithCode(@"#333333") //金豆弹窗黑色
#define kColorRedBean                           kColorWithCode(@"#E94230") //金豆获取按钮红色
#define kColorRedBeanLabel                      kColorWithCode(@"#ff4141") //金豆文字红色
#define kColorGraySmallTitle                    kColorWithCode(@"#999999") //抽奖灰色小标题
#define kColorGrayBtn                           kColorWithCode(@"#cdcdcd") //抽奖灰色按钮
#define kColorBlackTitle                        kColorWithCode(@"#666666") //抽奖黑色标题
#define kColorPinkCellBG                        kColorWithCode(@"#fff6fb") //智能追号粉cell
#define KColorOrangeText                        kColorWithCode(@"#FF7E00") //橘黄文字颜色
#define kColorClear                             kColorWithRGBA(0,0,0,0)     //透明
#define kColorDeepBlack                         kColorWithCode(@"#000000") //深黑色
#define kColorCommunityGray                     kColorWithCode(@"#e7e7e7") //圈子首页板块背景及分割线
#define kColorOrangeCommunityBoard              kColorWithCode(@"#FE983E") //圈子板块选中
#define kColorGrayBoardBG                       kColorWithCode(@"#F8F8F8") //圈子板块背景色
#define KColorRedClosure                        kColorWithCode(@"#F43531")  //我的封禁3天红色
#define kColorGrayText                          kColorWithCode(@"#888888")  //无数种灰色文字中的一种
#define kColorBlueText                          kColorWithCode(@"#5374a4")  //无数种蓝色文字中的一种
#define kColorGrayPlaceholder                   kColorWithCode(@"#cccccc") //placeholder灰色，eg:签名textfield 灰色
#define kColorLVYellow                          kColorWithCode(@"#ffc000") //个人等级背景黄

#define kColorMoenyCost                         kColorWithCode(@"#EF4B35")//鲜花消耗红
#define AppRed                                  kColorWithRGB(255,126,0)//商城文字颜色
/*
 *  Standard UserDefaults
 */
#define kStandardUserDefaults                   [NSUserDefaults standardUserDefaults]
#define kStandardUserDefaultsObject(_KEY)       [kStandardUserDefaults objectForKey:_KEY]
#define kSaveStandardUserDefaults(_O,_K)        [kStandardUserDefaults setObject:_O forKey:_K]
#define kRemoveStandardUserDefaults(_K)         [kStandardUserDefaults removeObjectForKey:_K]
#define kStandardUserDefaultsSync               [kStandardUserDefaults synchronize]

//String
#define kStringWithFormat(_O,_S)                [NSString stringWithFormat:_O,_S]

//Font
#define CUSTOMFONT(s)                           [UIFont fontWithName:([[UIFont familyNames] containsObject:@"PingFang SC"] ? @"PingFang SC" : @"Helvetica") size:s]
//Image
#define CUSTOMIMG(name)                         [UIImage imageNamed:name]

//Size
#define iPhone4s                                (kScreenWidth == 320 ? YES : NO)
#define IPhone6p                                (kScreenHeight >= 736 ? YES : NO)
#define Adaptation                              (IPhone6p ? 1.1 : 1.0)
#define HH                          kScreenHeight / 667.0
#define WW                          kScreenWidth / 375.0

//IfLogined
//判断用户登录状态 if kUserLoginStatement == nil    如果 == nil 未登录, != nil登录
#define kUserLoginStatement         kStandardUserDefaultsObject(@"userCookies")


//判断附近人列表头部是否点击X关闭，一天后再显示，继续日期
#define kNearByPeopleSettingDate    kStandardUserDefaultsObject(@"NearByDate")

//判断我的参与，点击进入后，红点一天后再显示，记录日期
#define kMyAttentionClickDate    kStandardUserDefaultsObject(kStandardUserDefaultsObject(@"userid"))

#define     kEnableAliRemain                @"mall_alipay_cash_btn_show"//是否显示支付宝余额按钮


//weak self
#define     kWeakSelf(type)                     __weak typeof(type) weak##type = type
#define     kStrongSelf(type)                   __strong typeof(type) strong##type = weak##type

//Log
#ifdef      DEBUG    //处于开发阶段
#define     FLog(...)                           NSLog(@"%s 第%d行 \n %@\n\n",__func__,__LINE__,[NSString stringWithFormat:__VA_ARGS__])
//#define     FLog(format, ...)                   printf("[%s] %s [第%d行]\n %s\n", __TIME__, __FUNCTION__, __LINE__, [[NSString stringWithFormat:format, ## __VA_ARGS__] UTF8String]);
#else           //处于发布阶段
#define     FLog(...)
#endif


//App info
#define	kAppDisplayName                         [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"]
#define	kAppVersion                             [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]//plist文件App版本号
#define	kAppIdentifier                          [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleIdentifier"]
#define kAppBuildVersion                        [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"]

#define kDevice_Is_iPhoneX                      ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
//System version
#define SYS_VERSION                             floorf([[UIDevice currentDevice].systemVersion floatValue])
#define IS_IOS_8                                floorf([[UIDevice currentDevice].systemVersion integerValue]) == 8 ? 1 : 0
#define IS_IOS_9                                floorf([[UIDevice currentDevice].systemVersion integerValue]) == 9 ? 1 : 0
#define IS_IOS_10                               floorf([[UIDevice currentDevice].systemVersion integerValue]) == 10 ? 1 : 0
#define IS_IOS_11                               floorf([[UIDevice currentDevice].systemVersion integerValue]) == 11 ? 1 : 0

#endif /* SelectorConfig_h */
