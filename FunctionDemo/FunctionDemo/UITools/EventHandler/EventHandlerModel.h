//
//  EventHandlerModel.h
//  WetalkCommunity
//
//  Created by chaziyjs on 2017/9/28.
//  Copyright © 2017年 chaziyjs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EventHandlerDataModel.h"
#import "NSDate+CalculatePeriod.h"
#import "HomeAdModel.h"

typedef NS_ENUM(NSInteger, EventHandlerModelType)
{
    HomeAdEvent             =   8000,
    PushNoticeEvent         =   8001,
    MessageNoticeEvent      =   8002,
    PageJumpEvent           =   8003,
    OpenAdEvent             =   8004,
    SYSNoticeEvent          =   8005,
    DIYEvent                =   8006
};



@interface EventHandlerModel : NSObject
/**
 * 事件存储字典
 * 格式:
 * {
 *  @(MessageNoticeEvent) : @[...]
 * }
 */
@property (atomic, strong, readonly) NSMutableDictionary *event_storage;

/**
 plist文件路径
 */
@property (nonatomic, copy, readonly) NSString *path;


/**
 单例初始化方法

 @return EventHandlerModel
 */
+ (instancetype)shareEventHandler;

/**
 向事件管理中心添加需要存储的事件

 @param param 事件字典(格式看event_storage)
 */
- (void)addEventInStorage:(EventHandlerDataModel *)param;

/**
 读取事件中心中某个类型的最新事件

 @param type 事件类型
 @return 存储的最新事件
 */
- (id)readEventWithType:(EventHandlerModelType)type;

/**
 删除完成的事件

 @param event 完成的事件
 @param type 事件类型
 */
- (void)finishEventWithString:(id)event
                   EventsType:(EventHandlerModelType)type;

/**
 返回某个事件类型下的所有事件

 @param type 事件类型
 @return 存储事件数组
 */
- (NSArray *)allEventsWithType:(EventHandlerModelType)type;

/**
 删除某个事件类型下的所有事件

 @param type 事件类型
 */
- (void)removeAllEventWithType:(EventHandlerModelType)type;
/**
 头图、开机广告、广告弹窗点击计数接口

 @param tpid 活动ID
 */
- (void)touchStatisticsParameter:(NSString *)tpid advid:(NSString *)advid click:(NSString *)click;

@end
