//
//  PayAlertContentView.m
//  AnywideConvenience
//
//  Created by chaziyjs on 2018/6/15.
//  Copyright © 2018年 Anywide1948. All rights reserved.
//

#import "PayAlertContentView.h"

#define     MAXTEXTWIDTH        (kScreenWidth - 48.f)
#define     TitleInfo           @"titleInfo"
#define     MessageInfo         @"messageInfo"
#define     ImageInfo           @"imageInfo"
#define     ImageSizeInfo       @"imageSizeInfo"

@implementation PayAlertContentView {
    UILabel *titleLabel;
    UITextView *mutableDetail;
    UILabel *detailLabel;
    NSMutableArray *btns_array;
    NSMutableDictionary *userinfo;
    NSMutableArray *titleArray;
    NSMutableArray *detailArray;
    UIImageView *iconView;
    PayAlertStyle style;
    CGRect textRect;
    CGSize touchSize;
}

- (void)createCountViewWithTitle:(NSString *)title ContentMessage:(NSString *)message LoadImage:(UIImage *)image imageSize:(CGSize)imageSize ContentStyle:(PayAlertStyle)contentStyle
{
    style = contentStyle;
    if (userinfo) {
        if (title && title.length > 0) {
            [userinfo setObject:title forKey:TitleInfo];
            NSArray *titleLines = [NSString getLinesArrayOfStringInLabel:title font:CUSTOMFONT(17.f) andLableWidth:MAXTEXTWIDTH - 16.f];
            titleArray = [NSMutableArray arrayWithArray:titleLines];
        }
        
        if (message && message.length > 0) {
            [userinfo setObject:message forKey:MessageInfo];
            NSArray *detailLines = [NSString getLinesArrayOfStringInLabel:message font:CUSTOMFONT(14.f) andLableWidth:MAXTEXTWIDTH - 16.f];
            detailArray = [NSMutableArray arrayWithArray:detailLines];
        }
        
        if (image) {
            [userinfo setObject:image forKey:ImageInfo];
            [userinfo setObject:NSStringFromCGSize(imageSize) forKey:ImageSizeInfo];
        } else {
            style = PayAlertWithoutImage;
        }
    } else {
        userinfo = [NSMutableDictionary dictionary];
        [self createCountViewWithTitle:title ContentMessage:message LoadImage:image imageSize:imageSize ContentStyle:contentStyle];
    }
    if (style == PayAlertTitleWithImage) {
        textRect = CGRectMake(0, 0, MAXTEXTWIDTH, (imageSize.height > 20.f ? imageSize.height : 20.f) + (detailArray.count > 5 ? 80.f : (detailArray.count <= 0 ? -16 : detailArray.count * 16.f)) + 44.f);
    } else {
        textRect = CGRectMake(0, 0, MAXTEXTWIDTH, (titleArray.count > 0 ? titleArray.count * 19.f : -19) + (detailArray.count > 5 ? 80.f : (detailArray.count <= 0 ? -16 : detailArray.count * 16.f)) + 44.f);
    }
    [self buildMainView];
}

#pragma mark - 搭建主视图
- (void)buildMainView
{
    if (style == PayAlertTitleWithImage) {
        NSString *imageSizeStr = [userinfo objectForKey:ImageSizeInfo];
        CGSize imageSize = CGSizeFromString(imageSizeStr);
        NSString *firstLine = [titleArray firstObject];
        float textW = [NSString widthOfStr:firstLine font:CUSTOMFONT(17.f) height:20.f];
        if (imageSize.width + textW + 32.f >= MAXTEXTWIDTH) {
            float panWidth = 8.f;
            if (userinfo[ImageInfo]) {
                iconView = [[UIImageView alloc] initWithImage:userinfo[ImageInfo]];
                iconView.frame = CGRectMake(panWidth, 24.f, imageSize.width, imageSize.height);
                [self addSubview:iconView];
            } else {
                [iconView removeFromSuperview];
            }
            if ([userinfo objectForKey:TitleInfo]) {
                titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(iconView.frame) + 12.f, 24 + imageSize.height * 0.5 - 10.f, MAXTEXTWIDTH - imageSize.width - 28.f, 20.f)];
                titleLabel.font = CUSTOMFONT(17.f);
                titleLabel.textColor = kColorTitleBlack;
                titleLabel.text = [userinfo objectForKey:TitleInfo];
                [titleLabel sizeToFit];
                [self addSubview:titleLabel];
            } else {
                [titleLabel removeFromSuperview];
            }
        } else {
            float panWidth = (MAXTEXTWIDTH - imageSize.width - textW - 12.f) * 0.5;
            if (userinfo[ImageInfo]) {
                iconView = [[UIImageView alloc] initWithImage:userinfo[ImageInfo]];
                iconView.frame = CGRectMake(panWidth, 24.f, imageSize.width, imageSize.height);
                [self addSubview:iconView];
            } else {
                [iconView removeFromSuperview];
            }
            
            if ([userinfo objectForKey:TitleInfo]) {
                titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(iconView.frame) + 12.f, 24 + imageSize.height * 0.5 - 10.f, textW, 20.f)];
                titleLabel.font = CUSTOMFONT(17.f);
                titleLabel.textColor = kColorTitleBlack;
                titleLabel.text = [userinfo objectForKey:TitleInfo];
                [titleLabel sizeToFit];
                [self addSubview:titleLabel];
            } else {
                [titleLabel removeFromSuperview];
            }
        }
        if (detailArray.count > 5) {
            mutableDetail = [[UITextView alloc] initWithFrame:CGRectMake(8.f, CGRectGetHeight(textRect) - 88.f, MAXTEXTWIDTH - 16.f, 80.f)];
            mutableDetail.showsVerticalScrollIndicator = NO;
            mutableDetail.editable = NO;
            mutableDetail.font = CUSTOMFONT(14.f);
            mutableDetail.text = [userinfo objectForKey:MessageInfo];
            mutableDetail.textColor = kColorBGGray;
            [self addSubview:mutableDetail];
        } else {
            if ([userinfo objectForKey:MessageInfo]) {
                detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, CGRectGetHeight(textRect) - detailArray.count * 16.f - 8.f, MAXTEXTWIDTH - 16.f, detailArray.count * 16.f)];
                detailLabel.text = [userinfo objectForKey:MessageInfo];
                detailLabel.font = CUSTOMFONT(14.f);
                detailLabel.textColor = kColorBGGray;
                detailLabel.textAlignment = NSTextAlignmentCenter;
                [self addSubview:detailLabel];
            } else {
                [mutableDetail removeFromSuperview];
                [detailLabel removeFromSuperview];
            }
        }
    } else {
        if ([userinfo objectForKey:TitleInfo]) {
            titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(8.f, 24.f, MAXTEXTWIDTH - 16.f, titleArray.count * 19.f)];
            titleLabel.textAlignment = NSTextAlignmentCenter;
            titleLabel.text = [userinfo objectForKey:TitleInfo];
            titleLabel.font = CUSTOMFONT(17.f);
            titleLabel.textColor = kColorTitleBlack;
            [self addSubview:titleLabel];
        }
        if (detailArray.count > 5) {
            mutableDetail = [[UITextView alloc] initWithFrame:CGRectMake(8.f, CGRectGetHeight(textRect) - 88.f, MAXTEXTWIDTH - 16.f, 80.f)];
            mutableDetail.showsVerticalScrollIndicator = NO;
            mutableDetail.editable = NO;
            mutableDetail.font = CUSTOMFONT(14.f);
            mutableDetail.text = [userinfo objectForKey:MessageInfo];
            mutableDetail.textColor = kColorBGGray;
            [self addSubview:mutableDetail];
        } else {
            if ([userinfo objectForKey:MessageInfo]) {
                detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, CGRectGetHeight(textRect) - detailArray.count * 16.f - 8.f, MAXTEXTWIDTH - 16.f, detailArray.count * 16.f)];
                detailLabel.text = [userinfo objectForKey:MessageInfo];
                detailLabel.font = CUSTOMFONT(14.f);
                detailLabel.textColor = kColorBGGray;
                detailLabel.textAlignment = NSTextAlignmentCenter;
                [self addSubview:detailLabel];
            } else {
                [mutableDetail removeFromSuperview];
                [detailLabel removeFromSuperview];
            }
        }
    }
}

- (void)setButtonArray:(NSMutableArray <__kindof PayAlertAction *> *)buttonArray
{
    if (buttonArray.count > 0) {
        btns_array = [buttonArray mutableCopy];
        if (buttonArray.count == 1) {
            touchSize = CGSizeMake(MAXTEXTWIDTH, 44.f);
            self.bounds = CGRectMake(0, 0, MAXTEXTWIDTH, touchSize.height + CGRectGetHeight(textRect) + 0.5);
            self.center = CGPointMake(kScreenWidth * 0.5, kScreenHeight * 0.5);
            PayAlertAction *action_1 = [buttonArray firstObject];
            UIButton *button_1 = [UIButton buttonWithType:UIButtonTypeCustom];
            button_1.frame = CGRectMake(0, CGRectGetHeight(textRect) + 0.5, MAXTEXTWIDTH, 44.f);
            button_1.titleLabel.font = CUSTOMFONT(17.f);
            [button_1 setTitle:action_1.actionTitle forState:UIControlStateNormal];
            [button_1 addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
            if (action_1.type == PayAlertActionCancel) {
                [button_1 setTitleColor:kColorPriceRed forState:UIControlStateNormal];
            } else {
                [button_1 setTitleColor:kColorTitleBlack forState:UIControlStateNormal];
            }
            [self addSubview:button_1];
        } else if (buttonArray.count == 2) {
            touchSize = CGSizeMake(MAXTEXTWIDTH, 44.f);
            self.bounds = CGRectMake(0, 0, MAXTEXTWIDTH, touchSize.height + CGRectGetHeight(textRect) + 0.5);
            self.center = CGPointMake(kScreenWidth * 0.5, kScreenHeight * 0.5);
            PayAlertAction *action_1 = [buttonArray firstObject];
            UIButton *button_1 = [UIButton buttonWithType:UIButtonTypeCustom];
            button_1.frame = CGRectMake(0, CGRectGetHeight(textRect) + 0.5, (MAXTEXTWIDTH - 0.5) * 0.5, 44.f);
            button_1.titleLabel.font = CUSTOMFONT(17.f);
            [button_1 setTitle:action_1.actionTitle forState:UIControlStateNormal];
            [button_1 addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
            button_1.tag = 96188 + 1;
            if (action_1.type == PayAlertActionCancel) {
                [button_1 setTitleColor:kColorPriceRed forState:UIControlStateNormal];
            } else {
                [button_1 setTitleColor:kColorTitleBlack forState:UIControlStateNormal];
            }
            [self addSubview:button_1];
            PayAlertAction *action_2 = [buttonArray lastObject];
            UIButton *button_2 = [UIButton buttonWithType:UIButtonTypeCustom];
            button_2.frame = CGRectMake(MAXTEXTWIDTH * 0.5, CGRectGetHeight(textRect) + 0.5, MAXTEXTWIDTH * 0.5, 44.f);
            button_2.titleLabel.font = CUSTOMFONT(17.f);
            [button_2 setTitle:action_2.actionTitle forState:UIControlStateNormal];
            button_2.tag = 96188 + 2;
            if (action_2.type == PayAlertActionCancel) {
                [button_2 setTitleColor:kColorPriceRed forState:UIControlStateNormal];
            } else {
                [button_2 setTitleColor:kColorTitleBlack forState:UIControlStateNormal];
            }
            [button_2 addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:button_2];
        } else {
            touchSize = CGSizeMake(MAXTEXTWIDTH, buttonArray.count * 44.f);
            self.bounds = CGRectMake(0, 0, MAXTEXTWIDTH, touchSize.height + CGRectGetHeight(textRect) + 0.5);
            self.center = CGPointMake(kScreenWidth * 0.5, kScreenHeight * 0.5);
            for (int i = 0; i < buttonArray.count; i ++) {
                PayAlertAction *action = [buttonArray objectAtIndex:i];
                UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
                if (action.type == PayAlertActionCancel) {
                    [button setTitleColor:kColorPriceRed forState:UIControlStateNormal];
                } else {
                    [button setTitleColor:kColorTitleBlack forState:UIControlStateNormal];
                }
                button.tag = 96198 + i;
                button.frame = CGRectMake(0, CGRectGetHeight(textRect) + 0.5 + i * 44.5, MAXTEXTWIDTH, 44.f);
                button.titleLabel.font = CUSTOMFONT(17.f);
                [button setTitle:action.actionTitle forState:UIControlStateNormal];
                [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
                [self addSubview:button];
            }
        }
    }
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        btns_array = [NSMutableArray array];
        userinfo = [NSMutableDictionary dictionary];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGContextRef ref = UIGraphicsGetCurrentContext(); // 拿到当前画板，在这个画板上画就是在视图上画
    CGContextBeginPath(ref); // 开始绘画
    CGContextSetLineWidth(ref, 0.5);
    //第一条线
    CGContextMoveToPoint(ref, 0, CGRectGetHeight(textRect) + 0.5); // 画线
    CGContextAddLineToPoint(ref, rect.size.width, CGRectGetHeight(textRect) + 0.5);
    if (btns_array.count == 2) {
        CGContextMoveToPoint(ref, rect.size.width * 0.5, CGRectGetHeight(textRect) + 0.5); // 画线
        CGContextAddLineToPoint(ref, rect.size.width * 0.5, CGRectGetHeight(textRect) + 44.5);
    } else if (btns_array.count > 2) {
        for (int i = 1; i < btns_array.count; i ++) {
            CGContextMoveToPoint(ref, 0, CGRectGetHeight(textRect) + 0.5 + i * 44.f); // 画线
            CGContextAddLineToPoint(ref, rect.size.width, CGRectGetHeight(textRect) + 0.5 + i * 44.f);
        }
    }
    CGFloat grayColor[4] = {(236.f / 255.f), (236.f / 255.f), (236.f / 255.f), 1.0};
    CGContextSetStrokeColor(ref, grayColor); // 设置当前画笔的颜色，这两句可以用[[UIColor whiteColor] setStroke]代替;
    CGContextStrokePath(ref); // 对移动的路径画线
    
    //圆角设置
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(5.f, 5.f)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    maskLayer.strokeColor = [UIColor clearColor].CGColor;
    self.layer.mask = maskLayer;
}

#pragma mark - button点击事件
- (void)buttonAction:(UIButton *)sender
{
    if (btns_array.count > 0) {
        if (btns_array.count == 1) {
            PayAlertAction *action = [btns_array firstObject];
            __weak typeof(PayAlertAction *) weakAction = action;
            action.callback(weakAction);
        } else if (btns_array.count == 2) {
            NSInteger tags = sender.tag - 96188;
            PayAlertAction *action = [btns_array objectAtIndex:tags - 1];
            __weak typeof(PayAlertAction *) weakAction = action;
            action.callback(weakAction);
        } else {
            NSInteger tags = sender.tag - 96198;
            PayAlertAction *action = [btns_array objectAtIndex:tags];
            __weak typeof(PayAlertAction *) weakAction = action;
            action.callback(weakAction);
        }
    } else {
        FLog(@"告诉我,你是怎么做到的");
    }
}

- (void)dealloc
{
    [btns_array removeAllObjects];
    [titleArray removeAllObjects];
    [detailArray removeAllObjects];
    userinfo = nil;
}

@end
