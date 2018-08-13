//
//  HomeScrollAdView.h
//  WetalkCommunity
//
//  Created by chaziyjs on 2018/6/25.
//  Copyright © 2018年 chaziyjs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeScrollAdCell.h"

@class HomeScrollAdView;
@protocol HomeScrollAdViewDelegate <NSObject>

- (void)homeScrollAdViewDidSelectedCell:(NSIndexPath *)indexpath;
- (void)homeScrollAdAnimationShowCompleted;

@end

@protocol HomeScrollAdViewDataSource <NSObject>

- (NSInteger)numberOfRowInHomeScrollAdView:(HomeScrollAdView *)scrollAdView;
- (CGSize)sizeForEachRowInHomeScrollAdView:(HomeScrollAdView *)scrollAdView AtIndex:(NSIndexPath *)indexpath;
- (__kindof HomeScrollAdCell *)homeScrollView:(HomeScrollAdView *)scrollView cellForRowAtIndexPath:(NSIndexPath *)indexpath;

@end

@interface HomeScrollAdView : UIView

@property (nonatomic, weak) id<HomeScrollAdViewDelegate> delegate;
@property (nonatomic, weak) id<HomeScrollAdViewDataSource> dataSource;

@property (nonatomic, assign) NSTimeInterval inoutTime;
@property (nonatomic, assign) NSTimeInterval waitTime;

- (void)reloadData;

- (HomeScrollAdCell *)homeScrollAdCellForIndexPath:(NSIndexPath *)indexpath;

- (NSUInteger)indexForHomeScrollAdCell:(HomeScrollAdCell *)cell;

@end
