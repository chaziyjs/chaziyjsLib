//
//  MyGiftSegmentView.h
//  AnywideConvenience
//
//  Created by chaziyjs on 2018/7/23.
//  Copyright © 2018年 Anywide1948. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+Corner.h"

#define SIZE_RATIO      (0.576)

@protocol MyGiftSegmentViewDataSource <NSObject>

@required
- (NSArray <__kindof NSString *> *)MyGiftSegmentViewTitles;
- (NSArray <__kindof UIView *> *)MyGiftSegmentViewContentViews;

@end

@protocol MyGiftSegmentViewDelegate <NSObject>

@optional
- (void)MyGiftSegmentViewWillAppearViewAtIndex:(NSUInteger)index;
- (void)MyGiftSegmentViewDidSelectedAtIndex:(NSUInteger)index;

@end

@interface MyGiftSegmentView : UIView<UIScrollViewDelegate>

@property (nonatomic, assign) CGFloat SegmentHeight;
@property (nonatomic, strong) UIFont *titleFont;
@property (nonatomic, assign) CGFloat padding;

@property (nonatomic, assign) NSUInteger currentPage;
@property (nonatomic, weak) id<MyGiftSegmentViewDataSource> datasource;
@property (nonatomic, weak) id<MyGiftSegmentViewDelegate> delegate;

- (void)showBottomLine:(BOOL)show;

@end

