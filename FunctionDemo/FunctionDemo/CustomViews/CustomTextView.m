//
//  CustomTextView.m
//  GeekRabbit
//
//  Created by FoxDog on 2018/11/14.
//  Copyright © 2018 FoxDog. All rights reserved.
//

#import "CustomTextView.h"

@implementation CustomTextView {
    UILabel *limitView;
    UILabel *placeholderView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.textView];
        _placeholdFont = CUSTOMFONT(14.f);
        _placeholdColor = kColorTabbarGray;
        placeholderView = [self.textView valueForKey:@"_placeholderLabel"];
        if (placeholderView == nil) {
            placeholderView = [UILabel new];
            placeholderView.numberOfLines = 0;
            placeholderView.font = _placeholdFont;
            placeholderView.textColor = _placeholdColor;
            [self.textView setValue:placeholderView forKey:@"_placeholderLabel"];
            [self.textView addSubview:placeholderView];
        }
        
        [self addSubview:[self buildLimitView]];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewTextDidChange) name:UITextViewTextDidChangeNotification object:nil];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _textView.frame = self.bounds;
    limitView.frame = CGRectMake(0, CGRectGetHeight(self.frame) - 24.f, CGRectGetWidth(self.frame) - 16.f, 14.f * Adaptation);
    [placeholderView sizeThatFits:CGSizeMake(CGRectGetWidth(self.frame) - (_placeholdEdge.left + _placeholdEdge.right), CGRectGetHeight(self.frame) - (_placeholdEdge.top + _placeholdEdge.bottom))];
    [placeholderView setLeft:_placeholdEdge.left];
    [placeholderView setTop:_placeholdEdge.top];
    if (CGRectGetHeight(placeholderView.bounds) > (CGRectGetHeight(self.frame) - (_placeholdEdge.top + _placeholdEdge.bottom))) {
        [placeholderView setHeight:(CGRectGetHeight(self.frame) - (_placeholdEdge.top + _placeholdEdge.bottom))];
    }
}

#pragma mark - 文字改变相应通知
- (void)textViewTextDidChange
{
    if (_showLimit && _limitCount > 0) {
        NSInteger currentTextLength = self.textView.text.length;
        if (currentTextLength > _limitCount) {
            NSRange range = [self.textView.text rangeOfComposedCharacterSequenceAtIndex:_limitCount];
            self.textView.text = [self.textView.text substringToIndex:range.location];
            currentTextLength = _limitCount;
        }
        if (_limitCount > 10000) {
            limitView.text = [NSString stringWithFormat:@"%ld/%ldw", currentTextLength, _limitCount / 10000];
        } else {
            limitView.text = [NSString stringWithFormat:@"%ld/%ld", currentTextLength, _limitCount];
        }
    } else {
        return;
    }
}

#pragma mark - set方法 属性设置
- (void)setPlaceholdText:(NSString *)placeholdText
{
    _placeholdText = [placeholdText copy];
    placeholderView.text = _placeholdText;
    [placeholderView sizeToFit];
}

- (void)setPlaceholdColor:(UIColor *)placeholdColor
{
    _placeholdColor = placeholdColor;
    placeholderView.textColor = placeholdColor;
}

- (void)setPlaceholdFont:(UIFont *)placeholdFont
{
    _placeholdFont = placeholdFont;
    placeholderView.font = _placeholdFont;
    [placeholderView sizeToFit];
}

- (void)setPlaceholdEdge:(UIEdgeInsets)placeholdEdge
{
    _placeholdEdge = placeholdEdge;
}

- (void)setLimitCount:(NSInteger)limitCount
{
    _limitCount = limitCount;
    limitView.text = [NSString stringWithFormat:@"0/%@", (_limitCount > 10000 ? @(_limitCount / 10000) : @(_limitCount))];
}

- (void)setShowLimit:(BOOL)showLimit
{
    _showLimit = showLimit;
    limitView.hidden = !showLimit;
}

#pragma mark - load
- (UITextView *)textView
{
    if (_textView == nil) {
        _textView = [[UITextView alloc] initWithFrame:self.bounds];
    }
    return _textView;
}

- (UILabel *)buildLimitView
{
    if (limitView == nil) {
        limitView = [UILabel new];
        limitView.font = CUSTOMFONT(14.f);
        limitView.textColor = kColorTabbarGray;
        limitView.hidden = YES;
        limitView.textAlignment = NSTextAlignmentRight;
    }
    return limitView;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidChangeNotification object:nil];
}

@end
