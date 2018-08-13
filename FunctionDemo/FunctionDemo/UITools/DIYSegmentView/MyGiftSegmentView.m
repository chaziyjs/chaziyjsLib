//
//  MyGiftSegmentView.m
//  AnywideConvenience
//
//  Created by chaziyjs on 2018/7/23.
//  Copyright © 2018年 Anywide1948. All rights reserved.
//

#import "MyGiftSegmentView.h"

@implementation MyGiftSegmentView {
    NSMutableArray *segment_title_array;
    NSMutableArray *segment_contentView_array;
    UIView *segment_line;
    UIScrollView *segment_scroll;
    UIScrollView *segment_content_scroll;
    NSUInteger lastSelected;
    UIView *bottom_line;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.SegmentHeight = 44.f;
        self.padding = 5.f;
        
        segment_title_array = [NSMutableArray array];
        segment_contentView_array = [NSMutableArray array];
        
        segment_scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(frame), _SegmentHeight - 0.5)];
        segment_scroll.backgroundColor = [UIColor whiteColor];
        segment_scroll.showsVerticalScrollIndicator = NO;
        segment_scroll.showsHorizontalScrollIndicator = NO;
        segment_scroll.bounces = NO;
        [self addSubview:segment_scroll];
        if (@available(iOS 11.0, *)) {
            segment_scroll.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAutomatic;
        } else {
            // Fallback on earlier versions
        }
        
        segment_content_scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, _SegmentHeight, CGRectGetWidth(frame), CGRectGetHeight(frame) - _SegmentHeight)];
        segment_content_scroll.showsHorizontalScrollIndicator = NO;
        segment_content_scroll.showsVerticalScrollIndicator = NO;
        segment_content_scroll.pagingEnabled = YES;
        segment_content_scroll.delegate = self;
        segment_content_scroll.backgroundColor = kColorBGLightGray;
        [self addSubview:segment_content_scroll];
        if (@available(iOS 11.0, *)) {
            segment_content_scroll.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAutomatic;
        } else {
            // Fallback on earlier versions
        }
        
        bottom_line = [[UIView alloc] initWithFrame:CGRectMake(0, _SegmentHeight - 0.5, CGRectGetWidth(frame), 0.5)];
        bottom_line.backgroundColor = kColorTextGray;
        bottom_line.hidden = YES;
        [self addSubview:bottom_line];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    FLog(@"frame change = %@", NSStringFromCGRect(self.frame));
    [segment_scroll setContentInset:UIEdgeInsetsZero];
    [segment_content_scroll setContentInset:UIEdgeInsetsZero];
    if (segment_contentView_array && segment_title_array && segment_contentView_array.count == segment_title_array.count) {
        [self createTitleSegmentView];
        [self createContentView];
    } else {
        NSAssert(segment_contentView_array.count == segment_title_array.count, @"标题数据数量与内容视图数量不等");
    }
    [segment_scroll bringSubviewToFront:segment_line];
    [segment_scroll setContentOffset:CGPointMake(0, 0)];
    bottom_line.frame = CGRectMake(0, _SegmentHeight - 0.5, CGRectGetWidth(self.frame), 0.5);
}

#pragma mark - 显示分割线
- (void)showBottomLine:(BOOL)show
{
    bottom_line.hidden = !show;
}

#pragma mark - 重设Segment高度
- (void)setSegmentHeight:(CGFloat)SegmentHeight
{
    if (SegmentHeight != _SegmentHeight) {
        _SegmentHeight = SegmentHeight;
        [self resetSubViewSize];
    }
}

- (void)setPadding:(CGFloat)padding
{
    if (padding != _padding) {
        _padding = padding;
        [self createContentView];
    }
}

#pragma mark - 修改全部子视图的尺寸
- (void)resetSubViewSize
{
    [segment_scroll setHeight:_SegmentHeight - 0.5];
    [segment_content_scroll setFrame:CGRectMake(0, _SegmentHeight, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame) - _SegmentHeight)];
    bottom_line.frame = CGRectMake(0, _SegmentHeight - 0.5, CGRectGetWidth(self.frame), 0.5);
    if (segment_contentView_array && segment_title_array && segment_contentView_array.count == segment_title_array.count) {
        [self createTitleSegmentView];
        [self createContentView];
    }
}

#pragma mark - 重设set方法
- (void)setDatasource:(id<MyGiftSegmentViewDataSource>)datasource
{
    _datasource = datasource;
    if ([_datasource respondsToSelector:@selector(MyGiftSegmentViewTitles)]) {
        lastSelected = 0;
        NSArray *titleStringArray = [_datasource MyGiftSegmentViewTitles];
        if (titleStringArray && titleStringArray.count > 0) {
            segment_title_array = [NSMutableArray arrayWithArray:titleStringArray];
            segment_scroll.contentSize = CGSizeMake(CGRectGetWidth(self.frame) / 3 * titleStringArray.count, CGRectGetHeight(segment_scroll.bounds));
            segment_line.hidden = NO;
        } else {
            segment_line.hidden = YES;
        }
    } else {
        segment_line.hidden = YES;
    }
    
    if ([_datasource respondsToSelector:@selector(MyGiftSegmentViewContentViews)]) {
        NSArray *contentViewArray = [_datasource MyGiftSegmentViewContentViews];
        if (contentViewArray && contentViewArray.count > 0) {
            segment_contentView_array = [NSMutableArray arrayWithArray:contentViewArray];
            segment_content_scroll.contentSize = CGSizeMake(CGRectGetWidth(self.frame) * contentViewArray.count, CGRectGetHeight(segment_content_scroll.bounds));
        }
    }
}

#pragma mark - 顶部按钮页面
- (void)createTitleSegmentView
{
    if (segment_title_array.count > 0) {
        [segment_scroll removeAllSubviews];
        for (int i = 0; i < segment_title_array.count; i ++) {
            NSString *titleStr = segment_title_array[i];
            CGRect btn_frame = CGRectMake(segment_title_array.count >= 3 ? (CGRectGetWidth(self.frame) / 3 * i) : (CGRectGetWidth(self.frame) / segment_title_array.count * i), 0, segment_title_array.count >= 3 ? CGRectGetWidth(self.frame) / 3 : CGRectGetWidth(self.frame) / segment_title_array.count, CGRectGetHeight(segment_scroll.frame));
            UIButton *segment_btn = [[UIButton alloc] initWithFrame:btn_frame];
            segment_btn.titleLabel.font = BOLDTEXTFONT(15.f);
            [segment_btn setTitle:titleStr forState:UIControlStateNormal];
            [segment_btn setTitleColor:kColorThemeGreen forState:UIControlStateSelected];
            [segment_btn setTitleColor:kColorTitleBlack forState:UIControlStateNormal];
            [segment_btn addTarget:self action:@selector(segmentChangeAction:) forControlEvents:UIControlEventTouchUpInside];
            segment_btn.tag = 12306 + i;
            segment_btn.timeInterval = 1.5;
            [segment_scroll addSubview:segment_btn];
            if (i == 0) {
                segment_btn.selected = YES;
            } else {
                segment_btn.selected = NO;
            }
        }
        CGFloat line_width = segment_title_array.count >= 3 ? CGRectGetWidth(self.frame) / 3 * SIZE_RATIO : CGRectGetWidth(self.frame) / segment_title_array.count * SIZE_RATIO;
        segment_line = [[UIView alloc] initWithFrame:CGRectMake(((segment_title_array.count >= 3 ? CGRectGetWidth(self.frame) / 3 : CGRectGetWidth(self.frame) / segment_title_array.count) - line_width) * 0.5, CGRectGetHeight(segment_scroll.frame) - 2.f, line_width, 2.f)];
        segment_line.backgroundColor = kColorThemeGreen;
        [segment_line drawRoundRectInContextWithRadius:1.f corners:UIRectCornerAllCorners LineWidth:0.f LineColor:nil];
        [segment_scroll addSubview:segment_line];
        [segment_scroll bringSubviewToFront:segment_line];
        segment_line.hidden = !(segment_title_array.count > 0);
    }
}

#pragma mark - 底部滑动内容部分
- (void)createContentView
{
    if (segment_contentView_array.count > 0) {
        [segment_content_scroll removeAllSubviews];
        for (int i = 0; i < segment_contentView_array.count; i ++) {
            UIView *subContentView = segment_contentView_array[i];
            subContentView.frame = CGRectMake(i * CGRectGetWidth(self.frame), _padding, CGRectGetWidth(self.frame), CGRectGetHeight(segment_content_scroll.frame) - _padding);
            [segment_content_scroll addSubview:subContentView];
//            if ([subContentView isKindOfClass:[UITableView class]] || [subContentView isKindOfClass:[UICollectionView class]]) {
//                [subContentView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];
//            }
        }
    }
}

#pragma mark - segment点击事件
- (void)segmentChangeAction:(UIButton *)sender
{
    NSUInteger select_tag = sender.tag - 12306;
    if (select_tag != lastSelected) {
        [self titleFollowAnimation:select_tag ContentMove:YES];
    }
}

#pragma mark - 按钮跟随动画
- (void)titleFollowAnimation:(NSInteger)select_tag ContentMove:(BOOL)withMove
{
    if (_delegate && [_delegate respondsToSelector:@selector(MyGiftSegmentViewWillAppearViewAtIndex:)]) {
        [_delegate MyGiftSegmentViewWillAppearViewAtIndex:select_tag];
    }
    UIButton *lastSelect_btn = [self viewWithTag:lastSelected + 12306];
    UIButton *sender = [self viewWithTag:select_tag + 12306];
    lastSelect_btn.selected = NO;
    sender.selected = YES;
    lastSelected = select_tag;
    __weak typeof(UIView *) weak_line = segment_line;
    __weak typeof(UIButton *) weak_btn = sender;
    [UIView animateWithDuration:0.25 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:0.7 options:UIViewAnimationOptionCurveLinear animations:^{
        weak_line.center = CGPointMake(weak_btn.centerX, weak_line.centerY);
    } completion:^(BOOL finished) {
        
    }];
    //执行代理方法
    if (_delegate && [_delegate respondsToSelector:@selector(MyGiftSegmentViewDidSelectedAtIndex:)]) {
        [_delegate MyGiftSegmentViewDidSelectedAtIndex:select_tag];
    }
    //执行滚动动画
    if (segment_title_array.count >= 4) { //所选按钮定位在中间位置
        if (select_tag == 0) {
            [segment_scroll setContentOffset:CGPointMake(0, 0) animated:YES];
        } else if (select_tag == segment_title_array.count - 1) {
            [segment_scroll setContentOffset:CGPointMake(segment_scroll.contentSize.width - CGRectGetWidth(self.frame), 0) animated:YES];
        } else {
            CGPoint move_x = CGPointMake((select_tag - 1) * CGRectGetWidth(self.frame) / (segment_title_array.count >= 3 ? 3 : segment_title_array.count), 0);
            [segment_scroll setContentOffset:move_x animated:YES];
        }
    }
    if (withMove && select_tag < segment_contentView_array.count) {
        [segment_content_scroll setContentOffset:CGPointMake(select_tag * CGRectGetWidth(self.frame), 0) animated:YES];
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    CGFloat targetX = targetContentOffset->x;
    NSInteger targetPage = (NSInteger)(targetX / CGRectGetWidth(scrollView.frame));
    if (targetPage >= 0 && targetPage < segment_title_array.count) {
        if (targetPage != lastSelected) {
            [self titleFollowAnimation:targetPage ContentMove:NO];
        }
    }
}

#pragma mark - Dealloc
- (void)dealloc
{
    [self removeAllSubviews];
    [segment_title_array removeAllObjects];
    [segment_contentView_array removeAllObjects];
    segment_content_scroll.delegate = nil;
    FLog(@"%@ dealloc", [self className]);
}

@end
