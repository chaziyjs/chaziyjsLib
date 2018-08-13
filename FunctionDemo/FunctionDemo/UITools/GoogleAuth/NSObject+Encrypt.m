//
//  NSObject+Encrypt.m
//  AnywideConvenience
//
//  Created by chaziyjs on 2018/8/9.
//  Copyright © 2018年 Anywide1948. All rights reserved.
//

#import "NSObject+Encrypt.h"

@implementation NSObject (Encrypt)

//HmacSHA1加密；
+ (NSString *)HmacSha1:(NSString *)key data:(NSString *)data
{
    const char *cKey  = [key cStringUsingEncoding:NSASCIIStringEncoding];
    const char *cData = [data cStringUsingEncoding:NSASCIIStringEncoding];
    //Sha256:
    // unsigned char cHMAC[CC_SHA256_DIGEST_LENGTH];
    //CCHmac(kCCHmacAlgSHA256, cKey, strlen(cKey), cData, strlen(cData), cHMAC);
    
    //sha1
    unsigned char cHMAC[CC_SHA1_DIGEST_LENGTH];
    CCHmac(kCCHmacAlgSHA1, cKey, strlen(cKey), cData, strlen(cData), cHMAC);
    
    NSData *HMAC = [[NSData alloc] initWithBytes:cHMAC
                                          length:sizeof(cHMAC)];
    
    NSString *hash = [HMAC base64EncodedStringWithOptions:0];//将加密结果进行一次BASE64编码。
    return hash;
}

+ (NSString *)HmacSha256:(NSString *)key data:(NSString *)data
{
    const char *cKey  = [key cStringUsingEncoding:NSASCIIStringEncoding];
    const char *cData = [data cStringUsingEncoding:NSASCIIStringEncoding];
    //Sha256:
     unsigned char cHMAC[CC_SHA256_DIGEST_LENGTH];
    CCHmac(kCCHmacAlgSHA256, cKey, strlen(cKey), cData, strlen(cData), cHMAC);
    
    NSData *HMAC = [[NSData alloc] initWithBytes:cHMAC
                                          length:sizeof(cHMAC)];
    
    NSString *hash = [HMAC base64EncodedStringWithOptions:0];//将加密结果进行一次BASE64编码。
    return hash;
}

//密码加密方式：SHA1
+ (NSString *)EncriptPassword_SHA1:(NSString *)password
{
    const char *cstr = [password cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:password.length];
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(data.bytes, data.length, digest);
    
    NSMutableString* result = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH *2];
    
    for(int i =0; i < CC_SHA1_DIGEST_LENGTH; i++) {
        [result appendFormat:@"%02x", digest[i]];
    }
    
    return [result uppercaseString];
}

@end
