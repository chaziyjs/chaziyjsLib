//
//  CacheData.m
//  WetalkCommunity
//
//  Created by chaziyjs on 2017/10/16.
//  Copyright © 2017年 chaziyjs. All rights reserved.
//

#import "CacheData.h"

#define EXPIRE_TIME         172800 //两天的秒数
#define MemerayMaxSize      (20*1024*1024)
#define DiskMaxSize         (50*1024*1024)

static CacheData *cache_data = nil;
static dispatch_once_t onceToken;

@implementation CacheData {
    NSString *path;
    NSURLCache *cache;
}

+ (instancetype)shareCacheData
{
    dispatch_once(&onceToken, ^{
        cache_data = [[CacheData alloc] init];
    });
    return cache_data;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSString *cachePatch = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
        path = [cachePatch stringByAppendingPathComponent:@"/CacheData/"];
        cache = [[NSURLCache alloc] initWithMemoryCapacity:MemerayMaxSize diskCapacity:DiskMaxSize diskPath:path];
    }
    return self;
}

- (BOOL)cacheWithURLResponse:(NSURLResponse *)response
                ResponseData:(NSData *)data
             SessionDataTask:(NSURLSessionDataTask *)task
{
    NSCachedURLResponse *cache_response = [[NSCachedURLResponse alloc] initWithResponse:response data:data userInfo:nil storagePolicy:NSURLCacheStorageAllowed];
    [cache storeCachedResponse:cache_response forDataTask:task];
    return YES;
}

- (void)readCacheWithTask:(NSURLSessionDataTask *)task
               completion:(void (^)(NSData *data))handler
{
    [cache getCachedResponseForDataTask:task completionHandler:^(NSCachedURLResponse * _Nullable cachedResponse) {
        handler(cachedResponse.data);
    }];
}

- (NSData *)readCacheWithKey:(NSString *)key
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error = [NSError errorWithDomain:@"SEARCHPATH" code:400 userInfo:nil];
    NSArray *path_array = [fileManager contentsOfDirectoryAtPath:path error:&error];
    NSString *rename_key = [key stringByReplacingOccurrencesOfString:@"/" withString:@""];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS '%@'", rename_key];
    NSArray *array = [path_array filteredArrayUsingPredicate:predicate];
    if (array.count > 0) {
        NSString *path_name = [array lastObject];
        NSString *date_str = [[path_name componentsSeparatedByString:@"_"] lastObject];
        NSTimeInterval times = [NSDate secFromLotteryDate:[NSDate dateWithTimeIntervalSince1970:[date_str doubleValue]] CurrentDate:[NSDate date]];
        if (EXPIRE_TIME > times) {
            return [NSData dataWithContentsOfURL:[NSURL fileURLWithPath:[NSString stringWithFormat:@"%@%@", path, path_name]]];
        } else {
            FLog(@"缓存数据已过期");
        }
    } else {
        FLog(@"不存在缓存文件");
    }
    return nil;
}

/**
 *  清理缓存
 */
- (void)cleanCache:(cleanCacheBlock)block
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //文件路径
        NSString *directoryPath=[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
        
        NSArray *subpaths = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:directoryPath error:nil];
        
        for (NSString *subPath in subpaths) {
            NSString *filePath = [directoryPath stringByAppendingPathComponent:subPath];
            [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
        }
        //返回主线程
        dispatch_async(dispatch_get_main_queue(), ^{
            block();
        });
    });
    
}
/**
 *  计算整个目录大小
 */
- (float)folderSizeAtPath
{
    NSString *folderPath=[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    
    NSFileManager * manager = [NSFileManager defaultManager ];
    if (![manager fileExistsAtPath :folderPath]) {
        return 0 ;
    }
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath :folderPath] objectEnumerator ];
    NSString * fileName;
    long long folderSize = 0 ;
    while ((fileName = [childFilesEnumerator nextObject ]) != nil ){
        NSString * fileAbsolutePath = [folderPath stringByAppendingPathComponent :fileName];
        folderSize += [self fileSizeAtPath :fileAbsolutePath];
    }
    
    return folderSize /( 1024.0 * 1024.0 );
}
/**
 *  计算单个文件大小
 */
- (long long)fileSizeAtPath:(NSString *)filePath
{
    
    NSFileManager *manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath :filePath]){
        
        return [[manager attributesOfItemAtPath :filePath error : nil ] fileSize];
    }
    return 0 ;
    
}


@end
