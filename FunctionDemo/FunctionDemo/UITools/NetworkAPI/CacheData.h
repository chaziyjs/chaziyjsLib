//
//  CacheData.h
//  WetalkCommunity
//
//  Created by chaziyjs on 2017/10/16.
//  Copyright © 2017年 chaziyjs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSDate+CalculatePeriod.h"

typedef void(^cleanCacheBlock)(void);

@interface CacheData : NSObject

+ (instancetype)shareCacheData;

- (BOOL)cacheWithURLResponse:(NSURLResponse *)response
                ResponseData:(NSData *)data
             SessionDataTask:(NSURLSessionDataTask *)task;

- (void)readCacheWithTask:(NSURLSessionDataTask *)task
               completion:(void (^)(NSData *data))handler;


/**
 *  清理缓存
 */
- (void)cleanCache:(cleanCacheBlock)block;

/**
 *  整个缓存目录的大小
 */
- (float)folderSizeAtPath;

@end
