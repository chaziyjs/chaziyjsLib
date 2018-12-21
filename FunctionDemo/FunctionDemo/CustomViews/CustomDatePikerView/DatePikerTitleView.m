//
//  DatePikerTitleView.m
//  GeekRabbit
//
//  Created by FoxDog on 2018/12/4.
//  Copyright © 2018 FoxDog. All rights reserved.
//

#import "DatePikerTitleView.h"

@implementation DatePikerTitleView {
    UILabel *titleLabel;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
        titleLabel.backgroundColor = [UIColor whiteColor];
        [self addSubview:titleLabel];
        [self addSubview:self.leftBarItem];
        [self addSubview:self.rightBarItem];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    titleLabel.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
    if (_title.length > 0 && _detail.length > 0) {
        NSString *mixTitle = [NSString stringWithFormat:@"%@\n%@", _title, _detail];
        NSMutableParagraphStyle *style = [NSMutableParagraphStyle new];
        style.alignment = NSTextAlignmentCenter;
        NSMutableAttributedString *attributeTitle = [[NSMutableAttributedString alloc] initWithString:mixTitle attributes:@{NSParagraphStyleAttributeName : style}];
        [attributeTitle addAttributes:@{NSFontAttributeName : CUSTOMFONT(15.f), NSForegroundColorAttributeName : kColorTitleBlack} range:NSMakeRange(0, _title.length)];
        [attributeTitle addAttributes:@{NSFontAttributeName : CUSTOMFONT(12.f), NSForegroundColorAttributeName : kColorTabbarGray} range:NSMakeRange(_title.length, _detail.length)];
        titleLabel.attributedText = attributeTitle;
    } else if (_title.length > 0) {
        NSMutableParagraphStyle *style = [NSMutableParagraphStyle new];
        style.alignment = NSTextAlignmentCenter;
        NSMutableAttributedString *attributeTitle = [[NSMutableAttributedString alloc] initWithString:_title attributes:@{NSParagraphStyleAttributeName : style, NSFontAttributeName : CUSTOMFONT(15.f), NSForegroundColorAttributeName : kColorTitleBlack}];
        titleLabel.attributedText = attributeTitle;
    } else if (_detail.length > 0) {
        NSMutableParagraphStyle *style = [NSMutableParagraphStyle new];
        style.alignment = NSTextAlignmentCenter;
        NSMutableAttributedString *attributeTitle = [[NSMutableAttributedString alloc] initWithString:_detail attributes:@{NSParagraphStyleAttributeName : style, NSFontAttributeName : CUSTOMFONT(12.f), NSForegroundColorAttributeName : kColorTabbarGray}];
        titleLabel.attributedText = attributeTitle;
    } else {
        titleLabel.text = @"";
    }
    
    _leftBarItem.hidden = NO;
    if (_leftBarItem.titleLabel.text.length > 0) {
        [_leftBarItem sizeToFit];
        [_leftBarItem setLeft:16.f];
    } else if (_leftBarItem.imageView.image) {
        _leftBarItem.frame = CGRectMake(16.f, 0, CGRectGetHeight(self.frame), CGRectGetHeight(self.frame));
        [_leftBarItem sizeThatFits:CGSizeMake(CGRectGetHeight(self.frame), CGRectGetHeight(self.frame))];
    } else {
        _leftBarItem.hidden = YES;
    }
    
    _rightBarItem.hidden = NO;
    if (_rightBarItem.imageView.image && _rightBarItem.titleLabel.text.length > 0) {
        _rightBarItem.frame = CGRectMake(CGRectGetWidth(self.frame) - 88.f, 0, 88.f, CGRectGetHeight(self.frame));
    } else if (_rightBarItem.titleLabel.text.length > 0) {
        [_rightBarItem sizeToFit];
        [_rightBarItem setLeft:CGRectGetWidth(self.frame) - CGRectGetWidth(_rightBarItem.frame) - 16.f];
    } else if (_rightBarItem.imageView.image) {
        _rightBarItem.frame = CGRectMake(CGRectGetWidth(self.frame) - CGRectGetHeight(self.frame) - 16.f, 0, CGRectGetHeight(self.frame), CGRectGetHeight(self.frame));
        [_rightBarItem sizeThatFits:CGSizeMake(CGRectGetHeight(self.frame), CGRectGetHeight(self.frame))];
    } else {
        _rightBarItem.hidden = YES;
    }
    
}

- (void)setTitle:(NSString *)title
{
    _title = title;
}

- (void)setDetail:(NSString *)detail
{
    _detail = detail;
}

#pragma mark - lazy load
- (UIButton *)leftBarItem
{
    if (_leftBarItem == nil) {
        _leftBarItem = [UIButton buttonWithType:UIButtonTypeCustom];
        _leftBarItem.backgroundColor = [UIColor whiteColor];
    }
    return _leftBarItem;
}

- (UIButton *)rightBarItem
{
    if (_rightBarItem == nil) {
        _rightBarItem = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightBarItem.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        _rightBarItem.backgroundColor = [UIColor whiteColor];
    }
    return _rightBarItem;
}

@end
