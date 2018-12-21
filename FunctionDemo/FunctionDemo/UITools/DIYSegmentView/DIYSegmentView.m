//
//  DIYSegmentView.m
//  GeekRabbit
//
//  Created by FoxDog on 2018/10/22.
//  Copyright © 2018 FoxDog. All rights reserved.
//

#import "DIYSegmentView.h"

@implementation DIYSegmentView
{
    NSMutableArray *segment_title_array;
    @private NSMutableArray<__kindof UIButton *> *segment_titleView_array;
    UIView *segment_line;
    UIScrollView *segment_scroll;
    UIScrollView *segment_content_scroll;
    @private NSUInteger lastSelected;
    UIView *bottom_line;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _SegmentHeight = 44.f;
        _padding = 5.f;
        
        _titleStyle = DIYSegmentTitleStyleWithRegularSize;
        _segment_line_color = kColorThemeGreen;
        _titleFont = BOLDTEXTFONT(15.f);
        _titleSelectedColor = kColorThemeGreen;
        _titleNormalColor = kColorTitleBlack;
        
        segment_title_array = [NSMutableArray array];
        _segment_contentView_array = [NSMutableArray array];
        segment_titleView_array = [NSMutableArray array];
        
        segment_scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(frame), _SegmentHeight)];
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
        
        segment_content_scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, _SegmentHeight + _padding, CGRectGetWidth(frame), CGRectGetHeight(frame) - _SegmentHeight - _padding)];
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
        
        bottom_line = [[UIView alloc] initWithFrame:CGRectMake(0, _SegmentHeight + 0.5, CGRectGetWidth(frame), 0.5)];
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
    [self resetSubViewSize];
    [segment_scroll setContentInset:UIEdgeInsetsZero];
    [segment_content_scroll setContentInset:UIEdgeInsetsZero];
    if (_segment_contentView_array && segment_title_array && _segment_contentView_array.count == segment_title_array.count) {
        [self createTitleSegmentView];
        [self createContentView];
    } else {
        NSAssert(_segment_contentView_array.count == segment_title_array.count, @"标题数据数量与内容视图数量不等");
    }
    [segment_scroll bringSubviewToFront:segment_line];
    [segment_scroll setContentOffset:CGPointMake(0, 0)];
    bottom_line.frame = CGRectMake(0, _SegmentHeight + 0.5, CGRectGetWidth(self.frame), 0.5);
}

#pragma mark - 显示分割线
- (void)showBottomLine:(BOOL)show
{
    bottom_line.hidden = !show;
}

#pragma mark - SIYSegmentView相关参数设置
/**
 设置segment标题高度

 @param SegmentHeight 高度(默认:44.f)
 */
- (void)setSegmentHeight:(CGFloat)SegmentHeight
{
    if (SegmentHeight != _SegmentHeight) {
        _SegmentHeight = SegmentHeight;
        [self resetSubViewSize];
    }
}

/**
 设置标题组件与列表组件的间距

 @param padding 间距宽度(默认:5.f)
 */
- (void)setPadding:(CGFloat)padding
{
    if (padding != _padding) {
        _padding = padding;
        [self createContentView];
    }
}

/**
 设置标题字体与字号

 @param titleFont 设置新字体(默认字体:BOLDTEXTFONT(15.f))
 */
- (void)setTitleFont:(UIFont *)titleFont
{
    if (titleFont) {
        _titleFont = titleFont;
        if (segment_titleView_array.count > 0) {
            __weak typeof(UIFont *) weak_font = titleFont;
            [segment_titleView_array enumerateObjectsUsingBlock:^(__kindof UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                obj.titleLabel.font = weak_font;
            }];
        }
    }
}

/**
 设置segment标题的显示样式

 @param titleStyle 标题样式枚举(默认:DIYSegmentTitleStyleWithRegularSize)
 */
- (void)setTitleStyle:(DIYSegmentTitleStyle)titleStyle
{
    if (_titleStyle != titleStyle) {
        _titleStyle = titleStyle;
        [self resetSubViewSize];
    }
}

/**
 设置segment标题的下划线颜色

 @param segment_line_color 下划线颜色(默认:kColorThemeGreen)
 */
- (void)setSegment_line_color:(UIColor *)segment_line_color
{
    if (segment_line_color) {
        _segment_line_color = segment_line_color;
        segment_line.backgroundColor = segment_line_color;
    }
}

/**
 设置标题一般显示下的颜色

 @param titleNormalColor Normal状态下的颜色值(默认:kColorThemeGreen)
 */
- (void)setTitleNormalColor:(UIColor *)titleNormalColor
{
    if (titleNormalColor) {
        _titleNormalColor = titleNormalColor;
        if (segment_titleView_array.count > 0) {
            __weak typeof(UIColor *) weak_color = titleNormalColor;
            [segment_titleView_array enumerateObjectsUsingBlock:^(__kindof UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [obj setTitleColor:weak_color forState:UIControlStateNormal];
            }];
        }
    }
}

/**
 设置标题选择情况下的颜色

 @param titleSelectedColor Selected状态下的颜色(默认:kColorTitleBlack)
 */
- (void)setTitleSelectedColor:(UIColor *)titleSelectedColor
{
    if (titleSelectedColor) {
        _titleSelectedColor = titleSelectedColor;
        if (segment_titleView_array.count > 0) {
            __weak typeof(UIColor *) weak_color = titleSelectedColor;
            [segment_titleView_array enumerateObjectsUsingBlock:^(__kindof UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [obj setTitleColor:weak_color forState:UIControlStateSelected];
            }];
        }
    }
}

- (void)setSegment_line_width:(CGFloat)segment_line_width
{
    _segment_line_width = segment_line_width;
}

#pragma mark - 修改全部子视图的尺寸
- (void)resetSubViewSize
{
    [segment_scroll setWidth:CGRectGetWidth(self.frame)];
    [segment_scroll setHeight:_SegmentHeight];
    [segment_content_scroll setFrame:CGRectMake(0, _SegmentHeight, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame) - _SegmentHeight)];
    bottom_line.frame = CGRectMake(0, _SegmentHeight - 0.5, CGRectGetWidth(self.frame), 0.5);
    if (_segment_contentView_array && segment_title_array && _segment_contentView_array.count == segment_title_array.count) {
        [self createTitleSegmentView];
        [self createContentView];
    }
}

#pragma mark - 重设set方法
- (void)setDatasource:(id<DIYSegmentViewDataSource>)datasource
{
    _datasource = datasource;
    if ([_datasource respondsToSelector:@selector(DIYSegmentViewTitles)]) {
        lastSelected = 0;
        NSArray *titleStringArray = [_datasource DIYSegmentViewTitles];
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
    if ([_datasource respondsToSelector:@selector(DIYSegmentViewContentViews)]) {
        NSArray *contentViewArray = [_datasource DIYSegmentViewContentViews];
        if (contentViewArray && contentViewArray.count > 0) {
            _segment_contentView_array = [NSMutableArray arrayWithArray:contentViewArray];
            segment_content_scroll.contentSize = CGSizeMake(CGRectGetWidth(self.frame) * contentViewArray.count, CGRectGetHeight(segment_content_scroll.bounds));
        }
    }
}

#pragma mark - 顶部按钮页面
- (void)createTitleSegmentView
{
    if (segment_title_array.count > 0) {
        [segment_scroll removeAllSubviews];
        CGFloat lineWith = 0.f;
        [segment_titleView_array removeAllObjects];
        for (int i = 0; i < segment_title_array.count; i ++) {
            NSString *titleStr = segment_title_array[i];
            CGRect btn_frame = CGRectZero;
            if (_titleStyle == DIYSegmentTitleStyleWithAutosizeContent) {
                CGFloat titleWidth = [NSString widthOfStr:titleStr font:_titleFont height:CGRectGetHeight(segment_scroll.frame)] + 24.f;
                if (i == 0) {
                    lineWith = titleWidth - 24.f;
                    btn_frame = CGRectMake(0, 0, titleWidth, CGRectGetHeight(segment_scroll.frame));
                } else {
                    UIButton *last_btn = (UIButton *)[segment_scroll viewWithTag:(12305 + i)];
                    btn_frame = CGRectMake(CGRectGetMaxX(last_btn.frame), 0, titleWidth, CGRectGetHeight(segment_scroll.frame));
                }
                if (i == segment_title_array.count - 1) {
                    segment_scroll.contentSize = CGSizeMake(CGRectGetMaxX(btn_frame), CGRectGetHeight(segment_scroll.bounds));
                }
            } else {
                btn_frame = CGRectMake(segment_title_array.count >= 3 ? (CGRectGetWidth(self.frame) / 3 * i) : (CGRectGetWidth(self.frame) / segment_title_array.count * i), 0, segment_title_array.count >= 3 ? CGRectGetWidth(self.frame) / 3 : CGRectGetWidth(self.frame) / segment_title_array.count, CGRectGetHeight(segment_scroll.frame));
            }            
            UIButton *segment_btn = [[UIButton alloc] initWithFrame:btn_frame];
            segment_btn.titleLabel.font = _titleFont;
            [segment_btn setTitle:titleStr forState:UIControlStateNormal];
            [segment_btn setTitleColor:_titleSelectedColor forState:UIControlStateSelected];
            [segment_btn setTitleColor:_titleNormalColor forState:UIControlStateNormal];
            [segment_btn addTarget:self action:@selector(segmentChangeAction:) forControlEvents:UIControlEventTouchUpInside];
            segment_btn.tag = 12306 + i;
            segment_btn.timeInterval = 1.5;
            [segment_scroll addSubview:segment_btn];
            kWeakSelf(segment_btn);
            [segment_titleView_array addObject:weaksegment_btn];
            if (i == 0) {
                segment_btn.selected = YES;
            } else {
                segment_btn.selected = NO;
            }
        }
        if (_titleStyle == DIYSegmentTitleStyleWithAutosizeContent) {
            segment_line = [[UIView alloc] initWithFrame:CGRectMake(12.f, CGRectGetHeight(segment_scroll.frame) - 2.f, lineWith, 2.f)];
        } else {
            CGFloat line_width = segment_title_array.count >= 3 ? CGRectGetWidth(self.frame) / 3 * SIZE_RATIO : CGRectGetWidth(self.frame) / segment_title_array.count * SIZE_RATIO;
            if (_segment_line_width > 0.f) {
                line_width = _segment_line_width;
            }
            segment_line = [[UIView alloc] initWithFrame:CGRectMake(((segment_title_array.count >= 3 ? CGRectGetWidth(self.frame) / 3 : CGRectGetWidth(self.frame) / segment_title_array.count) - line_width) * 0.5, CGRectGetHeight(segment_scroll.frame) - 2.f, line_width, 2.f)];
        }
        segment_line.backgroundColor = _segment_line_color;
        [segment_line drawRoundRectInContextWithRadius:1.f corners:UIRectCornerAllCorners LineWidth:0.f LineColor:NULL];
        [segment_scroll addSubview:segment_line];
        [segment_scroll bringSubviewToFront:segment_line];
        segment_line.hidden = !(segment_title_array.count > 0);
    }
}

#pragma mark - 底部滑动内容部分
- (void)createContentView
{
    if (_segment_contentView_array.count > 0) {
        segment_content_scroll.contentSize = CGSizeMake(CGRectGetWidth(self.frame) * _segment_contentView_array.count, CGRectGetHeight(self.frame) - _padding - _SegmentHeight);
        [segment_content_scroll removeAllSubviews];
        for (int i = 0; i < _segment_contentView_array.count; i ++) {
            UIView *subContentView = [_segment_contentView_array objectAtIndex:i];
            subContentView.frame = CGRectMake(i * CGRectGetWidth(self.frame), _padding, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame) - _padding - _SegmentHeight);
            [segment_content_scroll addSubview:subContentView];
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
    if (_delegate && [_delegate respondsToSelector:@selector(DIYSegmentViewWillAppearViewAtIndex:)]) {
        [_delegate DIYSegmentViewWillAppearViewAtIndex:select_tag];
    }
    UIButton *lastSelect_btn = [self viewWithTag:lastSelected + 12306];
    UIButton *sender = [self viewWithTag:select_tag + 12306];
    lastSelect_btn.selected = NO;
    sender.selected = YES;
    lastSelected = select_tag;
    _currentPage = select_tag;
    __weak typeof(UIView *) weak_line = segment_line;
    __weak typeof(UIButton *) weak_btn = sender;
    __block typeof(DIYSegmentTitleStyle) weak_style = _titleStyle;
    [UIView animateWithDuration:0.25 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:0.7 options:UIViewAnimationOptionCurveLinear animations:^{
        if (weak_style == DIYSegmentTitleStyleWithAutosizeContent) {
            weak_line.bounds = CGRectMake(0, 0, CGRectGetWidth(weak_btn.bounds) - 24.f, 2.f);
            [weak_line drawRoundRectInContextWithRadius:1.f corners:UIRectCornerAllCorners LineWidth:0.f LineColor:NULL];
        }
        weak_line.center = CGPointMake(weak_btn.centerX, weak_line.centerY);
    } completion:^(BOOL finished) {
        [weak_line drawRoundRectInContextWithRadius:1.f corners:UIRectCornerAllCorners LineWidth:0.f LineColor:NULL];
    }];
    //执行代理方法
    if (_delegate && [_delegate respondsToSelector:@selector(DIYSegmentViewDidSelectedAtIndex:)]) {
        [_delegate DIYSegmentViewDidSelectedAtIndex:select_tag];
    }
    //执行滚动动画
    if (_titleStyle == DIYSegmentTitleStyleWithAutosizeContent) {
        CGFloat center_point = sender.centerX;
        /*
         可滚动的范围区间 -> [CGRectGetWidth(self.frame) * 0.5, segment_scroll.contentSize.width - CGRectGetWidth(self.frame) * 0.5]
         */
        if (center_point > CGRectGetWidth(segment_scroll.bounds) * 0.5 && CGRectGetMidX(sender.frame) < segment_scroll.contentSize.width - CGRectGetWidth(segment_scroll.bounds) * 0.5) {
            CGFloat moveX = center_point - CGRectGetWidth(segment_scroll.bounds) * 0.5;
            [segment_scroll setContentOffset:CGPointMake(moveX, 0)  animated:YES];
        } else {
            if (center_point <= CGRectGetWidth(segment_scroll.bounds) * 0.5) {
                [segment_scroll setContentOffset:CGPointMake(0, 0)  animated:YES];
            } else {
                if (segment_scroll.contentSize.width > CGRectGetWidth(segment_scroll.bounds)) {
                    [segment_scroll setContentOffset:CGPointMake(segment_scroll.contentSize.width - CGRectGetWidth(segment_scroll.bounds), 0)  animated:YES];
                } 
            }
        }
    } else {
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
    }
    if (withMove && select_tag < _segment_contentView_array.count) {
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
    [_segment_contentView_array removeAllObjects];
    [segment_titleView_array removeAllObjects];
    segment_content_scroll.delegate = nil;
    FLog(@"%@ dealloc", [self className]);
}

@end
