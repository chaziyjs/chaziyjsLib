//
//  PayAlertAction.m
//  AnywideConvenience
//
//  Created by chaziyjs on 2018/6/15.
//  Copyright © 2018年 Anywide1948. All rights reserved.
//

#import "PayAlertAction.h"

@implementation PayAlertAction

+ (PayAlertAction *)actionWithTitle:(NSString *)title Style:(PayAlertActionType)actionType Action:(AlertActionBlock)action
{
    PayAlertAction *alertAction = [PayAlertAction new];
    alertAction.actionTitle = title;
    alertAction.callback = action;
    alertAction.type = actionType;
    return alertAction;
}

@end
