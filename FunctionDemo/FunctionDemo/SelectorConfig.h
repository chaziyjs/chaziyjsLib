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

#define     kScreenWidth                            CGRectGetWidth([UIScreen mainScreen].bounds)
#define     kScreenHeight                           CGRectGetHeight([UIScreen mainScreen].bounds)

//Color
#define     kColorWithRGB(_R,_G,_B)                 ((UIColor *)[UIColor colorWithRed:_R/255.0 green:_G/255.0 blue:_B/255.0 alpha:1.0])
#define     kColorWithRGBA(_R,_G,_B,_A)             ((UIColor *)[UIColor colorWithRed:_R/255.0 green:_G/255.0 blue:_B/255.0 alpha:_A])
#define     kColorWithCode(string)                  ((UIColor *)[UIColor colorWithString:string])


#define     kColorShowOffRedRP                      kColorWithCode(@"#DB2844")
#define     kColorBGGray                            kColorWithCode(@"#F4F4F4")
#define     kColorLightGray                         kColorWithCode(@"#AAAAAA")
#define     kColorPlaceGray                         kColorWithCode(@"#BBBBBB")
#define     kColorTextGray                          kColorWithCode(@"#ECECEC")
#define     kColorPriceGray                         kColorWithCode(@"#666666")
#define     kColorTabbarGray                        kColorWithCode(@"#999999")
#define     kColorBGLightGray                       kColorWithCode(@"#F3F3F3")
#define     kColorMiddleGray                        kColorWithCode(@"#8F8F8F")
#define     kColorMiddleLightGray                   kColorWithCode(@"#F8F8F8")
#define     kColorPriceRed                          kColorWithCode(@"#F43530")
#define     kColorPayRed                            kColorWithCode(@"#FF2113")
#define     kColorCartRed                           kColorWithCode(@"#FC3535")
#define     kColorAccumulatePointsLightRed          kColorWithCode(@"#EC635D")
#define     kColorAccumulatePointsDarkRed           kColorWithCode(@"#F53939")
#define     kColorGiftCertificateRed                kColorWithCode(@"#E50000")
#define     kColorThemeGreen                        kColorWithCode(@"#489E38")
#define     kColorTitleBlack                        kColorWithCode(@"#333333")
#define     kColorTimeBlack                         kColorWithCode(@"#323232")
#define     kColorAllCountBlack                     kColorWithCode(@"#4E4E4E")
#define     kColorLightWhite                        kColorWithCode(@"#FFFFFF")
#define     kColorLogisticalOrange                  kColorWithCode(@"#F58E41")
#define     kColorLogisticalYellow                  kColorWithCode(@"#FDF8CE")
#define     kColorMyGreen                           kColorWithCode(@"#3E9252")
#define     kColorInfoWhite                         kColorWithCode(@"#FFFFFD")
#define     kColorPureBlack                         kColorWithCode(@"#000000")
#define     kColorVersionGray                       kColorWithCode(@"#9A9A9A")
#define     kColorUpdateGreen                       kColorWithCode(@"#1B793A")
#define     kColorMemberBlue                        kColorWithCode(@"#0C223C")
#define     kColorMemberOrange                      kColorWithCode(@"#E79731")

/*
 *  Standard UserDefaults
 */
#define     kStandardUserDefaults                   [NSUserDefaults standardUserDefaults]
#define     kStandardUserDefaultsObject(_KEY)       [kStandardUserDefaults objectForKey:_KEY]
#define     kSaveStandardUserDefaults(_O,_K)        [kStandardUserDefaults setObject:_O forKey:_K]
#define     kRemoveStandardUserDefaults(_K)         [kStandardUserDefaults removeObjectForKey:_K]
#define     kStandardUserDefaultsSync               [kStandardUserDefaults synchronize]

//String
#define     kStringWithFormat(_O,_S)                [NSString stringWithFormat:_O,_S]

//Font
#define     CUSTOMFONT(s)                           [UIFont fontWithName:([[UIFont familyNames] containsObject:@"PingFang SC"] ? @"PingFang SC" : @"Helvetica") size:s]
#define     BOLDTEXTFONT(s)                         [UIFont fontWithName:([[UIFont familyNames] containsObject:@"PingFang SC"] ? @"PingFangSC-Semibold" : @"Helvetica-Bold") size:s]

//Image PingFang-SC-Bold
#define     CUSTOMIMG(name)                         ([UIImage imageNamed:name] ?: IMAGEASSETS(name))

#define     IMAGEASSETS(name)                       ([[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"ImageSets.bundle/%@%@", name, ([UIScreen mainScreen].scale > 2.f ? @"@3x" : @"@2x")] ofType:@"png"]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal])

//Size
//Size
#define     iPhone4s                              (kScreenWidth == 320 ? YES : NO)
#define     IPhone6p                              (kScreenHeight >= 736 ? YES : NO)
#define     Adaptation                            (IPhone6p ? 1.1 : 1.0)
#define     kBottomBarHeight                      (kDevice_Is_iPhoneX ? 83.f : 49.f)
#define     IPXNAV64                              (kDevice_Is_iPhoneX ? 88.f : 64.f)
#define     IPXSTATEBAR                           (kDevice_Is_iPhoneX ? 44.f : 20.f)

#define     kDevice_Is_iPhoneX                    ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO || [UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) : NO || [UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) : NO)

#define     kDevice_iPhoneXR                      ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) : NO)

#define     kDevice_iPhoneXSMax                   ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) : NO)

#define     kDevice_iPhoneX                       ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

#define      kDevice_IS_IPAD                       (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

#define      kDevice_IS_IPHONE                     (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

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

//Refresh Image Path
#define     kLoadingLightImages                 @[[[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Loading.bundle/mb_loading1" ofType:@"png"]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal], [[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Loading.bundle/mb_loading2" ofType:@"png"]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal], [[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Loading.bundle/mb_loading3" ofType:@"png"]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal], [[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Loading.bundle/mb_loading4" ofType:@"png"]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal], [[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Loading.bundle/mb_loading5" ofType:@"png"]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal], [[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Loading.bundle/mb_loading6" ofType:@"png"]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal], [[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Loading.bundle/mb_loading7" ofType:@"png"]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal], [[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Loading.bundle/mb_loading8" ofType:@"png"]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal], [[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Loading.bundle/mb_loading9" ofType:@"png"]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal], [[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Loading.bundle/mb_loading10" ofType:@"png"]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal], [[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Loading.bundle/mb_loading11" ofType:@"png"]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]]

//App info
#define        kAppDisplayName                       [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"]
#define        kAppVersion                           [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]//plist文件App版本号
#define        kAppIdentifier                        [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleIdentifier"]
#define     kAppBuildVersion                      [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"]

//System version
#define     SYS_VERSION                           floorf([[UIDevice currentDevice].systemVersion floatValue])
#define     IS_IOS_8                              floorf([[UIDevice currentDevice].systemVersion integerValue]) == 8 ? 1 : 0
#define     IS_IOS_9                              floorf([[UIDevice currentDevice].systemVersion integerValue]) == 9 ? 1 : 0
#define     IS_IOS_10                             floorf([[UIDevice currentDevice].systemVersion integerValue]) == 10 ? 1 : 0
#define     IS_IOS_11                             floorf([[UIDevice currentDevice].systemVersion integerValue]) == 11 ? 1 : 0

#endif /* SelectorConfig_h */
