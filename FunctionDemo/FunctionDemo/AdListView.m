//
//  AdListView.m
//  FunctionDemo
//
//  Created by chaziyjs on 2018/6/26.
//  Copyright © 2018年 chaziyjs. All rights reserved.
//

#import "AdListView.h"

@implementation AdListView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
    }
    return self;
}

#pragma mark - delegate
- (void)homeScrollAdViewDidSelectedCell:(NSIndexPath *)indexpath
{
    FLog(@"select index = %@", indexpath);
}

- (void)homeScrollAdAnimationShowCompleted
{
    [self reloadData];
}

#pragma mark - datasource
- (NSInteger)numberOfRowInHomeScrollAdView:(HomeScrollAdView *)scrollAdView
{
    return 5;
}

- (CGSize)sizeForEachRowInHomeScrollAdView:(HomeScrollAdView *)scrollAdView AtIndex:(NSIndexPath *)indexpath
{
    return CGSizeMake(200.f, 44.f);
}

- (__kindof HomeScrollAdCell *)homeScrollView:(HomeScrollAdView *)scrollView cellForRowAtIndexPath:(NSIndexPath *)indexpath
{
    HomeScrollAdCell *cell = [HomeScrollAdCell new];
    cell.contentView.backgroundColor = [UIColor redColor];
    return cell;
}

@end
