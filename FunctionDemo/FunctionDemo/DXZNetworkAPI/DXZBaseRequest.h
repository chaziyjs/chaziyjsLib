//
//  DXZBaseRequest.h
//  DXZNetwork
//
//  Created by FoxDog on 2019/4/29.
//  Copyright © 2019 FoxDog. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

FOUNDATION_EXPORT NSString *const DXZRequestValidationErrorDomain;

NS_ENUM(NSInteger) {
    DXZRequestValidationErrorInvalidStatusCode = -8,
    DXZRequestValidationErrorInvalidJSONFormat = -9,
};

typedef NS_ENUM(NSInteger, DXZRequestPriority) {
    DXZRequestPriorityLow = -4L,
    DXZRequestPriorityDefault = 0,
    DXZRequestPriorityHigh = 4,
};

typedef NS_ENUM(NSInteger, DXZRequestMethod) {
    DXZRequestMethodGET = 0,
    DXZRequestMethodPOST,
    DXZRequestMethodHEAD,
    DXZRequestMethodPUT,
    DXZRequestMethodDELETE,
    DXZRequestMethodPATCH,
};
    
typedef NS_ENUM(NSInteger, DXZRequestSerializerType) {
    DXZRequestSerializerTypeHTTP = 0,
    DXZRequestSerializerTypeJSON,
};

typedef NS_ENUM(NSInteger, DXZResponseSerializerType) {
    /// JSON object type
    DXZResponseSerializerTypeJSON,
    /// NSData type
    DXZResponseSerializerTypeHTTP,
    /// NSXMLParser type
    DXZResponseSerializerTypeXMLParser,
};

@protocol AFMultipartFormData;

typedef void (^AFConstructingBlock)(id<AFMultipartFormData> formData);
typedef void (^AFURLSessionTaskProgressBlock)(NSProgress *);

@class DXZBaseRequest;

typedef void(^DXZRequestCompletionBlock)(__kindof DXZBaseRequest *request);

@interface DXZBaseRequest : NSObject

@property (nonatomic, strong, readonly) NSURLSessionDataTask *requestTask;

@property (nonatomic, strong, readonly) NSURLRequest *currentRequest;

@property (nonatomic, strong, readonly) NSURLRequest *originalRequest;

@property (nonatomic, assign, readwrite) NSURLRequestCachePolicy cachePolicy;

@property (nonatomic, strong, readonly) NSHTTPURLResponse *response;

@property (nonatomic, strong, readonly, nullable) NSDictionary *responseHeaders;

@property (nonatomic, strong, readonly, nullable) NSData *responseData;

@property (nonatomic, strong, readonly, nullable) NSString *responseString;

@property (nonatomic, strong, nullable) NSString *resumableDownloadPath;

@property (nonatomic, strong, readonly, nullable) id responseObject;

@property (nonatomic, strong, readonly, nullable) id responseJSONObject;

@property (nonatomic, readonly, getter=isCancelled) BOOL cancelled;

@property (nonatomic, copy, nullable) AFConstructingBlock constructingBodyBlock;

@property (nonatomic, copy, nullable) DXZRequestCompletionBlock successCompletionBlock;

@property (nonatomic, copy, nullable) DXZRequestCompletionBlock failureCompletionBlock;

@property (nonatomic) DXZRequestPriority requestPriority;

@property (nonatomic, assign) BOOL readCacheResponse;

@property (nonatomic, strong, readonly) NSError *error;


- (void)start;

- (void)stop;

- (void)startWithCompletionBlockWithSuccess:(nullable DXZRequestCompletionBlock)success
                                    failure:(nullable DXZRequestCompletionBlock)failure;

- (void)clearCompletionBlock;

- (DXZRequestMethod)requestMethod;

- (nullable NSDictionary<NSString *, NSString *> *)requestHeaderFieldValueDictionary;

- (NSString *)baseUrl;

- (NSString *)requestUrl;

- (nullable id)requestArgument;

- (NSTimeInterval)requestTimeoutInterval;

- (BOOL)statusCodeValidator;

- (id)jsonValidator;

- (NSURLRequestCachePolicy)cachePolicy;

- (NSDictionary *)responseHeaders;

///  Request serializer type.
- (DXZRequestSerializerType)requestSerializerType;

///  Response serializer type. See also `responseObject`.
- (DXZResponseSerializerType)responseSerializerType;

@end

NS_ASSUME_NONNULL_END
