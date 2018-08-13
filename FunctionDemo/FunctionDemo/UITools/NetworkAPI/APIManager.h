//
//  APIManager.h
//  AFNetworking-demo
//
//  Created by Jakey on 16/4/1.
//  Copyright © 2016年 www.skyfox.org. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPSessionManager.h"
#import "NSDate+CalculatePeriod.h"
#import "CacheData.h"
#import "AFSecurityPolicy.h"
#import "AFNetworkActivityIndicatorManager.h"
#import "CodeManager.h"


@interface APIManager : AFHTTPSessionManager

@property (readonly, nonatomic, strong) NSHTTPURLResponse *response;
@property (readonly, nonatomic, strong) id responseObject;
@property (readonly, nonatomic, assign) BOOL network_error;
@property (nonatomic, strong) AFSecurityPolicy *policy;
@property (nonatomic, assign) AFNetworkReachabilityStatus networkStatus;
@property (nonatomic, strong) NSMutableDictionary *login_cookie;

+ (instancetype)sharedManager;

+ (NSURLSessionDataTask *)SafePOST:(NSString *)URLString
                        parameters:(id)parameters
                         needCache:(BOOL)isCache
                           success:(void (^)(NSURLSessionDataTask * task, id responseObject, BOOL cacheResult))success
                           failure:(void (^)(NSURLSessionDataTask * task, NSError *error, NSNumber *result, id cacheData,NSString *msg))failure;

+ (NSURLSessionDataTask *)SafeGET:(NSString *)URLString
                       parameters:(id)parameters
                        needCache:(BOOL)isCache
                          success:(void (^)(NSURLSessionDataTask * task, id responseObject, BOOL cacheResult))success
                          failure:(void (^)(NSURLSessionDataTask * task, NSError *error, NSNumber *result, id cacheData,NSString *msg))failure;


+ (AFSecurityPolicy*)customSecurityPolicy;

- (NSDictionary *)synsSaveCookies:(NSHTTPURLResponse *)response;

- (NSDictionary *)secureParameters:(NSDictionary *)param RequestURL:(NSString *)url;

+ (void)reset;
@end
