//
//  PreviewVc.m
//  TYSnapshotScroll
//
//  Created by TonyReet on 2017/11/24.
//  Copyright © 2017年 TonyReet. All rights reserved.
//

#import "PreviewVc.h"

@interface PreviewVc ()

@property (nonatomic,strong) UIScrollView *scrollView;

@property (nonatomic,strong) UIImageView *imageView;

@property (nonatomic,strong) UIImage *image;

@end

@implementation PreviewVc


- (instancetype)init:(UIImage *)image
{
    self = [super init]; //用于初始化父类
    if (self) {
        self.image = image;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initView];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveImage)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"放弃" style:UIBarButtonItemStylePlain target:self action:@selector(dismissViewControllerAnimated)];
}

- (void)initView{
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.imageView = [UIImageView new];
    self.imageView.image = self.image;
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    self.scrollView = [UIScrollView new];
    [self.scrollView addSubview:self.imageView];
    
    [self.view addSubview:self.scrollView];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    CGFloat height =  self.image.size.height;
    CGFloat width =  self.image.size.width;
    self.scrollView.frame = self.view.bounds;
    self.scrollView.contentSize = CGSizeMake(width, height);
    self.imageView.frame = CGRectMake(0, 0, width, height);
}

- (void)saveImage{
    //save to photosAlbum
    kWeakSelf(self);
    if ([PHPhotoLibrary authorizationStatus] == PHAuthorizationStatusAuthorized && self.image) {
        [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
            //写入图片到相册
            [PHAssetChangeRequest creationRequestForAssetFromImage:weakself.image];
        } completionHandler:^(BOOL success, NSError * _Nullable error) {
            NSString *barItemTitle = @"";
            if (success) {
                barItemTitle = @"保存成功";
            } else {
                barItemTitle = @"保存失败";
            }
            [weakself.navigationItem.rightBarButtonItem setTitle:barItemTitle];
            [weakself dismissViewControllerAnimated];
            NSLog(@"success = %d, error = %@", success, error);
        }];
    } else if ([PHPhotoLibrary authorizationStatus] == PHAuthorizationStatusNotDetermined) {
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            if (status == PHAuthorizationStatusAuthorized) {
                [weakself saveImage];
            } else {
                [weakself.navigationItem.rightBarButtonItem setTitle:@"保存失败"];
            }
        }];
    }
}

- (void)dismissViewControllerAnimated{
      [self dismissViewControllerAnimated:YES completion:nil];
}

@end
