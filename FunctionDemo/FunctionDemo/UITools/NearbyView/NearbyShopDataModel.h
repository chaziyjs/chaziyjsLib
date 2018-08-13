//
//  NearbyShopDataModel.h
//  AnywideConvenience
//
//  Created by chaziyjs on 2018/7/26.
//  Copyright © 2018年 Anywide1948. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NearbyShopDataModel : NSObject

@property (nonatomic, copy) NSString *shopname;             //商店名称
@property (nonatomic, copy) NSString *businesshours;        //营业时间
@property (nonatomic, copy) NSString *shopaddress;          //商店地址
@property (nonatomic, copy) NSNumber *distance;             //距离显示 单位m(km单位自转换)
@property (nonatomic, copy) NSNumber *longitude;            //经度
@property (nonatomic, copy) NSNumber *latitude;             //纬度

@end
