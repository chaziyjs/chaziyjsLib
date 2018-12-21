//
//  CustomTextField.m
//  GeekRabbit
//
//  Created by FoxDog on 2018/11/14.
//  Copyright © 2018 FoxDog. All rights reserved.
//

#import "CustomTextField.h"

@implementation CustomTextField

- (CGRect)placeholderRectForBounds:(CGRect)bounds {
    return CGRectMake(16.f, 0, bounds.size.width, bounds.size.height);
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    return CGRectMake(16.f, 0, bounds.size.width, bounds.size.height);
}

- (CGRect)textRectForBounds:(CGRect)bounds {
    return CGRectMake(16.f, 0, bounds.size.width, bounds.size.height);
}

@end
