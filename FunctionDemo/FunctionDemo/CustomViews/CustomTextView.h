//
//  CustomTextView.h
//  GeekRabbit
//
//  Created by FoxDog on 2018/11/14.
//  Copyright © 2018 FoxDog. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

NS_CLASS_AVAILABLE_IOS(9_0) @interface CustomTextView : UIView

@property (nonatomic, strong) UITextView *textView;

@property (nonatomic, copy) NSString *placeholdText;
@property (nonatomic, strong) UIFont *placeholdFont;
@property (nonatomic, strong) UIColor *placeholdColor;
@property (nonatomic, assign) UIEdgeInsets placeholdEdge;
@property (nonatomic, assign) NSInteger limitCount;
@property (nonatomic, assign) BOOL showLimit;

@end

NS_ASSUME_NONNULL_END
