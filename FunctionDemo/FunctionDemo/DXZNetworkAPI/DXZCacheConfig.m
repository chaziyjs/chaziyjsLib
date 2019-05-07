//
//  DXZCacheConfig.m
//  DXZNetwork
//
//  Created by FoxDog on 2019/4/29.
//  Copyright © 2019 FoxDog. All rights reserved.
//

#import "DXZCacheConfig.h"
#import "DXZNetworkPrivate.h"

#ifndef NSFoundationVersionNumber_iOS_8_0
#define NSFoundationVersionNumber_With_QoS_Available 1140.11
#else
#define NSFoundationVersionNumber_With_QoS_Available NSFoundationVersionNumber_iOS_8_0
#endif

NSString *const DXZRequestCacheErrorDomain = @"com.dxz.request.caching";

static dispatch_queue_t dxzrequest_cache_writing_queue() {
    static dispatch_queue_t queue;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dispatch_queue_attr_t attr = DISPATCH_QUEUE_SERIAL;
        if (NSFoundationVersionNumber >= NSFoundationVersionNumber_With_QoS_Available) {
            attr = dispatch_queue_attr_make_with_qos_class(attr, QOS_CLASS_BACKGROUND, 0);
        }
        queue = dispatch_queue_create("com.dxz.request.caching", attr);
    });
    return queue;
}

@interface DXZCacheConfig ()

@end

@implementation DXZCacheConfig {
    NSURLCache *_cache;
    NSString *_path;
}

+ (DXZCacheConfig *)sharedConfig {
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSString *cachePatch = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
        _path = [cachePatch stringByAppendingPathComponent:@"/CacheData/"];
        _cache = [[NSURLCache alloc] initWithMemoryCapacity:MemerayMaxSize diskCapacity:DiskMaxSize diskPath:_path];
    }
    return self;
}

- (void)storeCacheWithRequest:(DXZBaseRequest *)request
{
    dispatch_async(dxzrequest_cache_writing_queue(), ^{
        NSCachedURLResponse *cache_response = [[NSCachedURLResponse alloc] initWithResponse:request.response data:request.responseData userInfo:nil storagePolicy:NSURLCacheStorageAllowed];
        [self->_cache storeCachedResponse:cache_response forDataTask:request.requestTask];
    });
}

- (void)readCacheWithRequest:(DXZBaseRequest *)request
               completion:(void (^)(NSData *data))handler
{
    if (request.requestTask) {
        [_cache getCachedResponseForDataTask:request.requestTask completionHandler:^(NSCachedURLResponse * _Nullable cachedResponse) {
            handler(cachedResponse.data);
        }];
    } else {
        handler([self readCacheWithKey:request.baseUrl]);
    }
}

- (NSData *)readCacheWithKey:(NSString *)key
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *rename_key = [key stringByReplacingOccurrencesOfString:@"/" withString:@""];
    NSString *all_path = [_path stringByAppendingFormat:@"/%@", rename_key];
    if ([fileManager fileExistsAtPath:all_path]) {
        NSString *date_str = [[all_path componentsSeparatedByString:@"_"] lastObject];
        NSTimeInterval times = [DXZNetworkUtils secFromLotteryDate:[NSDate dateWithTimeIntervalSince1970:[date_str doubleValue]] CurrentDate:[NSDate date]];
        if (EXPIRE_TIME >= times) {
            return [NSData dataWithContentsOfURL:[NSURL fileURLWithPath:all_path]];
        } else {
            NSLog(@"缓存数据已过期");
        }
    } else {
        NSLog(@"不存在缓存文件");
    }
    return nil;
}

/**
 *  清理网络数据缓存
 */
- (void)cleanCache:(cleanCacheBlock)block
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //文件路径
        NSArray *subpaths = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:self->_path error:nil];
        for (NSString *subPath in subpaths) {
            NSString *filePath = [self->_path stringByAppendingPathComponent:subPath];
            [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
        }
        //返回主线程
        dispatch_async(dispatch_get_main_queue(), ^{
            block();
        });
    });
}
/**
 *  计算整个目录大小,单位KB (1000为进率运算)
 */
- (double)folderSizeAtPath
{
    NSString *folderPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    NSFileManager *manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:folderPath]) {
        return 0 ;
    }
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator ];
    NSString *fileName = @"";
    long long folderSize = 0 ;
    while ((fileName = [childFilesEnumerator nextObject]) != nil){
        NSString * fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        folderSize += [self fileSizeAtPath:fileAbsolutePath];
    }
    return folderSize * 0.001f;
}

/**
 *  计算单个文件大小
 */
- (long long)fileSizeAtPath:(NSString *)filePath
{
    NSFileManager *manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]){
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0 ;
}


@end
