//
//  DXZRequest.m
//  DXZNetwork
//
//  Created by FoxDog on 2019/4/29.
//  Copyright © 2019 FoxDog. All rights reserved.
//

#import "DXZRequest.h"

@interface DXZRequest ()

@property (nonatomic, strong) id param;
@property (nonatomic, assign) DXZRequestMethod requestMethod;

@end

@implementation DXZRequest

+ (instancetype)requestWithURL:(NSString *)url
                         param:(id)param
                 requestMethod:(DXZRequestMethod)method
     ComletionBlockWithSuccess:(DXZRequestCompletionBlock)success
                       failure:(DXZRequestCompletionBlock)failure
{
    DXZRequest *request = [DXZRequest new];
    request.URL = url;
    request.param = param;
    request.requestMethod = method;
    [request startWithCompletionBlockWithSuccess:success failure:failure];
    return request;
}

- (void)startWithUpdateParam:(id)param
{
    self.param = param;
    [self start];
}

- (void)setURL:(NSString *)URL
{
    // 获取encode后的结果
//    NSString * charaters = @"?!@#$^&%*+,:;='\"`<>()[]{}/\\| ";
//    NSCharacterSet * set = [[NSCharacterSet characterSetWithCharactersInString:charaters] invertedSet];
//    _URL = [URL stringByAddingPercentEncodingWithAllowedCharacters:set];
    _URL = [URL copy];
}

- (DXZRequestMethod)requestMethod
{
    return _requestMethod;
}

- (nullable NSDictionary<NSString *, NSString *> *)requestHeaderFieldValueDictionary
{
    return @{
             @"X-Api-Ver":@"1.0",
             @"X-Device-Id":@"136548A6-4B0C-4763-981D-DD9AC68DAF17",
             @"X-Client-Ver":[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"],
             @"X-Client-Platform":@"ios",
             @"Content-Type":@"application/json",
             @"X-Access-Token":@"c426dffcf6e0ebe6b90f3ecad8b57be4"
             };
}

- (NSString *)baseUrl
{
    return @"http://www.dxzjjl.cn/";;
}

- (NSString *)requestUrl
{
    return _URL;
}

- (nullable id)requestArgument
{
    return _param;
}

- (NSTimeInterval)requestTimeoutInterval
{
    return [super requestTimeoutInterval];
}

- (NSURLRequestCachePolicy)cachePolicy
{
    return [super cachePolicy];
}

- (NSDictionary *)responseHeaders
{
    return [super responseHeaders];
}

- (void)start
{
    [super start];
}

- (void)stop
{
    [super stop];
}

- (void)startWithCompletionBlockWithSuccess:(nullable DXZRequestCompletionBlock)success
                                    failure:(nullable DXZRequestCompletionBlock)failure
{
    [super startWithCompletionBlockWithSuccess:success
                                       failure:failure];
}

- (void)clearCompletionBlock
{
    [super clearCompletionBlock];
//    _requestSuccess = nil;
//    _requestFailure = nil;
}

- (void)dealloc
{
    [self clearCompletionBlock];
}

@end
