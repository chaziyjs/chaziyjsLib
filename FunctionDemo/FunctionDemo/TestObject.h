//
//  TestObject.h
//  FunctionDemo
//
//  Created by chaziyjs on 2018/6/8.
//  Copyright © 2018年 chaziyjs. All rights reserved.
//

#import "BaseObject.h"

@interface TestObject : BaseObject

@property (nonatomic, strong) NSMutableArray *userList;
@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *userAge;

@end
