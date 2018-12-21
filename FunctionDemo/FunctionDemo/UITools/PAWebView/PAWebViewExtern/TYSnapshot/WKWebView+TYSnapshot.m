//
//  WKWebView+TYSnapshot.m
//  TYSnapshotScroll
//
//  Created by apple on 16/12/28.
//  Copyright © 2016年 TonyReet. All rights reserved.
//

#import "WKWebView+TYSnapshot.h"

@implementation WKWebView (TYSnapshot)

- (void )screenSnapshot:(void(^)(UIImage *snapShotImage))finishBlock{
    //添加遮盖
    UIView *snapShotView = [self snapshotViewAfterScreenUpdates:YES];
    snapShotView.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, snapShotView.frame.size.width, snapShotView.frame.size.height);
    [self.superview addSubview:snapShotView];

    
    //保存原始信息
    CGRect oldFrame = self.frame;
    CGPoint oldOffset = self.scrollView.contentOffset;
    CGSize contentSize = self.scrollView.contentSize;
    
    //计算快照屏幕数
    NSUInteger snapshotScreenCount = floorf(contentSize.height / self.scrollView.bounds.size.height);
    
    //设置frame为contentSize
    self.frame = CGRectMake(0, 0, contentSize.width, contentSize.height);

    self.scrollView.contentOffset = CGPointZero;
    
    UIGraphicsBeginImageContextWithOptions(contentSize, NO, [UIScreen mainScreen].scale);
    
    __weak typeof(self) weakSelf = self;
    //截取完所有图片
    [self scrollToDraw:0 maxIndex:(NSInteger )snapshotScreenCount finishBlock:^{
        [snapShotView removeFromSuperview];
        
        UIImage *snapshotImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        weakSelf.frame = oldFrame;
        weakSelf.scrollView.contentOffset = oldOffset;
        
        if (finishBlock) {
            finishBlock(snapshotImage);
        }
    }];
}

//滑动画了再截图
- (void )scrollToDraw:(NSInteger )index maxIndex:(NSInteger )maxIndex finishBlock:(void(^)())finishBlock{
    UIView *superView = self.superview;
    
    //截取的frame
    CGRect snapshotFrame = CGRectMake(0, (float)index * superView.bounds.size.height, superView.bounds.size.width, superView.bounds.size.height);

    // set up webview originY
    CGRect myFrame = self.frame;
    myFrame.origin.y = -((index) * superView.frame.size.height);
    self.frame = myFrame;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(300 * NSEC_PER_MSEC)), dispatch_get_main_queue(), ^{
        
        [superView drawViewHierarchyInRect:snapshotFrame afterScreenUpdates:YES];
        
        if(index < maxIndex){
            [self scrollToDraw:index + 1 maxIndex:maxIndex finishBlock:finishBlock];
        }else{
            if (finishBlock) {
                finishBlock();
            }
        }
    });
}

@end
