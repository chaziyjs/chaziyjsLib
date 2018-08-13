//
//  MemberCenterCardNumber.h
//  AnywideConvenience
//
//  Created by chaziyjs on 2018/8/9.
//  Copyright © 2018年 Anywide1948. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+Encrypt.h"
#import "MF_Base32Additions.h"

NS_ASSUME_NONNULL_BEGIN

@interface MemberCenterCardNumber : NSObject

+ (NSMutableString *)EncryptCodeWithMemberCardNumber:(NSString *)cardNum;

@end

NS_ASSUME_NONNULL_END
