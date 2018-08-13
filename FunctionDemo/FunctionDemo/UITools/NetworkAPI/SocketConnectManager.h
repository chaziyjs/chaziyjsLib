//
//  SocketConnectManager.h
//  SocketDemo
//
//  Created by chaziyjs on 17/4/25.
//  Copyright © 2017年 chaziyjs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GCDAsyncSocket.h"
#import <CommonCrypto/CommonDigest.h>
#import <objc/runtime.h>

typedef void(^success)(NSDictionary *response);
typedef void(^failure)(NSNumber *errorCode, NSString *errorMsg);

@interface SocketConnectManager : NSObject<GCDAsyncSocketDelegate>

@property (nonatomic, strong) GCDAsyncSocket *asyncsocket;
@property (nonatomic, copy) success successResponse;
@property (nonatomic, copy) failure failureResponse;
@property (nonatomic, strong) NSMutableDictionary *param;
@property (nonatomic, readonly, assign) NSUInteger requestTimes;

@property (nonatomic, strong) NSMutableData *mutableData;

+ (instancetype)sharedManager;

+ (void)reset;

+ (void)sendSocketMessageWithParam:(NSDictionary *)param
                           success:(success)response
                           failure:(failure)result;

@end
