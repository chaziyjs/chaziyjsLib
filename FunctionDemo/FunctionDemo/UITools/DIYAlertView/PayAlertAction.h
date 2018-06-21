//
//  PayAlertAction.h
//  AnywideConvenience
//
//  Created by chaziyjs on 2018/6/15.
//  Copyright © 2018年 Anywide1948. All rights reserved.
//

#import "BaseObject.h"

@class PayAlertAction;
typedef void(^AlertActionBlock)(PayAlertAction *action);

typedef NS_ENUM(NSUInteger, PayAlertActionType)
{
    PayAlertActionDefine        =   1,
    PayAlertActionCancel        =   0
};

@interface PayAlertAction : BaseObject

@property (nonatomic, copy) NSString *actionTitle;
@property (nonatomic, copy) AlertActionBlock callback;
@property (nonatomic, assign) PayAlertActionType type;

+ (PayAlertAction *)actionWithTitle:(NSString *)title Style:(PayAlertActionType)actionType Action:(AlertActionBlock)action;

@end
