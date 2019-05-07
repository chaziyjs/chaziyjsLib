//
//  DXZRequest.h
//  DXZNetwork
//
//  Created by FoxDog on 2019/4/29.
//  Copyright © 2019 FoxDog. All rights reserved.
//

#import "DXZBaseRequest.h"
#import "NSObject+YYModel.h"

NS_ASSUME_NONNULL_BEGIN
//@class DXZRequest;
//typedef void(^middlewareRequestSuccess)(id __nonnull model);
//typedef void(^middlewareRequestFailure)(__kindof DXZRequest *request);

@interface DXZRequest : DXZBaseRequest

@property (nonatomic, copy) NSString *URL;
@property (nonatomic, strong, readonly) NSURL *requestURL;

//@property (nonatomic, copy) middlewareRequestSuccess requestSuccess;
//@property (nonatomic, copy) middlewareRequestFailure requestFailure;

//- (void)requestWithComletionBlockWithSuccess:(middlewareRequestSuccess)success
//                                     failure:(middlewareRequestFailure)failure;
//
//- (void)setRequestCompletionBlockWithSuccess:(middlewareRequestSuccess)success
//                                     failure:(middlewareRequestFailure)failure;

+ (instancetype)requestWithURL:(NSString * _Nullable)url
                         param:(nullable id)param
                 requestMethod:(DXZRequestMethod)method
     ComletionBlockWithSuccess:(nullable DXZRequestCompletionBlock)success
                       failure:(nullable DXZRequestCompletionBlock)failure;

//- (void)startWithCompletionBlockWithSuccess:(nullable DXZRequestCompletionBlock)success
//                                    failure:(nullable DXZRequestCompletionBlock)failure;

- (void)start;

- (void)stop;

- (void)clearCompletionBlock;

@end

NS_ASSUME_NONNULL_END
