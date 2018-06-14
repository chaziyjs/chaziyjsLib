//
//  NSCalendar+Calculation.m
//  WetalkCommunity
//
//  Created by chaziyjs on 2017/11/24.
//  Copyright © 2017年 chaziyjs. All rights reserved.
//

#import "NSCalendar+Calculation.h"

@implementation NSCalendar (Calculation)

- (NSInteger)yearOfDate:(NSDate *)date
{
    if (!date) return NSNotFound;
    NSDateComponents *component = [self components:NSCalendarUnitYear fromDate:date];
    return component.year;
}

- (NSInteger)monthOfDate:(NSDate *)date
{
    if (!date) return NSNotFound;
    NSDateComponents *component = [self components:NSCalendarUnitMonth
                                                    fromDate:date];
    return component.month;
}

- (NSInteger)dayOfDate:(NSDate *)date
{
    if (!date) return NSNotFound;
    NSDateComponents *component = [self components:NSCalendarUnitDay
                                                    fromDate:date];
    return component.day;
}

- (NSInteger)weekdayOfDate:(NSDate *)date
{
    if (!date) return NSNotFound;
    NSDateComponents *component = [self components:NSCalendarUnitWeekday fromDate:date];
    return component.weekday;
}

- (NSInteger)weekOfDate:(NSDate *)date
{
    if (!date) return NSNotFound;
    NSDateComponents *component = [self components:NSCalendarUnitWeekOfYear fromDate:date];
    return component.weekOfYear;
}

- (NSDate *)tomorrowOfDate:(NSDate *)date
{
    if (!date) return nil;
    NSDateComponents *components = [self components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour fromDate:date];
    components.day++;
    components.hour = 0;
    return [self dateFromComponents:components];
}

- (NSDate *)yesterdayOfDate:(NSDate *)date
{
    if (!date) return nil;
    NSDateComponents *components = [self components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour fromDate:date];
    components.day--;
    components.hour = 0;
    return [self dateFromComponents:components];
}

- (NSDate *)getAMonthframDate:(NSDate *)date months:(NSInteger)number
{
    NSCalendarUnit _dayInfoUnits  = NSCalendarUnitEra | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *components = [self components:_dayInfoUnits fromDate:date];
    components.day = 1;
    if (number != 0) {
        components.month += number;
    }
    NSDate * nextMonthDate = [self dateFromComponents:components];
    return nextMonthDate;
}

- (NSInteger)getNextNMonthForDays:(NSDate * )date
{
    NSInteger monthNum = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date].length;
    return monthNum;
}


@end
