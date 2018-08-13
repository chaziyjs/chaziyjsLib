//
//  APIManager.m
//  AFNetworking-demo
//
//  Created by Jakey on 16/4/1.
//  Copyright © 2016年 www.skyfox.org. All rights reserved.
//

#import "APIManager.h"


static dispatch_once_t onceToken;
static APIManager *_sharedManager = nil;

@implementation APIManager

+ (instancetype)sharedManager {
    
    dispatch_once(&onceToken, ^{
        //设置服务器根地址
        _sharedManager = [[APIManager alloc] initWithBaseURL:[NSURL URLWithString:@""]];

        [_sharedManager.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            _sharedManager.networkStatus = status;
            switch (status) {
                case AFNetworkReachabilityStatusReachableViaWWAN:
                {
                    FLog(@"蜂窝网络已连接");
                    _sharedManager->_network_error = NO;
                }
                    break;
                case AFNetworkReachabilityStatusReachableViaWiFi:
                {
                    FLog(@"WiFi网络已连接");
                    _sharedManager->_network_error = NO;
                }
                    break;
                case AFNetworkReachabilityStatusNotReachable:
//                    FLog(@"网络连接失败");
                    _sharedManager->_network_error = YES;
                    break;
                default:
                    break;
            }
        }];
        [_sharedManager.reachabilityManager startMonitoring];
        [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
//        _sharedManager.policy = [APIManager customSecurityPolicy];
        //TODO:需要设置 很重要
        //http://blog.csdn.net/xn4545945/article/details/37945711 详细介绍与其他具体参数
        //http://samwize.com/2012/10/25/simple-get-post-afnetworking/
        //工程中server.php 对应php版本的服务器端
        //发送json数据
        //zsy edit
        _sharedManager.requestSerializer = [AFHTTPRequestSerializer serializer];
//        _sharedManager.requestSerializer = [AFJSONRequestSerializer serializer];
        //响应json数据
        _sharedManager.responseSerializer  = [AFJSONResponseSerializer serializer];
        
        //发送二进制form数据
        //_sharedClient.requestSerializer = [AFHTTPRequestSerializer serializer];
        //响应二进制form数据
        //_sharedClient.responseSerializer  = [AFHTTPResponseSerializer serializer];
        //设置响应内容格式  经常因为服务器返回的格式不是标准json而出错 服务器可能返回text/html text/plain 作为json
        
        _sharedManager.responseSerializer.acceptableContentTypes =  [_sharedManager.responseSerializer.acceptableContentTypes setByAddingObjectsFromSet:[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", @"text/plain",@"application/atom+xml",@"application/xml",@"text/xml",nil]];
        
        _sharedManager.requestSerializer.timeoutInterval = 6;//超时
    });
    
    return _sharedManager;
}

+ (NSURLSessionDataTask *)SafePOST:(NSString *)URLString
                        parameters:(id)parameters
                         needCache:(BOOL)isCache
                           success:(void (^)(NSURLSessionDataTask * task, id responseObject, BOOL cacheResult))success
                           failure:(void (^)(NSURLSessionDataTask * task, NSError *error, NSNumber *result, id cacheData, NSString *msg))failure
{
    APIManager *manager = [APIManager sharedManager];
//    if ([URLString containsString:kURLHOST]) {
//        if (manager.policy) {
//            [manager setSecurityPolicy:manager.policy];
//        } else {
//            manager.policy = [APIManager customSecurityPolicy];
//            [manager setSecurityPolicy:manager.policy];
//        }
//    }
    _sharedManager.requestSerializer.timeoutInterval = 10.f;//超时

    NSURLSessionDataTask *session_task = [manager POST:URLString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        //
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        BOOL cache_result = NO;
        if (isCache && responseObject) {
            NSError *error = [NSError errorWithDomain:@"POSTJSONWRITE" code:400 userInfo:responseObject];
            NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:&error];
            cache_result = [[CacheData shareCacheData] cacheWithURLResponse:task.response ResponseData:data SessionDataTask:task];
        }
        //todo 统一处理响应数据
        [manager synsSaveCookies:(NSHTTPURLResponse *)task.response];
        success(task,responseObject, cache_result);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //todo 统一处理错误
        id cache_data = nil;
        __block typeof(id) weak_data = cache_data;
        if (isCache) {
            [[CacheData shareCacheData] readCacheWithTask:task completion:^(NSData *data) {
                CodeManager *codeManager = [CodeManager sharedCodeManager];//add
                if (data) {
                    NSError *json_error = [NSError errorWithDomain:@"POSTJSONREAD" code:400 userInfo:nil];
                    weak_data = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&json_error];
                    [codeManager errorCode:(NSHTTPURLResponse *)task.response Error:error response:^(NSError *error, NSNumber *result, NSString *msg) {
                        failure(task,error,result, weak_data, msg);
                    }];
                } else {
                    [codeManager errorCode:(NSHTTPURLResponse *)task.response Error:error response:^(NSError *error, NSNumber *result, NSString *msg) {
                        failure(task,error,result, weak_data, msg);
                    }];
                }
            }];
        } else {
            CodeManager *codeManager = [CodeManager sharedCodeManager];//add
            [codeManager errorCode:(NSHTTPURLResponse *)task.response Error:error response:^(NSError *error, NSNumber *result, NSString *msg) {
                failure(task,error,result, weak_data, msg);
            }];
        }
    }];
    return session_task;
}

+ (NSURLSessionDataTask *)SafeGET:(NSString *)URLString
                       parameters:(id)parameters
                        needCache:(BOOL)isCache
                          success:(void (^)(NSURLSessionDataTask * task, id responseObject, BOOL cacheResult))success
                          failure:(void (^)(NSURLSessionDataTask * task, NSError *error, NSNumber *result, id cacheData, NSString *msg))failure
{
    APIManager *manager = [APIManager sharedManager];
//    if ([URLString containsString:kURLHOST]) {
//        if (manager.policy) {
//            [manager setSecurityPolicy:manager.policy];
//        } else {
//            manager.policy = [APIManager customSecurityPolicy];
//            [manager setSecurityPolicy:manager.policy];
//        }
//    }
    _sharedManager.requestSerializer.timeoutInterval = 30.f;//超时
    NSURLSessionDataTask *request_task = [manager GET:URLString parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        //
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //todo
        BOOL cache_result = NO;
        if (isCache) {
            NSError *error = [NSError errorWithDomain:@"GETJSONWRITE" code:400 userInfo:responseObject];
            NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:&error];
            cache_result = [[CacheData shareCacheData] cacheWithURLResponse:task.response ResponseData:data SessionDataTask:task];
        }
        [manager synsSaveCookies:(NSHTTPURLResponse *)task.response];
        success(task,responseObject, cache_result);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //todo
        id cache_data = nil;
        __block typeof(id) weak_data = cache_data;
        if (isCache) {
            [[CacheData shareCacheData] readCacheWithTask:task completion:^(NSData *data) {
                CodeManager *codeManager = [CodeManager sharedCodeManager];//add
                if (data) {
                    NSError *json_error = [NSError errorWithDomain:@"GETJSONREAD" code:400 userInfo:nil];
                    weak_data = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&json_error];
                    [codeManager errorCode:(NSHTTPURLResponse *)task.response Error:error response:^(NSError *error, NSNumber *result, NSString *msg) {
                        failure(task,error,result, weak_data, msg);
                    }];
                } else {
                    [codeManager errorCode:(NSHTTPURLResponse *)task.response Error:error response:^(NSError *error, NSNumber *result, NSString *msg) {
                        failure(task,error,result, weak_data, msg);
                    }];
                }
            }];
        } else {
            __weak typeof(id) weak_data = cache_data;
            CodeManager *codeManager = [CodeManager sharedCodeManager];
            [codeManager errorCode:(NSHTTPURLResponse *)task.response Error:error response:^(NSError *error, NSNumber *result,NSString *msg) {
                failure(task,error,result, weak_data,msg);
            }];
        }
    }];
    return request_task;
}


//设置ip要重置单例 生效
+ (void)reset {
    _sharedManager = nil;
    onceToken = 0;
}

+ (AFSecurityPolicy*)customSecurityPolicy
{
    // HTTPS请求时,先导入证书
    NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"huiyou" ofType:@"cer"];;//证书的路径
    NSData *certData = [NSData dataWithContentsOfFile:cerPath];

    // AFSSLPinningModeCertificate 使用证书验证模式
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    
    // allowInvalidCertificates 是否允许无效证书（也就是自建的证书），默认为NO
    // 如果是需要验证自建证书，需要设置为YES
    securityPolicy.allowInvalidCertificates = YES;
    
    //validatesDomainName 是否需要验证域名，默认为YES；
    //假如证书的域名与你请求的域名不一致，需把该项设置为NO；如设成NO的话，即服务器使用其他可信任机构颁发的证书，也可以建立连接，这个非常危险，建议打开。
    //置为NO，主要用于这种情况：客户端请求的是子域名，而证书上的是另外一个域名。因为SSL证书上的域名是独立的，假如证书上注册的域名是www.google.com，那么mail.google.com是无法验证通过的；当然，有钱可以注册通配符的域名*.google.com，但这个还是比较贵的。
    //如置为NO，建议自己添加对应域名的校验逻辑。
    securityPolicy.validatesDomainName = NO;
    securityPolicy.pinnedCertificates = [NSSet setWithObjects:certData, nil];
    return securityPolicy;
}

//#pragma mark - 对参数加密处理
//- (NSDictionary *)secureParameters:(NSDictionary *)param RequestURL:(NSString *)url
// {
//     NSMutableDictionary *secure_dic = [NSMutableDictionary dictionaryWithDictionary:param];
//     NSString *paramStr = [NSString string];
//     //注释
//     //将数组按照ASCII表字母顺序排序,拼接密钥并生成MD5值作为sign字段的value
//     if (secure_dic.allKeys.count > 0) {
//         NSMutableArray *readySort_array = [NSMutableArray arrayWithArray:secure_dic.allKeys];
//         if ([readySort_array containsObject:@"content"]) {
//             [readySort_array removeObject:@"content"];
//         }
//         NSInteger random = 1 + arc4random() % (readySort_array.count);
//         NSArray *sortKeys = [readySort_array sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
//             return [obj1 compare:obj2 options:NSLiteralSearch];
//         }];
//         NSMutableArray *param_all_key_name = [NSMutableArray array];
//         for (int i = 0; i < random; i ++) {
//             NSString *keyName = [sortKeys objectAtIndex:i];
//             if ([keyName isEqualToString:@"content"]) {
//                 continue;
//             } else {
//                 [param_all_key_name addObject:keyName];
//                 paramStr = [NSString stringWithFormat:@"%@%@=%@&", paramStr ,keyName, [secure_dic objectForKey:keyName]];
//             }
//         }
//         paramStr = [paramStr substringToIndex:paramStr.length - 1];
//         NSString *KEY = kStringWithFormat(@"%ld", (NSInteger)(paramStr.length * 0.5));
//         NSString *keyStr = [NSString stringWithFormat:@"%@%@", paramStr, KEY];
//         NSString *MD5Str = [NSString md5:keyStr];
//         MD5Str = [MD5Str uppercaseString];
//         [secure_dic setObject:MD5Str forKey:@"sign"];
//
//         NSMutableString *new_url = [NSMutableString string];
//         for (int i = 0; i < param_all_key_name.count; i ++) {
//             NSString *url_param = [param_all_key_name objectAtIndex:i];
//             if (i == 0) {
//                 new_url = [NSMutableString stringWithFormat:@"%@?%@=%@", new_url, url_param, [secure_dic objectForKey:url_param]];
//             } else {
//                 new_url = [NSMutableString stringWithFormat:@"%@&%@=%@", new_url, url_param, [secure_dic objectForKey:url_param]];
//             }
//         }
//         NSString *paramUrl = [NSString encodeStringWithString:new_url];
//         NSDictionary *secureDic = @{
//                                     @"url" : [url stringByAppendingString:paramUrl],
//                                     @"secure" : secure_dic
//                                     };
//         return secureDic;
//     }
//     return nil;
//}
//
//#pragma mark - 参数排序
//- (NSMutableArray *)popSortWithArray:(NSArray *)array
//{
//    NSMutableArray *sortArray = [NSMutableArray arrayWithArray:array];
//    for (int i = 0; i < sortArray.count; i ++) {
//        for (int j = 0; j < sortArray.count - 1 - i; j ++) {
//            NSString *left = [[NSString stringWithFormat:@"%@", sortArray[j]] uppercaseString];
//            NSString *right = [[NSString stringWithFormat:@"%@", sortArray[j + 1]] uppercaseString];
//            if ([left compare:right options:NSNumericSearch] == NSOrderedDescending) {
//                [sortArray exchangeObjectAtIndex:j withObjectAtIndex:j + 1];
//            }
//        }
//    }
//    return sortArray;
//}

#pragma mark - 同步存储最新登录value
- (NSDictionary *)synsSaveCookies:(NSHTTPURLResponse *)response
{
    NSString *cookis = response.allHeaderFields[@"Set-Cookie"];
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    FLog(@"current cookies = %@, response url = %@", cookis, response.URL);
    FLog(@"response cookie = %@", cookis);
    NSArray *cookies = [cookis componentsSeparatedByString:@","];
    NSString *cookie = @"";
    for (NSString *each_cookie in cookies) {
        if ([each_cookie containsString:@"any_tk"]) {
            if ([each_cookie containsString:@"any_tk"]) {
                cookie = each_cookie;
            } else {
                cookie = [cookie stringByAppendingString:[NSString stringWithFormat:@", %@", each_cookie]];
            }
        } else {
            continue;
        }
    }
    for (NSHTTPCookie *current_cookie in storage.cookies) {
        if ([current_cookie.name isEqualToString:@"_dawdler_key"]) {
            if (kStandardUserDefaultsObject(@"_dawdler_key")) {
                NSDictionary *cookie_dic = kStandardUserDefaultsObject(@"_dawdler_key");
                if (![[cookie_dic valueForKey:NSHTTPCookieValue] isEqualToString:current_cookie.value]) {
                    kSaveStandardUserDefaults(current_cookie.properties, @"_dawdler_key");
                    kStandardUserDefaultsSync;
                } else {
                    break;
                }
            } else {
                kSaveStandardUserDefaults(current_cookie.properties, @"_dawdler_key");
                kStandardUserDefaultsSync;
            }
        } else {
            continue;
        }
    }
    
    if (![cookie isEqualToString:@""]) {
        NSString *single = @"";
        NSString *domain = @"";
        for (NSString *sub_cookie in [cookie componentsSeparatedByString:@";"]) {
            if ([sub_cookie containsString:@"any_tk"]) {
                NSArray *subArray = [sub_cookie componentsSeparatedByString:@"="];
                single = [NSString stringWithFormat:@"%@", [subArray lastObject]];
            }
            if ([sub_cookie containsString:@"Domain"]) {
                NSArray *subArray = [sub_cookie componentsSeparatedByString:@"="];
                domain = [NSString stringWithFormat:@"%@", [subArray lastObject]];
            }
        }
        NSDate *expriseData = [NSDate dateWithTimeInterval:24*60*60*30 sinceDate:[NSDate date]];
        NSMutableDictionary *cookieProperties = [NSMutableDictionary dictionary];
        if ([cookie containsString:@"any_tk"]) {
            if (![single isEqualToString:@"\"\""] && ![single isEqualToString:@""]) {
                [cookieProperties setObject:@"any_tk" forKey:NSHTTPCookieName];
                [cookieProperties setObject:single forKey:NSHTTPCookieValue];
                [cookieProperties setObject:domain forKey:NSHTTPCookieDomain];
                [cookieProperties setObject:expriseData forKey:NSHTTPCookieExpires];
                [cookieProperties setObject:@"/" forKey:NSHTTPCookiePath];
                [cookieProperties setObject:@"0" forKey:NSHTTPCookieVersion];
                [cookieProperties removeObjectForKey:NSHTTPCookieDiscard];
                NSHTTPCookie *newcookie = [NSHTTPCookie cookieWithProperties:cookieProperties];
                [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:newcookie];
                _login_cookie = cookieProperties;
                kSaveStandardUserDefaults(cookieProperties, @"userCookies");
                kStandardUserDefaultsSync;
                return cookieProperties;
            } else {
                _login_cookie = nil;
                return nil;
            }
        } else {
            return nil;
        }
    } else {

        return nil;
    }
}


@end
