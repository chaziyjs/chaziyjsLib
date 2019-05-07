//
//  DXZBaseRequest.m
//  DXZNetwork
//
//  Created by FoxDog on 2019/4/29.
//  Copyright © 2019 FoxDog. All rights reserved.
//

#import "DXZBaseRequest.h"
#import "DXZNetworkConfig.h"
#import "DXZNetworkAPI.h"
#import "DXZNetworkPrivate.h"

#if __has_include(<AFNetworking/AFNetworking.h>)
#import <AFNetworking/AFNetworking.h>
#else
#import "AFNetworking.h"
#endif

NSString *const DXZRequestValidationErrorDomain = @"com.dxz.request.validation";

@interface DXZBaseRequest ()

@property (nonatomic, strong, readwrite) NSURLSessionDataTask *requestTask;
@property (nonatomic, strong, readwrite) NSData *responseData;
@property (nonatomic, strong, readwrite) id responseJSONObject;
@property (nonatomic, strong, readwrite) id responseObject;
@property (nonatomic, strong, readwrite) NSString *responseString;
@property (nonatomic, strong, readwrite) NSError *error;
@property (nonatomic, strong, readwrite) NSString *errorCode;
@property (nonatomic, assign, readwrite) BOOL codeError;

@end

@implementation DXZBaseRequest

- (NSURLRequestCachePolicy)cachePolicy
{
    return NSURLRequestReloadIgnoringLocalAndRemoteCacheData;
}

- (NSHTTPURLResponse *)response {
    return (NSHTTPURLResponse *)self.requestTask.response;
}

- (NSInteger)responseStatusCode {
    return self.response.statusCode;
}

- (NSDictionary *)responseHeaders {
    return self.response.allHeaderFields;
}

- (NSURLRequest *)currentRequest {
    return self.requestTask.currentRequest;
}

- (NSString *)requestUrl {
    return @"";
}

- (void)setResponseJSONObject:(id)responseJSONObject
{
    _responseJSONObject = responseJSONObject;
    [self jsonDataParser:responseJSONObject];
}

- (BOOL)readCacheResponse
{
    return self.readCacheResponse;
}

- (BOOL)isCancelled {
    if (!self.requestTask) {
        return NO;
    }
    return self.requestTask.state == NSURLSessionTaskStateCanceling;
}

- (void)setCompletionBlockWithSuccess:(DXZRequestCompletionBlock)success
                              failure:(DXZRequestCompletionBlock)failure {
    self.successCompletionBlock = success;
    self.failureCompletionBlock = failure;
}

- (void)clearCompletionBlock {
    // nil out to break the retain cycle.
    self.successCompletionBlock = nil;
    self.failureCompletionBlock = nil;
}

- (void)start {
    [[DXZNetworkAPI sharedAPI] addRequest:self];
}

- (void)stop {
    [[DXZNetworkAPI sharedAPI] cancelRequest:self];
}

- (void)startWithCompletionBlockWithSuccess:(DXZRequestCompletionBlock)success
                                    failure:(DXZRequestCompletionBlock)failure {
    [self setCompletionBlockWithSuccess:success failure:failure];
    [self start];
}

- (NSString *)baseUrl {
    return @"";
}

- (NSTimeInterval)requestTimeoutInterval {
    return 60.f;
}

- (DXZRequestMethod)requestMethod {
    return DXZRequestMethodGET;
}

- (DXZResponseSerializerType)responseSerializerType {
    return DXZResponseSerializerTypeJSON;
}

- (DXZRequestSerializerType)requestSerializerType {
    return DXZRequestSerializerTypeJSON;
}

- (BOOL)statusCodeValidator {
    NSInteger statusCode = [self responseStatusCode];
    return (statusCode >= 200 && statusCode <= 599);
}

- (nullable id)requestArgument {
    return nil;
}

- (id)jsonValidator {
    return nil;
}

- (nullable NSDictionary<NSString *, NSString *> *)requestHeaderFieldValueDictionary
{
    return nil;
}

- (void)jsonDataParser:(id)response
{
    
}

@end
