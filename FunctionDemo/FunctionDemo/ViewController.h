//
//  ViewController.h
//  FunctionDemo
//
//  Created by chaziyjs on 2018/4/8.
//  Copyright © 2018年 chaziyjs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+Corner.h"
#import "TestObject.h"
#import "ScrollViewController.h"

@interface ViewController : UIViewController

@property (nonatomic, strong) NSValue *objects;
@property (nonatomic, strong) TestObject *test;

@end

