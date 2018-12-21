//
//  DIYSegmentView.h
//  GeekRabbit
//
//  Created by FoxDog on 2018/10/22.
//  Copyright © 2018 FoxDog. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#define SIZE_RATIO      (0.576)

@protocol DIYSegmentViewDataSource <NSObject>

@required
- (NSArray <__kindof NSString *> *)DIYSegmentViewTitles;
- (NSArray <__kindof UIView *> *)DIYSegmentViewContentViews;

@end

@protocol DIYSegmentViewDelegate <NSObject>

@optional
- (void)DIYSegmentViewWillAppearViewAtIndex:(NSUInteger)index;
- (void)DIYSegmentViewDidSelectedAtIndex:(NSUInteger)index;

@end

typedef NS_ENUM(NSUInteger, DIYSegmentTitleStyle)
{
    DIYSegmentTitleStyleWithAutosizeContent,
    DIYSegmentTitleStyleWithRegularSize
};

@interface DIYSegmentView : UIView<UIScrollViewDelegate>


/**
    参数配置信息
 */
@property (nonatomic, assign) DIYSegmentTitleStyle titleStyle; //标题样式
@property (nonatomic, assign) CGFloat SegmentHeight;
@property (nonatomic, strong) UIFont *titleFont;
@property (nonatomic, assign) CGFloat padding;
@property (nonatomic, strong) UIColor *segment_line_color;
@property (nonatomic, strong) UIColor *titleNormalColor;
@property (nonatomic, strong) UIColor *titleSelectedColor;
@property (nonatomic, assign) CGFloat segment_line_width;

@property (nonatomic, assign, readonly) NSUInteger currentPage;
@property (nonatomic, strong) NSMutableArray *segment_contentView_array;

@property (nonatomic, weak) id<DIYSegmentViewDataSource> datasource;
@property (nonatomic, weak) id<DIYSegmentViewDelegate> delegate;

- (void)showBottomLine:(BOOL)show;

@end

NS_ASSUME_NONNULL_END
