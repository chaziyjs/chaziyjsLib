//
//  DXZCacheConfig.h
//  DXZNetwork
//
//  Created by FoxDog on 2019/4/29.
//  Copyright © 2019 FoxDog. All rights reserved.
//

#import <Foundation/Foundation.h>

#define EXPIRE_TIME         172800 //两天的秒数
#define MemerayMaxSize      (20*1024*1024)
#define DiskMaxSize         (50*1024*1024)

@class DXZBaseRequest;
NS_ASSUME_NONNULL_BEGIN

typedef void(^cleanCacheBlock)(void);

@interface DXZCacheConfig : NSObject

+ (DXZCacheConfig *)sharedConfig;

- (void)storeCacheWithRequest:(DXZBaseRequest *)request;

- (void)readCacheWithRequest:(DXZBaseRequest *)request
                  completion:(void (^)(NSData * _Nullable data))handler;

- (void)cleanCache:(cleanCacheBlock)block;

- (double)folderSizeAtPath;

@end

NS_ASSUME_NONNULL_END
