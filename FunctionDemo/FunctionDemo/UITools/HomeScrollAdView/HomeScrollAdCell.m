//
//  HomeScrollAdCell.m
//  WetalkCommunity
//
//  Created by chaziyjs on 2018/6/25.
//  Copyright © 2018年 chaziyjs. All rights reserved.
//

#import "HomeScrollAdCell.h"

@implementation HomeScrollAdCell

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.userInteractionEnabled = YES;
        [self addSubview:self.contentView];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _contentView.frame = self.bounds;
}

#pragma mark - lazy load
- (UIView *)contentView
{
    if (_contentView == nil) {
        _contentView = [UIView new];
        _contentView.userInteractionEnabled = YES;
    }
    return _contentView;
}

@end
