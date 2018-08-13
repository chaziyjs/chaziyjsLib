//
//  RootTabBC.h
//  WetalkCommunity
//
//  Created by chaziyjs on 2017/9/15.
//  Copyright © 2017年 chaziyjs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseNC.h"
#import "AnimationManager.h"

@interface RootTabBC : UITabBarController<UITabBarControllerDelegate>

+ (instancetype)shareRootTabBC;

@property (readwrite, nonatomic) NSUInteger lastSelectedIndex;
@property (nonatomic, assign) BOOL tabbarIsShow;

- (void)setSelectedIndex:(NSUInteger)selectedIndex;

- (void)setNoticeBadgeValue:(NSUInteger)value;

@end
