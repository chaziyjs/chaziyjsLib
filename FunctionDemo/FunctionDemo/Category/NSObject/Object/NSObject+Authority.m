//
//  NSObject+Authority.m
//  FunctionDemo
//
//  Created by chaziyjs on 2018/7/6.
//  Copyright © 2018年 chaziyjs. All rights reserved.
//

#import "NSObject+Authority.h"

@implementation NSObject (Authority)

- (void)getAssetLibraryAuthoritySuccess:(void (^)(ALAssetsLibrary *assetLibrary))success
                                failure:(void (^)(void))failure
{
    PHAuthorizationStatus authStatus = [PHPhotoLibrary authorizationStatus];
    if (authStatus == PHAuthorizationStatusNotDetermined || authStatus == PHAuthorizationStatusDenied) {
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            if (status == PHAuthorizationStatusDenied) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    failure();
                });
            } else {
                dispatch_async(dispatch_get_main_queue(), ^{
                    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
                    success(library);
                });
            }
        }];
    }
}

@end
