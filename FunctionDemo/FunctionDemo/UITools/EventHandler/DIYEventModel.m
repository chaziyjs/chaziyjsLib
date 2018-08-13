//
//  DIYEventModel.m
//  WetalkCommunity
//
//  Created by chaziyjs on 2017/11/14.
//  Copyright © 2017年 chaziyjs. All rights reserved.
//

#import "DIYEventModel.h"

@implementation DIYEventModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.className = [self className]; //默认情况下是model本身
    }
    return self;
}

@end
