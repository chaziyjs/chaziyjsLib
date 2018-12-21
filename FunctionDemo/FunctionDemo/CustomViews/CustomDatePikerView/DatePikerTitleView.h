//
//  DatePikerTitleView.h
//  GeekRabbit
//
//  Created by FoxDog on 2018/12/4.
//  Copyright © 2018 FoxDog. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DatePikerTitleView : UIView

@property (nonatomic, strong) UIButton *leftBarItem;
@property (nonatomic, strong) UIButton *rightBarItem;

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *detail;

@end

NS_ASSUME_NONNULL_END
