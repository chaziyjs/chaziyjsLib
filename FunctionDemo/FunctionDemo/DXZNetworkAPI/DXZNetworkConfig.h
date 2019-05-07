//
//  DXZNetworkConfig.h
//  DXZNetwork
//
//  Created by FoxDog on 2019/4/29.
//  Copyright © 2019 FoxDog. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class AFSecurityPolicy;

@interface DXZNetworkConfig : NSObject

@property (nonatomic, strong) NSString *baseURL;

@property (nonatomic, strong) AFSecurityPolicy *securityPolicy;

@property (nonatomic, strong) NSURLSessionConfiguration* sessionConfiguration;



+ (DXZNetworkConfig *)sharedConfig;

@end

NS_ASSUME_NONNULL_END
