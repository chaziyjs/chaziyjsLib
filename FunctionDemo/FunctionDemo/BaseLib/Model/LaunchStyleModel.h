//
//  LaunchStyleModel.h
//  communityDemo
//
//  Created by chaziyjs on 2017/9/20.
//  Copyright © 2017年 chaziyjs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"
#import "EventHandlerModel.h"

typedef NS_ENUM(NSUInteger, LaunchStyle)
{
    LaunchScrollStyle   =   1,
    LaunchAdImageStyle  =   2,
    LaunchNumStyle      =   3,
    LaunchErrorStyle    =   4
};

typedef NS_ENUM(NSUInteger, LaunchScreenSize)
{
    LaunchScreeniPhone4         =   100,
    LaunchScreeniPhone5         =   101,
    LaunchScreeniPhone6         =   102,
    LaunchScreeniPhone6P        =   103,
    LaunchScreeniPhoneX         =   104,
    LaunchScreenNON             =   105
};

@interface LaunchStyleModel : NSObject

+ (void)checkLaunchCurrentStyle:(void (^)(LaunchStyle style))style;
+ (void)loadSystemConfig:(void (^)(LaunchStyle result))resultStyle;
+ (LaunchScreenSize)currenDeviceSize;

@end
