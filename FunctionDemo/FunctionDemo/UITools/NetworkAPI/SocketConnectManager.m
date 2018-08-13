//
//  SocketConnectManager.m
//  SocketDemo
//
//  Created by chaziyjs on 17/4/25.
//  Copyright © 2017年 chaziyjs. All rights reserved.
//

#import "SocketConnectManager.h"
#import <math.h>

#define HOST                @"101.200.51.105" //IP地址
#define PORT                8600 //端口号
#define KEY                 @"3e3e7h6gof4dltja2b0qg5vlb07gb1qy" //密钥
#define RequestCount        6 //超时时间6s

SocketConnectManager *_sharedManager = nil;

@implementation SocketConnectManager

static NSString const *associatKey = @"SOCKETASSOCIATEKEY";

+ (instancetype)sharedManager
{
        //设置服务器根地址
    _sharedManager = [SocketConnectManager new];
    return _sharedManager;
}

//设置ip要重置单例 生效
+ (void)reset {
    _sharedManager = nil;
}

+ (void)sendSocketMessageWithParam:(NSDictionary *)param
                           success:(void (^)(NSDictionary *response))response
                           failure:(void (^)(NSNumber *errorCode, NSString *errorMsg))result
{
    SocketConnectManager *manager = [SocketConnectManager sharedManager];
    manager.successResponse = response;
    manager.failureResponse = result;
    if (param.allKeys.count > 0) {
        manager.param = [NSMutableDictionary dictionaryWithDictionary:param];
    }
    AFNetworkReachabilityManager *netManager = [AFNetworkReachabilityManager sharedManager];
    [netManager startMonitoring];  //开始监听
    __weak typeof(netManager) weak_netManager = netManager;
    __weak typeof(manager) weak_manager = manager;
    [netManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status){
        __strong typeof(weak_manager) strong_manager = weak_manager;
        if (status == AFNetworkReachabilityStatusNotReachable)
        {
            if (strong_manager.failureResponse) {
                strong_manager.failureResponse(@(1009), @"当前无网络连接");
            }
            FLog(@"无法获取系统变量表列表 原因:AFNetworkReachabilityStatusNotReachable");
            return;
        }else if (status == AFNetworkReachabilityStatusUnknown){
            if (strong_manager.failureResponse) {
                strong_manager.failureResponse(@(1009), @"当前无网络");
            }
            FLog(@"无法获取系统变量表列表 原因:AFNetworkReachabilityStatusUnknown");
            return;
        }else if ((status == AFNetworkReachabilityStatusReachableViaWWAN) || (status == AFNetworkReachabilityStatusReachableViaWiFi)){
            NSError *error = [NSError errorWithDomain:@"SOCKETERROR" code:400 userInfo:nil];
            manager.asyncsocket = [[GCDAsyncSocket alloc] initWithDelegate:manager delegateQueue:dispatch_get_main_queue() socketQueue:dispatch_queue_create([@"SocketConnectManager" UTF8String], DISPATCH_QUEUE_CONCURRENT)];
            [strong_manager.asyncsocket connectToHost:HOST onPort:PORT withTimeout:RequestCount error:&error];
            [weak_netManager stopMonitoring];
        }
    }];
}

- (void)socket:(GCDAsyncSocket *)sender didConnectToHost:(NSString *)host port:(UInt16)port
{
    FLog(@"Cool, I'm connected! That was easy.");
    if (_sharedManager.param != nil) {
        NSString *paramStr = @"";
//注释
/*将数组按照ASCII表字母顺序排序,拼接密钥并生成MD5值作为sign字段的value*/
        NSMutableDictionary *dataParam = [NSMutableDictionary dictionaryWithDictionary:_sharedManager.param];
        if (dataParam.allKeys.count > 0) {
            NSArray *sortKeys = [_sharedManager popSortWithArray:dataParam.allKeys];
            for (NSString *keyName in sortKeys) {
                paramStr = [NSString stringWithFormat:@"%@%@=%@&", paramStr ,keyName, [dataParam objectForKey:keyName]];
                if ([kStringWithFormat(@"%@", [dataParam objectForKey:keyName]) includeChinese]) {
                    [_sharedManager socketParamWithChinese:sender Param:dataParam ParamArray:sortKeys]; //当参数中含有中文时,重新生成签名
                    return;
                }
            }
            NSString *keyStr = [NSString stringWithFormat:@"%@key=%@", paramStr, KEY];
            NSString *handleKeyStr = [_sharedManager manageString:keyStr];
            NSString *MD5Str = [_sharedManager md5:handleKeyStr];
            MD5Str = [MD5Str uppercaseString];
            [dataParam setObject:MD5Str forKey:@"sign"];
            NSData *paramData = [NSJSONSerialization dataWithJSONObject:dataParam options:NSJSONWritingPrettyPrinted error:nil];
            NSString *paramJsonStr = [[NSString alloc] initWithData:paramData encoding:NSUTF8StringEncoding];
            NSString *paramJsonHandleStr = [_sharedManager manageString:paramJsonStr];
            NSString *paramDataLength = [NSString stringWithFormat:@"%.5lu", (unsigned long)paramJsonHandleStr.length];
            //注释
            /*将重新组合好的字典转换成json字符串,再前面拼接该字典的长度,五位长度的字符串,整体转化成NSData,并write;
             关联了associatKey,以字典参数的长度作为write的tag,根据tag区分是否是当前请求.*/
            NSData *lengthData = [paramDataLength dataUsingEncoding:NSUTF8StringEncoding];
            NSMutableData *sendParamData = [NSMutableData dataWithData:lengthData];
            [sendParamData appendData:[paramJsonHandleStr dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES]];
            objc_setAssociatedObject(sender, &associatKey, sendParamData, OBJC_ASSOCIATION_COPY_NONATOMIC);
            [_sharedManager.asyncsocket writeData:sendParamData withTimeout:RequestCount tag:sendParamData.length];
        }
    }
}

#pragma mark - 带有中文参数
- (void)socketParamWithChinese:(GCDAsyncSocket *)sock
                         Param:(NSMutableDictionary *)params
                      ParamArray:(NSArray *)chineseArray
{
    NSString *paramStr = @"";
    NSMutableDictionary *newParam = [NSMutableDictionary dictionary];
    for (NSString *keysName in chineseArray) {
        paramStr = [NSString stringWithFormat:@"%@%@=%@&", paramStr ,keysName, [params objectForKey:keysName]];
        if ([kStringWithFormat(@"%@", [params objectForKey:keysName]) includeChinese]) {
            NSString *chineseChar = kStringWithFormat(@"%@", [params objectForKey:keysName]);
            NSString *utfChar = [chineseChar stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            [newParam setObject:utfChar forKey:keysName];
        } else {
            [newParam setObject:[params objectForKey:keysName] forKey:keysName];
        }
    } 
    NSString *keyStr = [NSString stringWithFormat:@"%@key=%@", paramStr, KEY];
    NSString *handleKeyStr = [_sharedManager manageString:keyStr];
    NSString *MD5Str = [_sharedManager md5:handleKeyStr];
    MD5Str = [MD5Str uppercaseString];
    [newParam setObject:MD5Str forKey:@"sign"];
    NSData *paramData = [NSJSONSerialization dataWithJSONObject:newParam options:NSJSONWritingPrettyPrinted error:nil];
    NSString *paramJsonStr = [[NSString alloc] initWithData:paramData encoding:NSUTF8StringEncoding];
    NSString *paramJsonHandleStr = [_sharedManager manageString:paramJsonStr];
    NSString *paramDataLength = [NSString stringWithFormat:@"%.5lu", (unsigned long)paramJsonHandleStr.length];
    //注释
    /*将重新组合好的字典转换成json字符串,再前面拼接该字典的长度,五位长度的字符串,整体转化成NSData,并write;
     关联了associatKey,以字典参数的长度作为write的tag,根据tag区分是否是当前请求.*/
    NSData *lengthData = [paramDataLength dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableData *sendParamData = [NSMutableData dataWithData:lengthData];
    [sendParamData appendData:[paramJsonHandleStr dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES]];
    objc_setAssociatedObject(sock, &associatKey, sendParamData, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [_sharedManager.asyncsocket writeData:sendParamData withTimeout:RequestCount tag:sendParamData.length];
}

#pragma mark - socket连接失败
- (void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(nullable NSError *)err
{
    FLog(@"socket Disconnect error = %@", err);
    if (err == nil) {
        if (_sharedManager != nil) {
            if (_sharedManager.failureResponse != nil) {
                _sharedManager.failureResponse(@(9999), @"暂无问题原因");
            }
        }
    } else {
        if (_sharedManager != nil) {
            if (_sharedManager.failureResponse != nil) {
                _sharedManager.failureResponse(@(err.code), [err.userInfo objectForKey:NSLocalizedDescriptionKey]);
            }
        }
    }
}

#pragma mark - socket写操作
- (void)socket:(GCDAsyncSocket *)sock didWriteDataWithTag:(long)tag
{
    [_sharedManager.asyncsocket readDataWithTimeout:RequestCount tag:tag];
}

#pragma mark - socket读操作
- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
    FLog(@"已读取到数据");
    NSMutableData *paramData = (NSMutableData *)objc_getAssociatedObject(sock, &associatKey);
    if (tag == paramData.length) {
        if (_sharedManager.mutableData.length != 0) {
            [_sharedManager.mutableData appendData:data];
            NSString *mutableResultStr = [[NSString alloc] initWithData:_sharedManager.mutableData encoding:CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000)];
            NSString *mutableLengthString = [mutableResultStr substringToIndex:5];
            if (5 == abs((int)[mutableLengthString integerValue] - (int)_sharedManager.mutableData.length)) {
                [_sharedManager checkSocketData:_sharedManager.mutableData Tag:tag Socket:sock];
                FLog(@"数据未完整,需要继续请求");
                _sharedManager.mutableData = nil;
                _sharedManager.mutableData = [NSMutableData dataWithLength:0];
            } else {
                [_sharedManager.asyncsocket readDataWithTimeout:RequestCount tag:tag];
            }
        } else {
            [_sharedManager checkSocketData:data Tag:tag Socket:sock];
        }
    } else {
        _sharedManager.failureResponse(@(400), @"json未获取到");
        [SocketConnectManager reset];
        [_sharedManager.asyncsocket disconnect];
    }
}

#pragma mark - 参数排序
- (NSMutableArray *)popSortWithArray:(NSArray *)array
{
    NSMutableArray *sortArray = [NSMutableArray arrayWithArray:array];
    for (int i = 0; i < sortArray.count; i ++) {
        for (int j = 0; j < sortArray.count - 1 - i; j ++) {
            NSString *left = [[NSString stringWithFormat:@"%@", sortArray[j]] uppercaseString];
            NSString *right = [[NSString stringWithFormat:@"%@", sortArray[j + 1]] uppercaseString];
            if ([left compare:right options:NSNumericSearch] == NSOrderedDescending) {
                [sortArray exchangeObjectAtIndex:j withObjectAtIndex:j + 1];
            }
        }
    }
    return sortArray;
}

#pragma mark - 数据长度校验
- (void)checkSocketData:(NSData *)data
                    Tag:(long)tag
                 Socket:(GCDAsyncSocket *)sock
{
    NSString *resultStr = [[NSString alloc] initWithData:data encoding:CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000)];
    NSString *lengthString = [resultStr substringToIndex:5];
    if (5 == abs((int)[lengthString integerValue] - (int)data.length)) {
        NSString *jsonStr = [resultStr substringFromIndex:5];
        if (jsonStr == nil) {
            _sharedManager.failureResponse(@(404), @"数据无法解析");
            [SocketConnectManager reset];
        } else {
            NSData *jsonData = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
            NSError *err = [NSError errorWithDomain:@"SocketJsonToStringError" code:400 userInfo:@{@"errorMsg" : jsonStr}];
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:&err];
            if (dic == nil) {
                _sharedManager.failureResponse(@(404), @"数据无法解析");
                [SocketConnectManager reset];
            } else {
                if (_sharedManager.successResponse) {
                    _sharedManager.successResponse(dic);
                    dic = nil;
                }
                [SocketConnectManager reset];
            }
        }
        [_sharedManager.asyncsocket disconnect];
        
    } else {
        if (_sharedManager.mutableData) {
            NSMutableData *result_datas = [NSMutableData dataWithData:_sharedManager.mutableData];
            [result_datas appendData:data];
            _sharedManager.mutableData = [result_datas mutableCopy];
//            [_sharedManager.mutableData appendData:data];
        } else {
            _sharedManager.mutableData = [NSMutableData data];
            [_sharedManager.mutableData appendData:data];
        }
        [_sharedManager.asyncsocket readDataWithTimeout:RequestCount tag:tag];
    }
}

#pragma mark - 请求超时会走该方法
- (NSTimeInterval)socket:(GCDAsyncSocket *)sock
shouldTimeoutReadWithTag:(long)tag
                 elapsed:(NSTimeInterval)elapsed
               bytesDone:(NSUInteger)length
{
    FLog(@"读 超时");
    NSMutableData *paramData = (NSMutableData *)objc_getAssociatedObject(sock, &associatKey);
    _requestTimes ++;
    if (tag == paramData.length && _requestTimes < 3) {
        [_sharedManager.asyncsocket readDataWithTimeout:RequestCount tag:tag];
    } else {
        if (tag != paramData.length) {
            _sharedManager.failureResponse(@(400), @"json未获取到");
            [_sharedManager.asyncsocket disconnect];
        } else {
            _requestTimes = 0;
            _sharedManager.failureResponse(@(99), @"网络请求超时");
            [_sharedManager.asyncsocket disconnect];
        }
    }
    return RequestCount;
}

#pragma mark - socket连接超时
- (NSTimeInterval)socket:(GCDAsyncSocket *)sock shouldTimeoutWriteWithTag:(long)tag
                 elapsed:(NSTimeInterval)elapsed
               bytesDone:(NSUInteger)length
{
    FLog(@"写 超时");
    NSMutableData *paramData = (NSMutableData *)objc_getAssociatedObject(sock, &associatKey);
    _requestTimes ++;
    if (tag == paramData.length && _requestTimes < 3) {
        [_sharedManager.asyncsocket writeData:paramData withTimeout:RequestCount tag:tag];
    } else {
        if (tag != paramData.length) {
            _sharedManager.failureResponse(@(400), @"json未获取到");
            [_sharedManager.asyncsocket disconnect];
        } else {
            _requestTimes = 0;
            _sharedManager.failureResponse(@(99), @"网络请求超时");
            [_sharedManager.asyncsocket disconnect];
        }
    }
    return RequestCount;
}

#pragma mark - MD5加密
- (NSString *)md5:(NSString *)str {
    const char *cStr = [str UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, strlen(cStr),digest);
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [result appendFormat:@"%02x", digest[i]];
    return result;
}

#pragma mark - 字符串处理
- (NSString *)manageString:(NSString *)origStr
{
    NSString *newStr = [NSString stringWithFormat:@"%@",origStr];
    newStr = [newStr stringByReplacingOccurrencesOfString:@" " withString:@""];
    newStr = [newStr stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    newStr = [newStr stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    newStr = [newStr stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    return newStr;
}

- (void)dealloc
{
    FLog(@"socket connect manager dealloc");
}

@end
