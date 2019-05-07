//
//  DXZNetworkAPI.h
//  DXZNetwork
//
//  Created by FoxDog on 2019/4/29.
//  Copyright © 2019 FoxDog. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DXZBaseRequest;
NS_ASSUME_NONNULL_BEGIN

@interface DXZNetworkAPI : NSObject

+ (DXZNetworkAPI *)sharedAPI;

- (void)addRequest:(DXZBaseRequest *)request;

- (void)cancelRequest:(DXZBaseRequest *)request;

@end

NS_ASSUME_NONNULL_END
