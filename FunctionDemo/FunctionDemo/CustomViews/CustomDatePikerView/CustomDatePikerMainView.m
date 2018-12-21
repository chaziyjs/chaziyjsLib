//
//  CustomDatePikerMainView.m
//  GeekRabbit
//
//  Created by FoxDog on 2018/12/4.
//  Copyright © 2018 FoxDog. All rights reserved.
//

#import "CustomDatePikerMainView.h"

@implementation CustomDatePikerMainView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.titleView];
        [self addSubview:self.datePiker];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _titleView.frame = CGRectMake(0, 0, kScreenWidth, 44.f);
    _datePiker.frame = CGRectMake(0, 44, kScreenWidth, 250);
}

#pragma mark - 属性参数设置
- (void)setMaximumDate:(NSDate *)maximumDate
{
    _maximumDate = maximumDate;
    _datePiker.maximumDate = _maximumDate;
}

- (void)setMinimumDate:(NSDate *)minimumDate
{
    _minimumDate = minimumDate;
    _datePiker.minimumDate = _minimumDate;
}

- (void)setDate:(NSDate *)date
{
    _date = date;
    [_datePiker setDate:_date animated:YES];
}

- (UIButton *)addLeftItemWithTitle:(nullable NSString *)title
                             Image:(nullable UIImage *)img
                            Target:(id)target
                          Selector:(SEL)selector
{
    if (title.length > 0) {
        [_titleView.leftBarItem setTitle:title forState:UIControlStateNormal];
        [_titleView.leftBarItem.titleLabel setFont:CUSTOMFONT(15.f)];
        [_titleView.leftBarItem setTitleColor:kColorTitleBlack forState:UIControlStateNormal];
    }
    
    if (img) {
        [_titleView.leftBarItem setImage:img forState:UIControlStateNormal];
    }
    
    if (target && selector) {
        [_titleView.leftBarItem addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _titleView.leftBarItem;
}

- (UIButton *)addRightItemWithTitle:(nullable NSString *)title
                              Image:(nullable UIImage *)img
                             Target:(id)target
                           Selector:(SEL)selector
{
    if (title.length > 0) {
        [_titleView.rightBarItem setTitle:title forState:UIControlStateNormal];
        [_titleView.rightBarItem.titleLabel setFont:CUSTOMFONT(15.f)];
        [_titleView.rightBarItem setTitleColor:kColorTitleBlack forState:UIControlStateNormal];
    }
    
    if (img) {
        [_titleView.rightBarItem setImage:img forState:UIControlStateNormal];
    }
    
    if (target && selector) {
        [_titleView.rightBarItem addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _titleView.rightBarItem;
}

#pragma mark - pikerView Action Foundation
- (void)dateChangeValue:(UIDatePicker *)piker
{
    NSDate *selectedDate = piker.date;
    FLog(@"choose Date = %@", selectedDate);
}

#pragma mark - lazy load
- (DatePikerTitleView *)titleView
{
    if (_titleView == nil) {
        _titleView = [[DatePikerTitleView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 44.f)];
    }
    return _titleView;
}

- (UIDatePicker *)datePiker
{
    if (_datePiker == nil) {
        _datePiker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 44, kScreenWidth, 250)];
        _datePiker.datePickerMode = UIDatePickerModeDate;
        [_datePiker setCalendar:[NSCalendar currentCalendar]];
        [_datePiker setTimeZone:[NSTimeZone timeZoneWithName:@"GMT+8"]];
        [_datePiker setDate:[NSDate date] animated:YES];
        [_datePiker setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"zh_Hans_CN"]];
        _datePiker.minimumDate = [NSDate dateWithTimeIntervalSince1970:0];
        _datePiker.maximumDate = [NSDate date];
        
        [_datePiker addTarget:self action:@selector(dateChangeValue:) forControlEvents:UIControlEventValueChanged];
    }
    return _datePiker;
}

@end
