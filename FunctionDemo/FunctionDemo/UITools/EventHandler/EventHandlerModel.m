//
//  EventHandlerModel.m
//  WetalkCommunity
//
//  Created by chaziyjs on 2017/9/28.
//  Copyright © 2017年 chaziyjs. All rights reserved.
//

#import "EventHandlerModel.h"

static EventHandlerModel *eventModel = nil;
static dispatch_once_t onceToken;

@implementation EventHandlerModel

+ (instancetype)shareEventHandler
{
    dispatch_once(&onceToken, ^{
        eventModel = [[EventHandlerModel alloc] init];
    });
    return eventModel;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _event_storage = [NSMutableDictionary dictionaryWithDictionary:@{@"8000" : @[], @"8001" : @[], @"8002" : @[], @"8003" : @[], @"8004" : @[], @"8005" : @[], @"8006" : @[]}];
    }
    return self;
}
#pragma mark - 添加存储事件(Key & Value)
- (void)addEventInStorage:(EventHandlerDataModel *)param
{
    __block typeof(EventHandlerDataModel *) block_param = param;
    switch ([block_param.event_id integerValue]) {
        case HomeAdEvent: {
            if (kStandardUserDefaultsObject(@"HOMEAD")) {
                NSMutableDictionary *values = [NSMutableDictionary dictionaryWithDictionary:block_param.userInfo];
                NSDictionary *old_ad = kStandardUserDefaultsObject(@"HOMEAD");
                if ([[values valueForKey:@"tpid"] isEqual:[old_ad valueForKey:@"tpid"]]) {
                    HomeAdModel *old_adModel = [HomeAdModel modelWithDictionary:old_ad];
                    NSDate *add_date = [NSDate dateWithString:old_adModel.addtime format:@"yyyy-MM-dd"];
                    if ([NSDate daysFromLotteryDate:add_date CurrentDate:[NSDate date]] >= 1) {
                        [values setValue:[[NSDate date] dateFormateWithString:@"yyyy-MM-dd"] forKey:@"addtime"];
                        HomeAdModel *new_adModel = [HomeAdModel modelWithDictionary:values];
                        NSMutableArray *homeAd_array = [NSMutableArray array];
                        [homeAd_array addObject:values];
                        [_event_storage setValue:[NSArray arrayWithArray:homeAd_array] forKey:kStringWithFormat(@"%ld", (long)HomeAdEvent)];
                        kSaveStandardUserDefaults([new_adModel modelToJSONObject], @"HOMEAD");
                        kStandardUserDefaultsSync;
                    } else {
                        
                    }
                } else {
                    if (block_param.userInfo) {
                        NSMutableDictionary *values = [NSMutableDictionary dictionaryWithDictionary:block_param.userInfo];
                        [values setValue:[[NSDate date] dateFormateWithString:@"yyyy-MM-dd"] forKey:@"addtime"];
                        HomeAdModel *new_adModel = [HomeAdModel modelWithDictionary:values];
                        NSMutableArray *homeAd_array = [NSMutableArray array];
                        [homeAd_array addObject:values];
                        [_event_storage setValue:[NSArray arrayWithArray:homeAd_array] forKey:kStringWithFormat(@"%ld", (long)HomeAdEvent)];
                        kSaveStandardUserDefaults([new_adModel modelToJSONObject], @"HOMEAD");
                        kStandardUserDefaultsSync;
                    }
                }
            } else {
                if (block_param.userInfo) {
                    NSMutableDictionary *values = [NSMutableDictionary dictionaryWithDictionary:block_param.userInfo];
                    [values setValue:[[NSDate date] dateFormateWithString:@"yyyy-MM-dd"] forKey:@"addtime"];
                    HomeAdModel *new_adModel = [HomeAdModel modelWithDictionary:values];
                    NSMutableArray *homeAd_array = [NSMutableArray array];
                    [homeAd_array addObject:values];
                    [_event_storage setValue:[NSArray arrayWithArray:homeAd_array] forKey:kStringWithFormat(@"%ld", (long)HomeAdEvent)];
                    kSaveStandardUserDefaults([new_adModel modelToJSONObject], @"HOMEAD");
                    kStandardUserDefaultsSync;
                }
                
            }
        }
            break;
        case PushNoticeEvent: {
            NSDictionary *values = block_param.userInfo;
            NSMutableArray *homeAd_array = [NSMutableArray arrayWithArray:[_event_storage objectForKey:kStringWithFormat(@"%ld", (long)PushNoticeEvent)]];
            [homeAd_array addObject:values];
            [_event_storage setValue:[NSArray arrayWithArray:homeAd_array] forKey:kStringWithFormat(@"%ld", (long)PushNoticeEvent)];
        }
            break;
        case MessageNoticeEvent: {
            NSDictionary *values = block_param.userInfo;
            NSMutableArray *homeAd_array = [NSMutableArray arrayWithArray:[_event_storage objectForKey:kStringWithFormat(@"%ld", (long)MessageNoticeEvent)]];
            [homeAd_array addObject:values];
            [_event_storage setValue:[NSArray arrayWithArray:homeAd_array] forKey:kStringWithFormat(@"%ld", (long)MessageNoticeEvent)];
        }
            break;
        case PageJumpEvent: {
            NSDictionary *values = block_param.userInfo;
            NSMutableArray *homeAd_array = [NSMutableArray arrayWithArray:[_event_storage objectForKey:kStringWithFormat(@"%ld", (long)PageJumpEvent)]];
            [homeAd_array addObject:values];
            [_event_storage setValue:[NSArray arrayWithArray:homeAd_array] forKey:kStringWithFormat(@"%ld", (long)PageJumpEvent)];
        }
            break;
        case OpenAdEvent: {
            NSDictionary *values = block_param.userInfo;
            NSMutableArray *homeAd_array = [NSMutableArray arrayWithArray:[_event_storage objectForKey:kStringWithFormat(@"%ld", (long)OpenAdEvent)]];
            [homeAd_array addObject:values];
            [_event_storage setValue:[NSArray arrayWithArray:homeAd_array] forKey:kStringWithFormat(@"%ld", (long)OpenAdEvent)];
        }
            break;
        case SYSNoticeEvent: {
            NSDictionary *values = block_param.userInfo;
            NSMutableArray *homeAd_array = [NSMutableArray arrayWithArray:[_event_storage objectForKey:kStringWithFormat(@"%ld", (long)SYSNoticeEvent)]];
            [homeAd_array addObject:values];
            [_event_storage setValue:[NSArray arrayWithArray:homeAd_array] forKey:kStringWithFormat(@"%ld", (long)SYSNoticeEvent)];
        }
            break;
        case DIYEvent: {
            DIYEventModel *values = block_param.diy_data;
            NSMutableArray *homeAd_array = [NSMutableArray arrayWithArray:[_event_storage objectForKey:kStringWithFormat(@"%ld", (long)DIYEvent)]];
            [homeAd_array addObject:values];
            [_event_storage setValue:[NSArray arrayWithArray:homeAd_array] forKey:kStringWithFormat(@"%ld", (long)DIYEvent)];
        }
            break;
        default:
            break;
    }
}

#pragma mark - 读取事件类型最新事件
- (id)readEventWithType:(EventHandlerModelType)type
{
    switch (type) {
        case HomeAdEvent: {
            NSArray *home_ad_events = [_event_storage objectForKey:kStringWithFormat(@"%ld", (long)HomeAdEvent)];
            if (home_ad_events != nil && home_ad_events.count > 0) {
                if (kStandardUserDefaultsObject(@"HOMEAD")) {
                    NSDictionary *old_adModel = kStandardUserDefaultsObject(@"HOMEAD");
                    NSDate *add_date = [NSDate dateWithString:kStringWithFormat(@"%@", [old_adModel valueForKey:@"addtime"]) format:@"yyyy-MM-dd"];
                    if ([NSDate daysFromLotteryDate:add_date CurrentDate:[NSDate date]] > 1) {
                        return nil;
                    } else {
                        return old_adModel;
                    }
                } else {
                    return nil;
                }
            } else {
                return nil;
            }
        }
            break;
        case PushNoticeEvent: {
            NSArray *push_ad_events = [_event_storage objectForKey:kStringWithFormat(@"%ld", (long)PushNoticeEvent)];
            if (push_ad_events != nil && push_ad_events.count > 0) {
                return push_ad_events[0];
            } else {
                return nil;
            }
        }
            break;
        case MessageNoticeEvent: {
            NSArray *message_ad_events = [_event_storage objectForKey:kStringWithFormat(@"%ld", (long)MessageNoticeEvent)];
            if (message_ad_events != nil && message_ad_events.count > 0) {
                return message_ad_events[0];
            } else {
                return nil;
            }
        }
            break;
        case PageJumpEvent: {
            NSArray *page_ad_events = [_event_storage objectForKey:kStringWithFormat(@"%ld", (long)PageJumpEvent)];
            if (page_ad_events != nil && page_ad_events.count > 0) {
                return page_ad_events[0];
            } else {
                return nil;
            }
        }
            break;
        case OpenAdEvent: {
            NSArray *open_ad_events = [_event_storage objectForKey:kStringWithFormat(@"%ld", (long)OpenAdEvent)];
            if (open_ad_events != nil && open_ad_events.count > 0) {
                return open_ad_events[0];
            } else {
                return nil;
            }
        }
            break;
        case SYSNoticeEvent: {
            NSArray *sysnotice_events = [_event_storage objectForKey:kStringWithFormat(@"%ld", (long)SYSNoticeEvent)];
            if (sysnotice_events != nil && sysnotice_events.count > 0) {
                return sysnotice_events[0];
            } else {
                return nil;
            }
        }
            break;
        case DIYEvent: {
            NSArray *diy_events = [_event_storage objectForKey:kStringWithFormat(@"%ld", (long)DIYEvent)];
            if (diy_events != nil && diy_events.count > 0) {
                return diy_events[0];
            } else {
                return nil;
            }
        }
            break;
        default:
            return nil;
            break;
    }
}

#pragma mark - 事件完成后清除事件
- (void)finishEventWithString:(id)event
                   EventsType:(EventHandlerModelType)type
{
    NSMutableArray *events_array = [NSMutableArray arrayWithArray:[_event_storage objectForKey:kStringWithFormat(@"%ld", (long)type)]];
    if (events_array.count > 0 && [events_array containsObject:event]) {
        [events_array removeObject:event];
        [_event_storage setValue:events_array forKey:kStringWithFormat(@"%ld", (long)type)];
    }
}

#pragma mark - 某个事件类型下的所有事件
- (NSArray *)allEventsWithType:(EventHandlerModelType)type
{
    return [NSArray arrayWithArray:[_event_storage objectForKey:kStringWithFormat(@"%ld", (long)type)]];
}

#pragma mark - 删除某个类型下的所有事件
- (void)removeAllEventWithType:(EventHandlerModelType)type
{
    NSMutableArray *events_array = [NSMutableArray arrayWithArray:[_event_storage objectForKey:kStringWithFormat(@"%ld", (long)type)]];
    if (events_array.count > 0) {
        [events_array removeAllObjects];
        [_event_storage setValue:@[] forKey:kStringWithFormat(@"%ld", (long)type)];
    }
}


@end
