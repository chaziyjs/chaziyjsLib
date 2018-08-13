//
//  CodeManager.m
//  AFNetworking-demo
//
//  Created by jackson.song on 16/4/5.
//  Copyright © 2016年 Jakey. All rights reserved.
//

#import "CodeManager.h"

static dispatch_once_t onceToken;
static CodeManager *_sharedCodeManager = nil;

@implementation CodeManager
+ (instancetype)sharedCodeManager {
    
    dispatch_once(&onceToken, ^{
        //设置服务器根地址
        _sharedCodeManager = [[CodeManager alloc] init];
    });
    
    return _sharedCodeManager;
}

#pragma mark - Error Code Handler
- (void)errorCode:(NSHTTPURLResponse *)httpResponse Error:(NSError *)neterror response:(void(^)(NSError *error, NSNumber *result, NSString *msg))response {
    //超时httpResponse为nil
    if (httpResponse == nil) {
//        FLog(@"request timeout");
        if (neterror.code == -1009) {
            response(neterror, @1009,@"无网络连接");  //无网络连接
        } else {
            response(neterror,@99,@"无法连接到网络");  //无法连接到网络
        }
        return;
    }
    switch (httpResponse.statusCode) {
        case 400:
             response(neterror,@400,@"错误请求");
            break;
        case 401: {//授权失败，需重新登陆，返回1
//            FLog(@"http error code == %ld URL = %@",(long)httpResponse.statusCode, httpResponse.URL);
//            [[NSNotificationCenter defaultCenter] postNotificationName:kUserLoginLost object:self userInfo:httpResponse.allHeaderFields];
            kRemoveStandardUserDefaults(@"userCookies");
            kRemoveStandardUserDefaults(@"_dawdler_key");
            kStandardUserDefaultsSync;
//            NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
//            for (NSHTTPCookie *cookie in [storage cookies])
//            {
//                if ([cookie.name isEqualToString:@"any_tk"]) {
//                    [storage deleteCookie:cookie];
//                    break;
//                }
//            }
//            kRemoveStandardUserDefaults(@"contactMobile");
//            kRemoveStandardUserDefaults(@"mobile");
//            kRemoveStandardUserDefaults(@"goldBean");
//            kRemoveStandardUserDefaults(@"nickname");
//            kRemoveStandardUserDefaults(@"userheadpath");
//            kStandardUserDefaultsSync;
            response(neterror,@1,@"登录授权失败");

        }
            break;
        case 403:
            response(neterror,@403,@"禁止执行访问");
            break;
        case 404:
            response(neterror,@404,@"无法找到服务器");
            break;
        case 405:
            response(neterror,@405,@"方法不被允许");
            break;
        case 406:
            response(neterror,@406,@"无法满足请求头中的条件");
            break;
        case 500: {
//            FLog(@"http error code == %ld URL = %@",(long)httpResponse.statusCode, httpResponse.URL);
            //服务器错误
            response(neterror,@2,@"服务器错误");
        }
            break;
        case 501:
            response(neterror,@501,@"服务器不支持实现请求所需要的功能");
            break;
        case 502:
            response(neterror,@502,@"网关超时");
            break;
        case 503:
            response(neterror,@503,@"服务不可用");
            break;
        case 505:
            response(neterror,@505,@"服务器不支持请求中所指明的HTTP版本");
            break;
        default://未处理的错误代码返回0
//            FLog(@"http error code == %ld URL = %@",(long)httpResponse.statusCode, httpResponse.URL);
            //其它
            response(neterror,@0,@"其它错误");
            break;
    }
}

@end
