
#import "UIViewController+EX.h"
#import "UINavigationItem+margin.h"
#import "NSString+EX.h"

@implementation UIViewController (EX)

- (UIButton *)loadItemWithImage:(UIImage *)image HighLightImage:(UIImage *)hlImage target:(id)target action:(SEL)action position:(PPBarItemPosition)position {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(position == PPBarItemPosition_left ? 0.f : kScreenWidth - 44.f, 0, 44.f, 44.f);

    btn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:hlImage forState:UIControlStateHighlighted];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    btn.adjustsImageWhenHighlighted = NO;
    [self loadItemWithCustomView:btn position:position];
    return btn;
}

- (UIButton *)loadIconWithImage:(UIImage *)image HighLightImage:(UIImage *)hlImage target:(id)target action:(SEL)action position:(PPBarItemPosition)position {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    btn.frame = CGRectMake(position == PPBarItemPosition_left ? 0 : kScreenWidth - 44.f, 0, 44., 44.);

    btn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    btn.layer.cornerRadius = 12.;
    btn.autoresizingMask = UIViewAutoresizingFlexibleRightMargin;
    btn.clipsToBounds = YES;
    btn.layer.masksToBounds = YES;
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:hlImage forState:UIControlStateHighlighted];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    btn.adjustsImageWhenHighlighted = NO;
    [self loadItemWithCustomView:btn position:position];
    return btn;
}


- (UIButton *)loadBackButtonWithTarger:(id)target action:(SEL)action
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 44, 44);
    btn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [btn setImage:[UIImage imageNamed:@"nav_btn_back_default"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"nav_btn_back_default"] forState:UIControlStateHighlighted];
    btn.adjustsImageWhenHighlighted = NO;
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.backBarButtonItem = nil;
    [self loadItemWithCustomView:btn position:PPBarItemPosition_left];
    return btn;
}

- (UIButton *)loadHelpButtonWithTarget:(id)target action:(SEL)action
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(kScreenWidth - 44, 0, 44, 44);
    btn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [btn setImage:[UIImage imageNamed:@"help"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"help_touch"] forState:UIControlStateHighlighted];
    btn.adjustsImageWhenHighlighted = NO;
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [self loadItemWithCustomView:btn position:PPBarItemPosition_right];
    return btn;
}

- (UIButton *)loadItemWithTitle:(NSString *)title target:(id)target action:(SEL)action position:(PPBarItemPosition)position {
    float text_w = [NSString widthOfStr:title font:CUSTOMFONT(15.f) height:44] + 16;
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(position == PPBarItemPosition_left ? 0 : kScreenWidth - text_w, 0, text_w, 44);

    btn.titleEdgeInsets = UIEdgeInsetsMake(0, position == PPBarItemPosition_left ? 16 : 0, 0, position == PPBarItemPosition_left ? 0 : 16);
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:kColorBlackBean forState:UIControlStateNormal];
    [btn.titleLabel setFont:CUSTOMFONT(15.f)];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [self loadItemWithCustomView:btn position:position];
    return btn;
}

- (NSArray *)loadItemTwoImagesWithFirstImage:(UIImage *)firstImage  FirstHighlight:(UIImage *)firstHigh
                                 SecondImage:(UIImage *)secondImage  SecondHighlight:(UIImage *)secondHigh
                                      target:(id)target
                              firstBtnAction:(SEL)firstAction
                             secondBtnAction:(SEL)secondAction
                                    position:(PPBarItemPosition)position
{
    UIButton *first_btn = [UIButton buttonWithType:UIButtonTypeCustom];
    first_btn.frame = CGRectMake(0, 0, 44, 44);
    [first_btn setImage:firstImage forState:UIControlStateNormal];
    [first_btn setImage:firstHigh forState:UIControlStateHighlighted];
    [first_btn addTarget:target action:firstAction forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *second_btn = [UIButton buttonWithType:UIButtonTypeCustom];
    second_btn.frame = CGRectMake(44, 0, 44, 44);
    [second_btn setImage:secondImage forState:UIControlStateNormal];
    [second_btn setImage:secondHigh forState:UIControlStateHighlighted];
    [second_btn addTarget:target action:secondAction forControlEvents:UIControlEventTouchUpInside];
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake((position == PPBarItemPosition_left ? 0 : kScreenWidth - 88.f), 0, 88, 44)];
    [backView addSubview:first_btn];
    [backView addSubview:second_btn];
    NSArray *array = @[first_btn, second_btn];
    [self loadItemWithCustomView:backView position:position];
    return array;
}

- (NSArray *)loadItemTwoImagesWithFirstImage:(UIImage *)firstImage  FirstHighlight:(UIImage *)firstHigh
                                 SecondImage:(UIImage *)secondImage  SecondHighlight:(UIImage *)secondHigh
                                  ThirdImage:(UIImage *)thirdImage  ThirdHightlight:(UIImage *)thirdHigh
                                      target:(id)target
                              firstBtnAction:(SEL)firstAction
                             secondBtnAction:(SEL)secondAction
                              thirdBtnAction:(SEL)thirdAction
                                    position:(PPBarItemPosition)position
{
    UIButton *first_btn = [UIButton buttonWithType:UIButtonTypeCustom];
    first_btn.frame = CGRectMake(88, 0, 44, 44);
    [first_btn setImage:firstImage forState:UIControlStateNormal];
    [first_btn setImage:firstHigh forState:UIControlStateHighlighted];
    [first_btn addTarget:target action:firstAction forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *second_btn = [UIButton buttonWithType:UIButtonTypeCustom];
    second_btn.frame = CGRectMake(44, 0, 44, 44);
    [second_btn setImage:secondImage forState:UIControlStateNormal];
    [second_btn setImage:secondHigh forState:UIControlStateHighlighted];
    [second_btn addTarget:target action:secondAction forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *third_btn = [UIButton buttonWithType:UIButtonTypeCustom];
    third_btn.frame = CGRectMake(0, 0, 44, 44);
    [third_btn setImage:thirdImage forState:UIControlStateNormal];
    [third_btn setImage:thirdHigh forState:UIControlStateHighlighted];
    [third_btn addTarget:target action:thirdAction forControlEvents:UIControlEventTouchUpInside];
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(position == PPBarItemPosition_left ? 0 : kScreenWidth - 132.f, 0, 132, 44)];
    [backView addSubview:first_btn];
    [backView addSubview:second_btn];
    [backView addSubview:third_btn];
    NSArray *array = @[first_btn, second_btn, third_btn];
    [self loadItemWithCustomView:backView position:position];
    return array;
}


- (void)loadItemWithCustomView:(UIView *)view position:(PPBarItemPosition)position
{
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:view];
    if (position == PPBarItemPosition_left) {
        [self.navigationItem buildleftBarButtonItem:item];
//        [self.navigationItem setLeftBarButtonItem:item animated:YES];
    }else if (position == PPBarItemPosition_right) {
//        [self.navigationItem setRightBarButtonItem:item animated:YES];
        [self.navigationItem buildrightBarButtonItem:item];
    }
}

- (UILabel *)loadTitleWithTitle:(NSString *)title color:(UIColor *)color fontSize:(CGFloat)size{
    float text_w = [NSString widthOfStr:title font:CUSTOMFONT(size) height:size * Adaptation];
    UILabel *label = [[UILabel alloc] init];
    label.bounds = CGRectMake(0, 0, text_w + 6.f, size * Adaptation);
    label.center = CGPointMake(kScreenWidth * 0.5, 42.f);
    label.font = CUSTOMFONT(size);
    label.textColor = color;
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = title;
    self.navigationItem.titleView = label;
    return label;
}

- (void)loadTitleViewSubView:(UIView *)subView
{
    if (subView) {
        self.navigationItem.titleView = subView;
    }
}

- (UIButton *)loadItemWithTitle:(NSString *)title target:(id)target action:(SEL)action position:(PPBarItemPosition)position color:(UIColor *)color{
    float text_w = [NSString widthOfStr:title font:CUSTOMFONT(15.f) height:44] + 16;
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(position == PPBarItemPosition_left ? 0 : kScreenWidth - text_w, 0, text_w, 44);
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, position == PPBarItemPosition_left ? 16 : 0, 0, position == PPBarItemPosition_left ? 0 : 16);
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:color forState:UIControlStateNormal];
    [btn.titleLabel setFont:CUSTOMFONT(15.f)];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [self loadItemWithCustomView:btn position:position];
    return btn;
}

@end
