//
//  EventHandlerDataModel.h
//  WetalkCommunity
//
//  Created by chaziyjs on 2017/10/18.
//  Copyright © 2017年 chaziyjs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DIYEventModel.h"

@interface EventHandlerDataModel : NSObject

@property (nonatomic, copy) NSString *event_id;
@property (nonatomic, strong) NSDictionary *userInfo; //同一类型设置的userInfo要使用相同文件格式,以方便读取
@property (nonatomic, strong) DIYEventModel *diy_data;

@end
