//
//  DXZErrorCodeManager.h
//  DXZNetwork
//
//  Created by FoxDog on 2019/5/7.
//  Copyright © 2019 FoxDog. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, DXZErrorType)
{
    DXZErrorWithAFNetworkError,
    DXZErrorWithRequestCodeError
};

NS_ASSUME_NONNULL_BEGIN

@interface DXZErrorCodeManager : NSObject

+ (DXZErrorCodeManager *)sharedManager;

- (NSError *)handleErrorWithType:(DXZErrorType)errorType
                       ErrorCode:(NSString *)code
                           Error:(NSError * _Nullable)error;

@end

NS_ASSUME_NONNULL_END
