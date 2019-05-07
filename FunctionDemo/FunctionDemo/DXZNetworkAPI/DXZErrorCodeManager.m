//
//  DXZErrorCodeManager.m
//  DXZNetwork
//
//  Created by FoxDog on 2019/5/7.
//  Copyright © 2019 FoxDog. All rights reserved.
//

#import "DXZErrorCodeManager.h"

static NSString * errorCodeChangeToErrorMessage(NSString *code) {
    if ([code isEqualToString:@"E00000"]) {
        return @"服务器内部错误";
    } else if ([code isEqualToString:@"E10000"]) {
        return @"用户未登录";
    } else if ([code isEqualToString:@"E10001"]) {
        return @"用户无权限";
    } else if ([code isEqualToString:@"E10002"]) {
        return @"用户登录失败";
    } else if ([code isEqualToString:@"E10003"]) {
        return @"用户未找到";
    } else if ([code isEqualToString:@"E10004"]) {
        return @"需要验证码";
    } else if ([code isEqualToString:@"E10005"]) {
        return @"账号在其他设备登录";
    } else if ([code isEqualToString:@"E10010"]) {
        return @"验证码错误";
    } else if ([code isEqualToString:@"E10020"]) {
        return @"当前手机号已经注册过，请更换手机号再试";
    } else if ([code isEqualToString:@"E10040"]) {
        return @"您已签到，明天再来吧~";
    } else if ([code isEqualToString:@"E10050"]) {
        return @"您的账号已被禁用，请联系管理员";
    } else if ([code isEqualToString:@"E10099"]) {
        return @"学长币不足";
    } else {
        return @"发生未知错误";
    }
}

@implementation DXZErrorCodeManager

+ (DXZErrorCodeManager *)sharedManager {
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (NSError *)handleErrorWithType:(DXZErrorType)errorType
                       ErrorCode:(NSString *)code
                           Error:(NSError * _Nullable)error
{
    switch (errorType) {
        case DXZErrorWithRequestCodeError: {
            [self noticeMessageWithErrorCode:code];
            NSString *subCode = [code substringFromIndex:1];
            return [NSError errorWithDomain:@"RequestCodeError" code:[subCode integerValue] userInfo:@{NSLocalizedDescriptionKey : errorCodeChangeToErrorMessage(code), NSLocalizedFailureReasonErrorKey : code}];
        } break;
        case DXZErrorWithAFNetworkError: {
            return error;
        } break;
    }
}

- (void)noticeMessageWithErrorCode:(NSString *)errorCode
{
    // 根据错误码,处理提示
}

@end
