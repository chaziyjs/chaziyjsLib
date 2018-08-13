//
//  LaunchStyleModel.m
//  communityDemo
//
//  Created by chaziyjs on 2017/9/20.
//  Copyright © 2017年 chaziyjs. All rights reserved.
//

#import "LaunchStyleModel.h"
#import <objc/runtime.h>

@implementation LaunchStyleModel

+ (void)checkLaunchCurrentStyle:(void (^)(LaunchStyle style))style {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    NSFileManager *manager = [NSFileManager defaultManager];
    NSString *filePath = [path stringByAppendingPathComponent:@"Anywide.sqlite"];
    BOOL exist = [manager fileExistsAtPath:filePath];
    FMDatabase *db = [FMDatabase databaseWithPath:filePath];
    
    if (exist) {
        [LaunchStyleModel loadSystemConfig:^(LaunchStyle result) {
            style(result);
        }];
    } else {
        if ([db open]) {
            if ([db beginTransaction]) {
                BOOL result = [db executeUpdate:@"CREATE TABLE IF NOT EXISTS GoodsCartManagerDB (\
                               goodsId integer PRIMARY KEY NOT NULL,\
                               goodsName text(128),\
                               goodsDescribe text,\
                               goodsImagePath text(128),\
                               goodsCount integer(128),\
                               goodsPrice double(128),\
                               goodsbenifitPrice double(128),\
                               goodsBenifitType integer(64)\
                               );"];
                if (result) {
                    FLog(@"创建表成功");
                    [db commit];
                } else {
                    [db rollback];
                }

            }
            [db close];
            [LaunchStyleModel loadSystemConfig:^(LaunchStyle result) {
                style(LaunchScrollStyle);
            }];
        } else {
            [LaunchStyleModel loadSystemConfig:^(LaunchStyle result) {
                style(result);
            }];
        }
    }
}

#pragma mark - 拉去系统变量表
+ (void)loadSystemConfig:(void (^)(LaunchStyle result))resultStyle {
    
}

+ (void)loadConfigList:(NSNumber *)requestCount Completed:(void (^)(LaunchStyle result))completed {
    @autoreleasepool {
        
    }
}

+ (LaunchScreenSize)currenDeviceSize {
    if (kScreenWidth == 320.f && kScreenHeight == 480.f) {
        return LaunchScreeniPhone4;
    } else if (kScreenWidth == 320.f && kScreenHeight == 568.f) {
        return LaunchScreeniPhone5;
    } else if (kScreenWidth == 375.f && kScreenHeight == 667.f) {
        return LaunchScreeniPhone6;
    } else if (kScreenWidth == 414.f && kScreenHeight == 736.f) {
        return LaunchScreeniPhone6P;
    } else if (kDevice_Is_iPhoneX) {
        return LaunchScreeniPhoneX;
    } else {
        return LaunchScreenNON;
    }
}


@end

