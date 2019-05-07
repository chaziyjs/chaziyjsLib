//
//  DXZNetworkAPI.m
//  DXZNetwork
//
//  Created by FoxDog on 2019/4/29.
//  Copyright © 2019 FoxDog. All rights reserved.
//

#import "DXZNetworkAPI.h"
#import "DXZNetworkConfig.h"
#import "DXZCacheConfig.h"
#import "DXZNetworkPrivate.h"
#import <pthread/pthread.h>
#import "DXZErrorCodeManager.h"

#if __has_include(<AFNetworking/AFNetworking.h>)
#import <AFNetworking/AFNetworking.h>
#else
#import "AFNetworking.h"
#endif

#define Lock() pthread_mutex_lock(&_lock)
#define Unlock() pthread_mutex_unlock(&_lock)
#define kDXZNetworkIncompleteDownloadFolderName @"Incomplete"

@implementation DXZNetworkAPI {
    AFHTTPSessionManager *_manager;
    DXZNetworkConfig *_config;
    AFJSONResponseSerializer *_jsonResponseSerializer;
    AFHTTPResponseSerializer *_httpResponseSerializer;
    AFXMLParserResponseSerializer *_xmlParserResponseSerialzier;
    NSMutableDictionary<NSNumber *, DXZBaseRequest *> *_requestsRecord;
    
    dispatch_queue_t _processingQueue;
    pthread_mutex_t _lock;
    NSIndexSet *_allStatusCodes;
}

+ (DXZNetworkAPI *)sharedAPI {
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _config = [DXZNetworkConfig sharedConfig];
        _manager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:_config.sessionConfiguration];
        _requestsRecord = [NSMutableDictionary dictionary];
        _processingQueue = dispatch_queue_create("com.DXZ.networkagent.processing", DISPATCH_QUEUE_CONCURRENT);
        _allStatusCodes = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(100, 500)];
        pthread_mutex_init(&_lock, NULL);
        
        _manager.securityPolicy = _config.securityPolicy;
        _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        // Take over the status code validation
        _manager.responseSerializer.acceptableStatusCodes = _allStatusCodes;
        _manager.completionQueue = _processingQueue;
    }
    return self;
}

- (NSString *)buildRequestUrl:(DXZBaseRequest *)request {
    NSParameterAssert(request != nil);
    NSString *baseUrl;
    NSString *detailUrl = [request requestUrl];
    if ([request baseUrl].length > 0) {
        baseUrl = [request baseUrl];
    } 
    // URL slash compability
    NSURL *url = [NSURL URLWithString:baseUrl];
    
    if (baseUrl.length > 0 && ![baseUrl hasSuffix:@"/"]) {
        url = [url URLByAppendingPathComponent:@""];
    }
    
    return [NSURL URLWithString:detailUrl relativeToURL:url].absoluteString;
}

- (AFHTTPRequestSerializer *)requestSerializerForRequest:(DXZBaseRequest *)request {
    
    AFHTTPRequestSerializer *requestSerializer = nil;
    if (request.requestSerializerType == DXZRequestSerializerTypeHTTP) {
        requestSerializer = [AFHTTPRequestSerializer serializer];
    } else if (request.requestSerializerType == DXZRequestSerializerTypeJSON) {
        requestSerializer = [AFJSONRequestSerializer serializer];
    }
    
    requestSerializer.timeoutInterval = [request requestTimeoutInterval];
    requestSerializer.allowsCellularAccess = YES;
    
    // If api needs to add custom value to HTTPHeaderField
    NSDictionary<NSString *, NSString *> *headerFieldValueDictionary = [request requestHeaderFieldValueDictionary];
    if (headerFieldValueDictionary != nil) {
        for (NSString *httpHeaderField in headerFieldValueDictionary.allKeys) {
            NSString *value = headerFieldValueDictionary[httpHeaderField];
            [requestSerializer setValue:value forHTTPHeaderField:httpHeaderField];
        }
    }
    
    return requestSerializer;
}

/**
 使用AFNetwork的请求方式进行Session请求

 @param request 请求Request的Model
 @param error 错误信息
 @return 当前会话的数据任务
 */
- (NSURLSessionDataTask *)sessionTaskForRequest:(DXZBaseRequest *)request error:(NSError *)error {
    DXZRequestMethod method = [request requestMethod];
    NSString *url = [self buildRequestUrl:request];
    id param = request.requestArgument;
    AFHTTPRequestSerializer *requestSerializer = [self requestSerializerForRequest:request];
    return [self dataTaskWithHTTPMethod:method requestSerializer:requestSerializer URLString:url parameters:param error:error];
}

/**
 将请求加入队列中 Retain Request Model

 @param request 当前请求的Request Model
 */
- (void)addRequest:(DXZBaseRequest *)request {
    switch (request.cachePolicy) {
        case NSURLRequestReturnCacheDataDontLoad:
        {
            [[DXZCacheConfig sharedConfig] readCacheWithRequest:request completion:^(NSData * _Nullable data) {
                NSError * __autoreleasing error = nil;
                if (data && data.length > 0) {
                    request.readCacheResponse = YES;
                    request.responseData = data;
                    id jsonObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
                    request.responseJSONObject = jsonObject;
                    [self requestDidSuccess:request];
                } else {
                    [self requestDidFailureWithRequest:request error:error];
                }
            }];
        } break;
        case NSURLRequestReturnCacheDataElseLoad:
        {
            [[DXZCacheConfig sharedConfig] readCacheWithRequest:request completion:^(NSData * _Nullable data) {
                NSError * __autoreleasing cacheError = nil;
                if (data && data.length > 0) {
                    request.readCacheResponse = YES;
                    request.responseData = data;
                    id jsonObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&cacheError];
                    request.responseJSONObject = jsonObject;
                    [self requestDidSuccess:request];
                } else {
                    [self begainRequestWithRequest:request];
                }
            }];
        } break;
        default:
        {
            [self begainRequestWithRequest:request];
        } break;
    }
}

- (void)begainRequestWithRequest:(DXZBaseRequest *)request
{
    NSParameterAssert(request != nil);
    NSError *requestSerializationError = nil;
    request.requestTask = [self sessionTaskForRequest:request error:requestSerializationError];
    if (requestSerializationError) {
        [self requestDidFailureWithRequest:request error:requestSerializationError];
        return;
    }
    NSAssert(request.requestTask != nil, @"requestTask should not be nil");
    // Set request task priority
    // !!Available on iOS 8 +
    if ([request.requestTask respondsToSelector:@selector(priority)]) {
        switch (request.requestPriority) {
            case DXZRequestPriorityHigh:
                request.requestTask.priority = NSURLSessionTaskPriorityHigh;
                break;
            case DXZRequestPriorityLow:
                request.requestTask.priority = NSURLSessionTaskPriorityLow;
                break;
            case DXZRequestPriorityDefault:
                /*!!fall through*/
            default:
                request.requestTask.priority = NSURLSessionTaskPriorityDefault;
                break;
        }
    }
    
    // Retain request
    [self addRequestToRecord:request];
    [request.requestTask resume];
}

- (void)addRequestToRecord:(DXZBaseRequest *)request {
    Lock();
    _requestsRecord[@(request.requestTask.taskIdentifier)] = request;
    Unlock();
}

- (void)removeRequestFromRecord:(DXZBaseRequest *)request {
    Lock();
    [_requestsRecord removeObjectForKey:@(request.requestTask.taskIdentifier)];
    NSLog(@"Request queue size = %zd", [_requestsRecord count]);
    Unlock();
}

/**
 网络请求

 @param method 请求方式POST/GET...
 @param requestSerializer HTTP请求序列化
 @param URLString 请求地址
 @param parameters 请求参数
 @param error 错误信息
 @return 返回当前请求的数据任务
 */
- (NSURLSessionDataTask *)dataTaskWithHTTPMethod:(DXZRequestMethod)method
                               requestSerializer:(AFHTTPRequestSerializer *)requestSerializer
                                       URLString:(NSString *)URLString
                                      parameters:(id)parameters
                                           error:(NSError * _Nullable)error {
    _manager.requestSerializer = requestSerializer;
    switch (method) {
        case DXZRequestMethodGET:
            return [_manager GET:URLString parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSError * __autoreleasing handleError = nil;
                [self handleRequestSuccess:task Response:responseObject Error:handleError];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [self handleRequestFailure:task Error:error];
            }];
        case DXZRequestMethodPOST:
            return [_manager POST:URLString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSError * __autoreleasing handleError = nil;
                [self handleRequestSuccess:task Response:responseObject Error:handleError];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [self handleRequestFailure:task Error:error];
            }];
        case DXZRequestMethodHEAD:
            return [_manager HEAD:URLString parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task) {
                NSError * __autoreleasing handleError = nil;
                [self handleRequestSuccess:task Response:nil Error:handleError];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [self handleRequestFailure:task Error:error];
            }];
        case DXZRequestMethodPUT:
            return [_manager PUT:URLString parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSError * __autoreleasing handleError = nil;
                [self handleRequestSuccess:task Response:responseObject Error:handleError];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [self handleRequestFailure:task Error:error];
            }];
        case DXZRequestMethodDELETE:
            return [_manager DELETE:URLString parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSError * __autoreleasing handleError = nil;
                [self handleRequestSuccess:task Response:responseObject Error:handleError];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [self handleRequestFailure:task Error:error];
            }];
        case DXZRequestMethodPATCH:
            return [_manager PATCH:URLString parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSError * __autoreleasing handleError = nil;
                [self handleRequestSuccess:task Response:responseObject Error:handleError];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [self handleRequestFailure:task Error:error];
            }];
    }
}

/**
 处理接口请求成功后的数据

 @param task 当前数据任务
 @param responseObject 返回结果
 @param error 错误信息
 */
- (void)handleRequestSuccess:(NSURLSessionDataTask *)task Response:(nullable id)responseObject Error:(NSError *_Nullable)error
{
    Lock();
    DXZBaseRequest *request = _requestsRecord[@(task.taskIdentifier)];
    Unlock();
    NSError * __autoreleasing serializationError = nil;
    NSError * __autoreleasing validationError = nil;
    
    NSError *requestError = error;
    BOOL succeed = NO;
    
    request.responseObject = responseObject;
    if ([responseObject isKindOfClass:[NSData class]]) {
        request.responseData = responseObject;
        request.responseString = [[NSString alloc] initWithData:responseObject encoding:[DXZNetworkUtils stringEncodingWithRequest:request]];
        switch (request.responseSerializerType) {
            case DXZResponseSerializerTypeJSON:
            {
                request.responseObject = [self.jsonResponseSerializer responseObjectForResponse:task.response data:responseObject error:&serializationError];
                request.responseJSONObject = request.responseObject;
            } break;
            case DXZResponseSerializerTypeHTTP:
            {
                request.responseJSONObject = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&serializationError];
            } break;
            case DXZResponseSerializerTypeXMLParser:
            {
                request.responseObject = [self.xmlParserResponseSerialzier responseObjectForResponse:task.response data:request.responseData error:&serializationError];
            } break;
        }
    } else if (responseObject == nil && request.requestMethod == DXZRequestMethodHEAD) {
        succeed = YES;
    }
    
    if (error) {
        succeed = NO;
    } else if (serializationError) {
        succeed = NO;
        requestError = serializationError;
    } else {
        succeed = [self validateResult:request error:&validationError];
    }
    
    if (succeed) {
        [self requestDidSuccess:request];
    } else {
        [self handleRequestFailure:task Error:requestError];
    }
    
    if (request.cachePolicy == NSURLRequestUseProtocolCachePolicy || request.cachePolicy == NSURLRequestReturnCacheDataElseLoad || request.cachePolicy == NSURLRequestReturnCacheDataDontLoad) {
        [[DXZCacheConfig sharedConfig] storeCacheWithRequest:request];
    }
}

/**
 当处理完请求成功的数据后,在此回调

 @param request 请求Request的Model
 */
- (void)requestDidSuccess:(DXZBaseRequest *)request
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (request.successCompletionBlock) {
            request.successCompletionBlock(request);
        }
    });
}

/**
 处理请求失败后的错误信息

 @param task 当前请求的数据任务
 @param error 错误信息
 */
- (void)handleRequestFailure:(NSURLSessionDataTask *)task Error:(NSError *_Nullable)error
{
    Lock();
    DXZBaseRequest *request = _requestsRecord[@(task.taskIdentifier)];
    Unlock();
    
    request.error = error;
    
    NSData *incompleteDownloadData = error.userInfo[NSURLSessionDownloadTaskResumeData];
    if (incompleteDownloadData) {
        [incompleteDownloadData writeToURL:[self incompleteDownloadTempPathForDownloadPath:request.resumableDownloadPath] atomically:YES];
    }
    // Load response from file and clean up if download task failed.
    if ([request.responseObject isKindOfClass:[NSURL class]]) {
        NSURL *url = request.responseObject;
        if (url.isFileURL && [[NSFileManager defaultManager] fileExistsAtPath:url.path]) {
            request.responseData = [NSData dataWithContentsOfURL:url];
            request.responseString = [[NSString alloc] initWithData:request.responseData encoding:[DXZNetworkUtils stringEncodingWithRequest:request]];
            [[NSFileManager defaultManager] removeItemAtURL:url error:nil];
        }
        request.responseObject = nil;
    }
    
    if (request.cachePolicy == NSURLRequestUseProtocolCachePolicy) {
        [[DXZCacheConfig sharedConfig] readCacheWithRequest:request completion:^(NSData * _Nullable data) {
            if (data.length > 0) {
                request.readCacheResponse = YES;
                NSError * __autoreleasing serializationError = nil;
                request.responseData = data;
                request.responseString = [[NSString alloc] initWithData:data encoding:[DXZNetworkUtils stringEncodingWithRequest:request]];
                request.responseObject = [self.jsonResponseSerializer responseObjectForResponse:task.response data:data error:&serializationError];
                request.responseJSONObject = request.responseObject;
            } else {
                [self requestDidFailureWithRequest:request error:error];
            }
        }];
    } else {
        [self requestDidFailureWithRequest:request error:error];
    }
}

/**
 请求失败后的数据回调

 @param request 请求Request的Model
 @param error 错误信息
 */
- (void)requestDidFailureWithRequest:(DXZBaseRequest *)request error:(NSError *)error
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (request.failureCompletionBlock) {
            request.failureCompletionBlock(request);
        }
    });
}

- (BOOL)validateResult:(DXZBaseRequest *)request error:(NSError * _Nullable __autoreleasing *)error {
    BOOL result = [request statusCodeValidator];
    if (!result) {
        if (error) {
            *error = [NSError errorWithDomain:DXZRequestValidationErrorDomain code:DXZRequestValidationErrorInvalidStatusCode userInfo:@{NSLocalizedDescriptionKey:@"Invalid status code"}];
        }
        return result;
    }
    id json = [request responseJSONObject];
    id validator = [request jsonValidator];
    if (json && validator) {
        result = [DXZNetworkUtils validateJSON:json withValidator:validator];
        if (!result) {
            if (error) {
                *error = [NSError errorWithDomain:DXZRequestValidationErrorDomain code:DXZRequestValidationErrorInvalidJSONFormat userInfo:@{NSLocalizedDescriptionKey:@"Invalid JSON format"}];
            }
            return result;
        }
    }
    return YES;
}

/**
 取消当前请求

 @param request 请求Request的Model
 */
- (void)cancelRequest:(DXZBaseRequest *)request {
    NSParameterAssert(request != nil);
    [request.requestTask cancel];
    [self removeRequestFromRecord:request];
    [request clearCompletionBlock];
}

- (NSString *)incompleteDownloadTempCacheFolder {
    NSFileManager *fileManager = [NSFileManager new];
    static NSString *cacheFolder;
    
    if (!cacheFolder) {
        NSString *cacheDir = NSTemporaryDirectory();
        cacheFolder = [cacheDir stringByAppendingPathComponent:kDXZNetworkIncompleteDownloadFolderName];
    }
    
    NSError *error = nil;
    if(![fileManager createDirectoryAtPath:cacheFolder withIntermediateDirectories:YES attributes:nil error:&error]) {
        NSLog(@"Failed to create cache directory at %@", cacheFolder);
        cacheFolder = nil;
    }
    return cacheFolder;
}

- (NSURL *)incompleteDownloadTempPathForDownloadPath:(NSString *)downloadPath {
    NSString *tempPath = nil;
    NSString *md5URLString = [DXZNetworkUtils md5StringFromString:downloadPath];
    tempPath = [[self incompleteDownloadTempCacheFolder] stringByAppendingPathComponent:md5URLString];
    return [NSURL fileURLWithPath:tempPath];
}

#pragma mark - 加载及初始化内容
- (AFHTTPSessionManager *)manager {
    return _manager;
}

- (void)resetURLSessionManager {
    _manager = [AFHTTPSessionManager manager];
}

- (void)resetURLSessionManagerWithConfiguration:(NSURLSessionConfiguration *)configuration {
    _manager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:configuration];
}

- (AFJSONResponseSerializer *)jsonResponseSerializer {
    if (!_jsonResponseSerializer) {
        _jsonResponseSerializer = [AFJSONResponseSerializer serializer];
        _jsonResponseSerializer.acceptableStatusCodes = _allStatusCodes;
        _jsonResponseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/javascript",@"text/html",@"text/plain",nil];
    }
    return _jsonResponseSerializer;
}

- (AFHTTPResponseSerializer *)httpResponseSerializer {
    if (!_httpResponseSerializer) {
        _httpResponseSerializer = [AFHTTPResponseSerializer serializer];
        _httpResponseSerializer.acceptableStatusCodes = _allStatusCodes;
        _httpResponseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/javascript",@"text/html",@"text/plain",nil];
    }
    return _httpResponseSerializer;
}

- (AFXMLParserResponseSerializer *)xmlParserResponseSerialzier {
    if (!_xmlParserResponseSerialzier) {
        _xmlParserResponseSerialzier = [AFXMLParserResponseSerializer serializer];
        _xmlParserResponseSerialzier.acceptableStatusCodes = _allStatusCodes;
    }
    return _xmlParserResponseSerialzier;
}

@end
