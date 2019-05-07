//
//  DXZNetworkPrivate.h
//  DXZNetwork
//
//  Created by FoxDog on 2019/4/30.
//  Copyright © 2019 FoxDog. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DXZNetworkAPI.h"
#import "DXZNetworkConfig.h"
#import "DXZBaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface DXZBaseRequest (Setter)

@property (nonatomic, strong, readwrite) NSURLSessionDataTask *requestTask;
@property (nonatomic, strong, readwrite, nullable) NSData *responseData;
@property (nonatomic, strong, readwrite, nullable) id responseJSONObject;
@property (nonatomic, strong, readwrite, nullable) id responseObject;
@property (nonatomic, strong, readwrite, nullable) NSString *responseString;
@property (nonatomic, strong, readwrite, nullable) NSError *error;

@end

@interface DXZNetworkUtils : NSObject

+ (BOOL)validateJSON:(id)json withValidator:(id)jsonValidator;

+ (void)addDoNotBackupAttribute:(NSString *)path;

+ (NSString *)md5StringFromString:(NSString *)string;

+ (NSString *)appVersionString;

+ (NSStringEncoding)stringEncodingWithRequest:(DXZBaseRequest *)request;

+ (BOOL)validateResumeData:(NSData *)data;

+ (NSTimeInterval)secFromLotteryDate:(NSDate *)lotDate CurrentDate:(NSDate *)curDate;

@end



NS_ASSUME_NONNULL_END
