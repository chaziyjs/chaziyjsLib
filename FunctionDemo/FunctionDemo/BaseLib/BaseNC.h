//
//  BaseNC.h
//  WetalkCommunity
//
//  Created by chaziyjs on 2017/9/15.
//  Copyright © 2017年 chaziyjs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseNC : UINavigationController<UINavigationControllerDelegate, UIGestureRecognizerDelegate>

@property (nonatomic, assign) NSInteger index;

@end
