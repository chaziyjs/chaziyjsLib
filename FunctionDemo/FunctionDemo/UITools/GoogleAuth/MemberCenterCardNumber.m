//
//  MemberCenterCardNumber.m
//  AnywideConvenience
//
//  Created by chaziyjs on 2018/8/9.
//  Copyright © 2018年 Anywide1948. All rights reserved.
//

#import "MemberCenterCardNumber.h"

static NSString *key = @"345";

@implementation MemberCenterCardNumber

+ (NSString *)EncryptCodeWithMemberCardNumber:(NSString *)cardNum {
    NSData *base32Data = [NSData dataWithBase32String:key];
    //    Byte *decodedKey = (Byte *)[base32Data bytes];
    long timeIn = ([NSDate date].timeIntervalSince1970 / 30);
    NSMutableData *mData = [NSMutableData dataWithLength:8];
    Byte *data = (Byte *) [mData bytes];
    long value = timeIn;
    for (int signKey = 8; signKey-- > 0; value = value >> 8) {
        data[signKey] = (Byte)((int) (value));
    }
    NSData *SHA1Code = [[NSData dataWithBytes:data length:8] hmacSHA1DataWithKey:base32Data];
    //    NSData *codeData = [SHA1Code dataUsingEncoding: NSUTF8StringEncoding];
    Byte *hash = (Byte *) [SHA1Code bytes];
    int offset = hash[19] & 15;
    long truncatedHash = 0;
    for (int i = 0; i < 4; ++i) {
        truncatedHash = truncatedHash << 8;
        truncatedHash |= (long) (hash[offset + i] & 255);
    }
    truncatedHash &= 2147483647;
    truncatedHash %= 1000000;
    FLog(@"EncryptCode NUM = %ld", truncatedHash);
    NSString *secret = kStringWithFormat(@"%ld", truncatedHash);
    NSMutableString *resultNum = [NSMutableString string];
    if (secret.length >= cardNum.length) {
        for (int i = 0; i <= cardNum.length; i++) {
            if (i < cardNum.length) {
                [resultNum appendFormat:@"%@%@", [cardNum substringWithRange:NSMakeRange(i, 1)], [secret substringWithRange:NSMakeRange(i, 1)]];
            } else {
                [resultNum appendFormat:@"%@", [secret substringWithRange:NSMakeRange(i, secret.length - i)]];
            }
        }
    } else {
        for (int i = 0; i <= secret.length; i++) {
            if (i < secret.length) {
                [resultNum appendFormat:@"%@%@", [cardNum substringWithRange:NSMakeRange(i, 1)], [secret substringWithRange:NSMakeRange(i, 1)]];
            } else {
                [resultNum appendFormat:@"%@", [cardNum substringWithRange:NSMakeRange(i, cardNum.length - i)]];
            }
        }
    }

    return resultNum;
}

@end
