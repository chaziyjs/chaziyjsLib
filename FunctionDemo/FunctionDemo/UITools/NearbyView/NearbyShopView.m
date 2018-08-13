//
//  NearbyShopView.m
//  AnywideConvenience
//
//  Created by chaziyjs on 2018/7/26.
//  Copyright © 2018年 Anywide1948. All rights reserved.
//

#import "NearbyShopView.h"

NSString * const NearbyShopLongitude        = @"NearbyShopLongitude";
NSString * const NearbyShopLatitude         = @"NearbyShopLatitude";
NSString * const NearbyShopName             = @"NearbyShopName";
NSString * const NearbyShopAddress          = @"NearbyShopAddress";
NSString * const NearbyShopDistance         = @"NearbyShopDistance";
NSString * const NearbyShopBusinessHours    = @"NearbyShopBusinessHours";

@implementation NearbyShopView


+ (instancetype)nearbyShopWithFrame:(CGRect)frame InView:(UIView *)view NeedTouch:(BOOL)need TapBlock:(NearbyShopJump)block
{
    NearbyShopView *shopView = [[NearbyShopView alloc] initWithFrame:frame NeedTouch:need];
    shopView.callBack = block;
    [view addSubview:shopView];
    return shopView;
}

- (instancetype)initWithFrame:(CGRect)frame NeedTouch:(BOOL)need
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        if (need) {
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(jumpToShopList)];
            [self addGestureRecognizer:tap];
        }
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    if (_datamodel) {
        CGFloat distanceWidth = 0.f;
        if ([_datamodel.distance longValue] > 0) {
            long distance = [_datamodel.distance longValue];
            if (distance < 1000) {
                NSString *distanceText = kStringWithFormat(@"%ldm", distance);
                distanceWidth = [NSString widthOfStr:distanceText font:CUSTOMFONT(14.f) height:17.f * Adaptation];
                [distanceText drawInRect:CGRectMake(CGRectGetWidth(self.frame) - 16.f - distanceWidth, 40.f, distanceWidth, 17.f * Adaptation) withAttributes:@{NSFontAttributeName : CUSTOMFONT(14.f), NSForegroundColorAttributeName : kColorTabbarGray}];
            } else {
                NSString *distanceText = kStringWithFormat(@"%ldkm", distance / 1000);
                distanceWidth = [NSString widthOfStr:distanceText font:CUSTOMFONT(14.f) height:17.f * Adaptation];
                [distanceText drawInRect:CGRectMake(CGRectGetWidth(self.frame) - 16.f - distanceWidth, 40.f, distanceWidth, 17.f * Adaptation) withAttributes:@{NSFontAttributeName : CUSTOMFONT(14.f), NSForegroundColorAttributeName : kColorTabbarGray}];
            }
        }
        
        [CUSTOMIMG(@"ShopLocation") drawInRect:CGRectMake(CGRectGetWidth(self.frame) - 22.f - distanceWidth * 0.5, 14.f, 12.f, 16.f) withContentMode:UIViewContentModeScaleToFill clipsToBounds:YES];
        
        NSString *shopTitle = [NSString stringWithFormat:@"%@ (%@)", _datamodel.shopname, _datamodel.businesshours];
        [shopTitle drawInRect:CGRectMake(15.f, 12.f, CGRectGetWidth(self.frame) - 32.f - distanceWidth, 18.f * Adaptation) withAttributes:@{NSFontAttributeName : CUSTOMFONT(15.f), NSForegroundColorAttributeName : kColorTitleBlack}];
        
        [_datamodel.shopaddress drawInRect:CGRectMake(15.f, 35.f, CGRectGetWidth(self.frame) - 32.f - distanceWidth, 16.f * Adaptation) withAttributes:@{NSFontAttributeName : CUSTOMFONT(13.f), NSForegroundColorAttributeName : kColorTabbarGray}];
    }
}

#pragma mark - DataModel set 方法
- (void)setDatamodel:(NearbyShopDataModel *)datamodel
{
    _datamodel = datamodel;
    [self setNeedsDisplay];
}

#pragma mark - 跳转事件
- (void)jumpToShopList
{
    self.userInteractionEnabled = NO;
    if (_callBack) {
        if (_datamodel) {
            NSDictionary *param = @{
                                    NearbyShopName : _datamodel.shopname ?: [NSNull null],
                                    NearbyShopAddress : _datamodel.shopaddress ?: [NSNull null],
                                    NearbyShopDistance : _datamodel.distance ?: [NSNull null],
                                    NearbyShopBusinessHours : _datamodel.businesshours ?: [NSNull null],
                                    NearbyShopLongitude : _datamodel.longitude ?: [NSNull null],
                                    NearbyShopLatitude : _datamodel.latitude ?: [NSNull null]
                                    };
            self.callBack(param);
        } else {
            self.callBack(NULL);
        }
    }
    if (_delegate && [_delegate respondsToSelector:@selector(nearbyShopJumpToListWithData:)]) {
        [_delegate nearbyShopJumpToListWithData:_datamodel];
    }
    self.userInteractionEnabled = YES;
}

@end
