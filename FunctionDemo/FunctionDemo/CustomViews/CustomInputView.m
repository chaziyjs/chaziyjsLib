//
//  CustomInputView.m
//  GeekRabbit
//
//  Created by FoxDog on 2018/11/7.
//  Copyright © 2018 FoxDog. All rights reserved.
//

#import "CustomInputView.h"

@implementation CustomInputView {
    UIView *sep_line;
    BOOL titleStatement;
    NSMutableAttributedString *attributePlaceholder;
    CALayer *animationLayer;
}

+ (CustomInputView *)createInputViewInPoint:(CGPoint)point WithWidth:(CGFloat)width
{
    CustomInputView *inputView = [[CustomInputView alloc] initWithFrame:kDevice_IS_IPAD ? CGRectMake((kScreenWidth - IPADMAXWIDTH) * 0.5, point.y, IPADMAXWIDTH, VIEWHEIGHT) : CGRectMake(point.x, point.y, width, VIEWHEIGHT)];
    return inputView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        titleStatement = NO;
        [self addSubview:self.textField];
        [self addSubview:self.titleView];
        [self addSepLine];
        _textFont = CUSTOMFONT(14.f);
        _inputMaxLength = 0.f;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldTextChange:) name:UITextFieldTextDidChangeNotification object:_textField];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    if (titleStatement) {
        _textField.frame = CGRectMake(0.f, 24.f, CGRectGetWidth(self.frame), 40.f);
        _titleView.frame = CGRectMake(0, 12.f, CGRectGetWidth(self.frame), 12.f);
        _titleView.hidden = NO;
    } else {
        _textField.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), 64.f);
        _titleView.frame = CGRectMake(0, CGRectGetHeight(self.frame) - 12.f, CGRectGetWidth(self.frame), 12.f);
        _titleView.hidden = YES;
    }
    sep_line.frame = CGRectMake(0, CGRectGetHeight(self.frame) - 1.f, CGRectGetWidth(self.frame), 1.f);
}

- (void)addSepLine
{
    sep_line = [UIView new];
    [self addSubview:sep_line];
}

#pragma mark - 各种参数设置
- (void)setTitleStr:(NSString *)titleStr
{
    _titleStr = [titleStr copy];
    _titleView.text = _titleStr;
    [_titleView sizeToFit];
}

- (void)setTextColor:(UIColor *)textColor
{
    _textColor = textColor;
    _textField.textColor = textColor;
}

- (void)setTextFont:(UIFont *)textFont
{
    _textFont = textFont;
    _textField.font = textFont;
}

- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = [placeholder copy];
    _textField.placeholder = _placeholder;
    attributePlaceholder = [[NSMutableAttributedString alloc] initWithString:placeholder];
}

- (void)setPlaceholderFont:(UIFont *)placeholderFont
{
    _placeholderFont = placeholderFont;
    if (attributePlaceholder) {
        [attributePlaceholder addAttributes:@{NSFontAttributeName : placeholderFont} range:NSMakeRange(0, _placeholder.length)];
        _textField.attributedPlaceholder = attributePlaceholder;
    }
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
    if (attributePlaceholder) {
        [attributePlaceholder addAttributes:@{NSForegroundColorAttributeName : placeholderColor} range:NSMakeRange(0, _placeholder.length)];
        _textField.attributedPlaceholder = attributePlaceholder;
    }
}

- (void)setKeyboardType:(UIKeyboardType)keyboardType
{
    _keyboardType = keyboardType;
    _textField.keyboardType = keyboardType;
}

- (void)setClearBtn_img:(UIImage *)clearBtn_img
{
    _clearBtn_img = clearBtn_img;
    UIButton *clean = [_textField valueForKey:@"_clearButton"]; //key是固定的
    if (clean) {
        [clean setImage:clearBtn_img forState:UIControlStateNormal];
        [clean setImage:clearBtn_img forState:UIControlStateHighlighted];
    }
}

- (void)setSepline_normalColor:(UIColor *)sepline_normalColor
{
    _sepline_normalColor = sepline_normalColor;
    sep_line.backgroundColor = sepline_normalColor;
}

- (void)setSepline_editColor:(UIColor *)sepline_editColor
{
    _sepline_editColor = sepline_editColor;
}

- (void)setInputMaxLength:(NSUInteger)inputMaxLength
{
    _inputMaxLength = inputMaxLength;
}

- (void)setStyleModel:(CustomInputStyleModel)styleModel
{
    _styleModel = styleModel;
    _textField.secureTextEntry = (styleModel == CustomInputSecureTextEntryModel ? YES : NO);
}

#pragma mark - 现实标题动画
- (void)showTitleAnimation
{
    if (titleStatement == NO) {
        if (_titleView && _titleStr.length > 0) {
            titleStatement = YES;
            _titleView.hidden = NO;
            _titleView.alpha = 0.f;
            [UIView animateWithDuration:0.35 delay:0.f usingSpringWithDamping:0.9 initialSpringVelocity:0.9 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                [_titleView setTop:12.f];
                _titleView.alpha = 1.f;
                _textField.font = CUSTOMFONT(18.f);
                _textField.frame = CGRectMake(0.f, 24.f, CGRectGetWidth(self.frame), 40.f);
            } completion:nil];
            
        }
    }
}

#pragma mark - 隐藏标题动画
- (void)hiddenTitleAnimation
{
    if (titleStatement) {
        _titleView.hidden = NO;
        _titleView.alpha = 1.f;
        titleStatement = NO;
        [UIView animateWithDuration:0.35 delay:0.f usingSpringWithDamping:0.9 initialSpringVelocity:0.9 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            [_titleView setTop:CGRectGetHeight(self.frame) - CGRectGetHeight(_titleView.frame)];
            _titleView.alpha = 0.f;
            _textField.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), 64.f);
            if (attributePlaceholder) {
                _textField.attributedPlaceholder = attributePlaceholder;
            }
        } completion:^(BOOL finished) {
            _textField.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), 64.f);
            _titleView.hidden = YES;
        }];
        
    }
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (_delegate && [_delegate respondsToSelector:@selector(inputViewWillBeginEditing:)]) {
        kWeakSelf(self);
        [_delegate inputViewWillBeginEditing:weakself];
    }
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (_sepline_editColor) {
        [self sepLineScaleAnimetionWithColor:_sepline_editColor];
    }
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (_sepline_normalColor) {
        [UIView animateWithDuration:0.15 animations:^{
            sep_line.backgroundColor = _sepline_normalColor;
        }];
    }
    
    if (textField.text.length == 0) {
        [self hiddenTitleAnimation];
    }
    if (_delegate && [_delegate respondsToSelector:@selector(inputView:DidEndEditing:)]) {
        kWeakSelf(self);
        [_delegate inputView:weakself DidEndEditing:textField.text];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    if (![string isEqualToString:@""]) {
        [self showTitleAnimation];
    } else if ([string isEqualToString:@""] && range.location == 0) {
        [self hiddenTitleAnimation];
    }
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    [self hiddenTitleAnimation];
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - 相应系统通知
- (void)textFieldTextChange:(NSNotification *)notice
{
    if (_inputMaxLength > 0) {
        if (_textField.text.length > _inputMaxLength) {
            UITextRange *markedRange = [_textField markedTextRange];
            if (markedRange) {
                return;
            }
            //Emoji占2个字符，如果是超出了半个Emoji，用15位置来截取会出现Emoji截为2半
            //超出最大长度的那个字符序列(Emoji算一个字符序列)的range
            NSRange range = [_textField.text rangeOfComposedCharacterSequenceAtIndex:_inputMaxLength];
            _textField.text = [_textField.text substringToIndex:range.location];
        }
    }
    if (_delegate && [_delegate respondsToSelector:@selector(inputViewIsEdting:CurrentText:)]) {
        kWeakSelf(self);
        [_delegate inputViewIsEdting:weakself CurrentText:_textField.text];
    }
}

#pragma mark - 限制粘贴方法
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
//    if (_inputMaxLength > 0) {
//        if (action == @selector(paste:))//禁止粘贴
//            return NO;
//        if (action == @selector(select:))// 禁止选择
//            return NO;
//        if (action == @selector(selectAll:))// 禁止全选
//            return NO;
//    }
    return [super canPerformAction:action withSender:sender];
}

#pragma mark - sepLine动画
- (void)sepLineScaleAnimetionWithColor:(UIColor *)changeColor
{
    if (animationLayer == nil) {
        NSInteger layerWith = 1;
        CALayer *layer = [CALayer layer];
        layer.bounds = CGRectMake(0, 0, layerWith, layerWith);
        layer.center = CGPointMake(CGRectGetWidth(self.frame) * 0.5, 0.5);
        layer.backgroundColor = changeColor.CGColor;
        layer.masksToBounds = YES;
        [sep_line.layer addSublayer:layer];
        animationLayer = layer;
    }
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale.x"];
    animation.duration = 0.3;
    animation.fromValue = @1;;
    animation.toValue = [NSNumber numberWithFloat:CGRectGetWidth(self.frame)];
    animation.repeatCount = 0;
    animation.delegate = (id)self;
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    [animation setValue:changeColor forKey:@"ChangeColor"];
    [animationLayer setValue:animation forKey:@"animation"];
    [animationLayer addAnimation:animation forKey:@"ripple"];
}

- (void)animationDidStop:(CABasicAnimation *)anim finished:(BOOL)flag
{
    UIColor *orderColor = (UIColor *)[anim valueForKey:@"ChangeColor"];
    [animationLayer removeFromSuperlayer];
    animationLayer = nil;
    sep_line.backgroundColor = orderColor;
}

#pragma mark - lazy load
- (UITextField *)textField
{
    if (_textField == nil) {
        _textField = [UITextField new];
        _textField.font = CUSTOMFONT(14.f);
        _textField.delegate = self;
        _textField.backgroundColor = [UIColor whiteColor];
        _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _textField.backgroundColor = [UIColor whiteColor];
        _textField.returnKeyType = UIReturnKeyDone;
    }
    return _textField;
}

- (UILabel *)titleView
{
    if (_titleView == nil) {
        _titleView = [UILabel new];
        _titleView.font = CUSTOMFONT(12.f);
        _titleView.textColor = kColorTabbarGray;
        _titleView.hidden = YES;
    }
    return _titleView;
}

#pragma mark - dealloc
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:_textField];
}

@end
