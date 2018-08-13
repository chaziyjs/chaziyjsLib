//
//  CodeManager.h
//  AFNetworking-demo
//
//  Created by jackson.song on 16/4/5.
//  Copyright © 2016年 Jakey. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CodeManager : NSObject

+ (instancetype)sharedCodeManager;

#pragma mark - Error Code Handler
- (void)errorCode:(NSHTTPURLResponse *)httpResponse Error:(NSError *)neterror response:(void(^)(NSError *error, NSNumber *result,NSString *msg))response;

@end
