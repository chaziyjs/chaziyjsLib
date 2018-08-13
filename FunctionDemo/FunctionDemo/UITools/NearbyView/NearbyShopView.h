//
//  NearbyShopView.h
//  AnywideConvenience
//
//  Created by chaziyjs on 2018/7/26.
//  Copyright © 2018年 Anywide1948. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NearbyShopDataModel.h"

//方法常用于 通知传参 或者 配置信息,这里是学习如何使用情况
typedef NSString *NearbyShopParamterKey NS_EXTENSIBLE_STRING_ENUM;

UIKIT_EXTERN NearbyShopParamterKey const NearbyShopLongitude;
UIKIT_EXTERN NearbyShopParamterKey const NearbyShopLatitude;
UIKIT_EXTERN NearbyShopParamterKey const NearbyShopName;
UIKIT_EXTERN NearbyShopParamterKey const NearbyShopAddress;
UIKIT_EXTERN NearbyShopParamterKey const NearbyShopDistance;
UIKIT_EXTERN NearbyShopParamterKey const NearbyShopBusinessHours;

typedef void(^NearbyShopJump)(NSDictionary<NearbyShopParamterKey, id> * _Nullable parameter);

@protocol NearbyShopViewDelegate <NSObject>

@optional
- (void)nearbyShopJumpToListWithData:(NearbyShopDataModel *)model;

@end

@interface NearbyShopView : UIView

@property (nonatomic, strong) NearbyShopDataModel *datamodel;

@property (nonatomic, copy) NearbyShopJump callBack;
@property (nonatomic, weak) id<NearbyShopViewDelegate> delegate; //执行代理或者选择block 两种方式都可以, 任选其一

+ (instancetype)nearbyShopWithFrame:(CGRect)frame
                             InView:(UIView *)view
                          NeedTouch:(BOOL)need
                           TapBlock:(NearbyShopJump)block;

- (instancetype)initWithFrame:(CGRect)frame
                    NeedTouch:(BOOL)need;

@end
