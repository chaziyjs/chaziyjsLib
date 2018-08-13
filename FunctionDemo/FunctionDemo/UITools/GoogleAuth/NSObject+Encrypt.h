//
//  NSObject+Encrypt.h
//  AnywideConvenience
//
//  Created by chaziyjs on 2018/8/9.
//  Copyright © 2018年 Anywide1948. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <CommonCrypto/CommonDigest.h>
#include <CommonCrypto/CommonHMAC.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (Encrypt)

+ (NSString *)HmacSha1:(NSString *)key data:(NSString *)data;
+ (NSString *)HmacSha256:(NSString *)key data:(NSString *)data;

+ (NSString *)EncriptPassword_SHA1:(NSString *)password;

@end

NS_ASSUME_NONNULL_END
