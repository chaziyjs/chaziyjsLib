//
//  NSCalendar+Calculation.h
//  WetalkCommunity
//
//  Created by chaziyjs on 2017/11/24.
//  Copyright © 2017年 chaziyjs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSCalendar (Calculation)

- (NSInteger)yearOfDate:(NSDate *)date;

- (NSInteger)monthOfDate:(NSDate *)date;

- (NSInteger)dayOfDate:(NSDate *)date;

- (NSInteger)weekdayOfDate:(NSDate *)date;

- (NSInteger)weekOfDate:(NSDate *)date;

- (NSDate *)tomorrowOfDate:(NSDate *)date;

- (NSDate *)yesterdayOfDate:(NSDate *)date;

- (NSDate *)getAMonthframDate:(NSDate*)date months:(NSInteger)number;

- (NSInteger)getNextNMonthForDays:(NSDate * )date;

@end
