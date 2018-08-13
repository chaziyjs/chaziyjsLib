//
//  HomeScrollAdView.m
//  WetalkCommunity
//
//  Created by chaziyjs on 2018/6/25.
//  Copyright © 2018年 chaziyjs. All rights reserved.
//

#import "HomeScrollAdView.h"

@interface HomeScrollAdView ()

@property (nonatomic, strong) NSMutableArray *cellSizeArray;
@property (nonatomic, strong) NSMutableArray *cellViewArray;

@property (nonatomic, assign) NSInteger cellCount;

@end

@implementation HomeScrollAdView {
    BOOL stop;
    NSUInteger cursor;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        stop = NO;
        cursor = 0;
        _inoutTime = 0.5;
        _waitTime = 2.f;
    }
    return self;
}

- (void)setDataSource:(id<HomeScrollAdViewDataSource>)dataSource
{
    _dataSource = dataSource;
    [self setCellCountValue];
}

#pragma mark - 获取数据源以备显示
- (void)setCellCountValue
{
    kWeakSelf(self);
    if (_dataSource && [_dataSource respondsToSelector:@selector(numberOfRowInHomeScrollAdView:)]) {
        _cellCount = [_dataSource numberOfRowInHomeScrollAdView:weakself];
        [self cellSizeArray];
        [self cellViewArray];
        [self startShowCellsMoveIn];
    }
}

#pragma mark - 初始化数据
- (NSMutableArray *)cellSizeArray
{
    if (_cellCount > 0 && _cellSizeArray.count == 0) {
        if (_dataSource && [_dataSource respondsToSelector:@selector(sizeForEachRowInHomeScrollAdView: AtIndex:)]) {
            kWeakSelf(self);
            _cellSizeArray = [NSMutableArray array];
            for (int i = 0; i < _cellCount; i++) {
                CGSize cell_size = [_dataSource sizeForEachRowInHomeScrollAdView:weakself AtIndex:[NSIndexPath indexPathForRow:i inSection:0]];
                [_cellSizeArray addObject:NSStringFromCGSize(cell_size)];
            }
        }
    }
    return _cellSizeArray;
}

- (NSMutableArray *)cellViewArray
{
    if (_cellCount > 0 && _cellViewArray.count == 0) {
        if (_dataSource && [_dataSource respondsToSelector:@selector(homeScrollView:cellForRowAtIndexPath:)]) {
            kWeakSelf(self);
            _cellViewArray = [NSMutableArray array];
            for (int i = 0; i < _cellCount; i++) {
                HomeScrollAdCell *cellView = [_dataSource homeScrollView:weakself cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
                [_cellViewArray addObject:cellView];
            }
        }
    }
    return _cellViewArray;
}

#pragma mark - 处理动画显示效果
- (void)startShowCellsMoveIn
{
    if (_cellViewArray && _cellViewArray.count > 0 && _cellViewArray.count == _cellSizeArray.count) {
        HomeScrollAdCell *cell = [_cellViewArray objectAtIndex:cursor];
        CGSize cellSize = CGSizeFromString([_cellSizeArray objectAtIndex:cursor]);
        cell.frame = CGRectMake(CGRectGetWidth(self.frame), (CGRectGetHeight(self.frame) - cellSize.height) * 0.5, cellSize.width, cellSize.height);
        UITapGestureRecognizer *tapAction = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapTouchAction:)];
        [cell addGestureRecognizer:tapAction];
        [self addSubview:cell];
        cell.alpha = 0.f;
        __weak typeof(HomeScrollAdCell *) weakCell = cell;
        kWeakSelf(self);
        [UIView animateWithDuration:_inoutTime delay:0.f usingSpringWithDamping:0.7 initialSpringVelocity:0.7 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            weakCell.center = CGPointMake(CGRectGetWidth(weakself.frame) * 0.5, CGRectGetHeight(weakself.frame) * 0.5);
            weakCell.alpha = 1.f;
        } completion:^(BOOL finished) {
            [weakself performSelector:@selector(cellMoveOut:) withObject:weakCell afterDelay:self->_waitTime];
        }];
    }
}

- (void)cellMoveOut:(HomeScrollAdCell *)cell
{
    __weak typeof(HomeScrollAdCell *) weakCell = cell;
    kWeakSelf(self);
    __block typeof(NSUInteger) weak_count = ++cursor;
    __block typeof(BOOL) weak_stop = stop;
    cell.alpha = 1;
    [UIView animateWithDuration:_inoutTime delay:0.f usingSpringWithDamping:0.7 initialSpringVelocity:0.7 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        weakCell.center = CGPointMake(0 - (CGRectGetWidth(weakCell.frame) * 0.5), CGRectGetHeight(weakself.frame) * 0.5);
        weakCell.alpha = 0.f;
    } completion:^(BOOL finished) {
        [weakCell removeFromSuperview];
        if (weak_stop == NO) {
            if (weak_count >= weakself.cellViewArray.count) {
                weak_stop = YES;
                if (weakself.delegate && [weakself.delegate respondsToSelector:@selector(homeScrollAdAnimationShowCompleted)]) {
                    [weakself.delegate homeScrollAdAnimationShowCompleted];
                }
            } else {
                [weakself startShowCellsMoveIn];
            }
        }
    }];
}

#pragma mark - cell点击事件
- (void)tapTouchAction:(UIGestureRecognizer *)tap
{
    HomeScrollAdCell *cell = (HomeScrollAdCell *)tap.view;
    NSUInteger index = [_cellViewArray indexOfObject:cell];
    if (_delegate && [_delegate respondsToSelector:@selector(homeScrollAdViewDidSelectedCell:)]) {
        [_delegate homeScrollAdViewDidSelectedCell:[NSIndexPath indexPathForRow:index inSection:0]];
    }
}

#pragma mark - 刷新方法
- (void)reloadData
{
    //停止当前动画后清理原始内容
    [_cellSizeArray removeAllObjects];
    [_cellViewArray removeAllObjects];
//    [self removeAllSubviews];
    _cellCount = 0;
    stop = NO;
    cursor = 0;
    //清理完成后 重新走代理
    [self setCellCountValue];
}

#pragma mark - 对外接口部分
- (HomeScrollAdCell *)homeScrollAdCellForIndexPath:(NSIndexPath *)indexpath
{
    NSUInteger index = indexpath.row;
    if (index < _cellViewArray.count) {
        return [_cellViewArray objectAtIndex:index];
    } else {
        return nil;
    }
}

- (NSUInteger)indexForHomeScrollAdCell:(HomeScrollAdCell *)cell
{
    if (_cellViewArray.count > 0 && [_cellViewArray containsObject:cell]) {
        return [_cellViewArray indexOfObject:cell];
    } else {
        return NSUIntegerMax;
    }
}

@end
