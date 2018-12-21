//
//  CustomDatePikerView.m
//  GeekRabbit
//
//  Created by FoxDog on 2018/12/5.
//  Copyright © 2018 FoxDog. All rights reserved.
//

#import "CustomDatePikerView.h"

@implementation CustomDatePikerView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.f];
        
        [self addSubview:self.pickerView];
        
        UITapGestureRecognizer *tapAction = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(datePikerViewDismissView)];
        [self addGestureRecognizer:tapAction];
    }
    return self;
}

+ (CustomDatePikerView *)datePikerViewWithCompleted:(PikerDismissBlock)completed
{
    CustomDatePikerView *pikerView = [[CustomDatePikerView alloc] initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, kScreenHeight)];
    pikerView.dismissBlaock = completed;
    pikerView.hidden = YES;
    return pikerView;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _pickerView.frame = CGRectMake(0, kScreenHeight - 294.f - (kDevice_Is_iPhoneX ? 40.f : 0.f), kScreenWidth, 294.f);
    if (self.hidden == NO) {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
    }
}

- (void)setCurrentDate:(NSDate *)currentDate
{
    _currentDate = currentDate;
    [_pickerView setDate:currentDate];
}

- (void)datePikerViewPresentView
{
    [self setTop:kScreenHeight];
    self.hidden = NO;
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [UIView animateWithDuration:0.35 delay:0.f usingSpringWithDamping:1.f initialSpringVelocity:1.f options:UIViewAnimationOptionCurveLinear animations:^{
        [self setTop:0.f];
    } completion:^(BOOL finished) {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
    }];
}

- (void)datePikerViewDismissView
{
    self.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.f];
    [UIView animateWithDuration:0.35 delay:0.f usingSpringWithDamping:1.f initialSpringVelocity:1.f options:UIViewAnimationOptionCurveLinear animations:^{
        [self setTop:kScreenHeight];
    } completion:^(BOOL finished) {
        if (_dismissBlaock) {
            _dismissBlaock(_pickerView.datePiker.date);
        }
        [self removeFromSuperview];
    }];
}

#pragma mark - lazy load
- (CustomDatePikerMainView *)pickerView
{
    if (_pickerView == nil) {
        _pickerView = [[CustomDatePikerMainView alloc] initWithFrame:CGRectMake(0, kScreenHeight - 294.f - (kDevice_Is_iPhoneX ? 40.f : 0.f), kScreenWidth, 294.f)];
        [_pickerView addLeftItemWithTitle:@"取消" Image:nil Target:self Selector:@selector(datePikerViewDismissView)];
        [_pickerView addRightItemWithTitle:@"确定" Image:nil Target:self Selector:@selector(datePikerViewDismissView)];
    }
    return _pickerView;
}

@end
