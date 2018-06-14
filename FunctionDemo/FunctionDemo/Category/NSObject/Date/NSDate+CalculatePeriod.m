//
//  NSDate+CalculatePeriod.m
//  WetalkCommunity
//
//  Created by hch on 2017/10/10.
//  Copyright © 2017年 chaziyjs. All rights reserved.
//

#import "NSDate+CalculatePeriod.h"

@implementation NSDate (CalculatePeriod)
- (NSString *)prettyDateWithReference:(NSDate *)reference date:(NSDate *)date {

    float different = [reference timeIntervalSinceDate:date];
    if (different < 0) {
        different = -different;
    }
    // days = different / (24 * 60 * 60), take the floor value
    float dayDifferent = floor(different / 86400);
    // It belongs to today
    if (dayDifferent <= 0) {
        // lower than 60 seconds
        if (different < 60) {
            //            return @"刚刚";
            return @"1分钟前";
        }
        // lower than 60 minutes
        else if (different < 3600) {
            return [NSString stringWithFormat:@"%d分钟前", (int) floor(different / 60)];
        } else if (different < 3600 * 24) {
            return [NSString stringWithFormat:@"%d小时前", (int) floor(different / 60 / 60)];
        } else {
            NSLog(@"时间设置未知异常");
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"YY-MM-dd"];
            NSString *str = [dateFormatter stringFromDate:reference];
            return [NSString stringWithFormat:@"%@", str];
        }
    } else if (dayDifferent > 0 && dayDifferent <= 365) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"MM-dd"];
        NSString *str = [dateFormatter stringFromDate:reference];
        return [NSString stringWithFormat:@"%@", str];
    } else {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"YY-MM-dd"];
        NSString *str = [dateFormatter stringFromDate:reference];
        return [NSString stringWithFormat:@"%@", str];
    }
}

+ (NSString *)convertTime:(float)second
{
    // 相对格林时间
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:second];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    if (second / 3600 >= 1) {
        [formatter setDateFormat:@"HH:mm:ss"];
    } else {
        [formatter setDateFormat:@"mm:ss"];
    }
    
    NSString *showTimeNew = [formatter stringFromDate:date];
    return showTimeNew;
}

+ (NSString *)CalcuLadate:(NSNumber *)reference {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[reference doubleValue]];
    return [date prettyDateWithReference:date date:[NSDate date]];
}

- (NSString *)dateFormateWithString:(NSString *)data_string {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:data_string];
    NSString *str = [dateFormatter stringFromDate:self];
    return [NSString stringWithFormat:@"%@", str];
}

+ (NSString *)dateFormateTimeInterval:(NSTimeInterval)time WithString:(NSString *)data_string {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:data_string];
    NSString *str = [dateFormatter stringFromDate:date];
    return [NSString stringWithFormat:@"%@", str];
}

+ (NSTimeInterval)secFromLotteryDate:(NSDate *)lotDate CurrentDate:(NSDate *)curDate {
    NSTimeInterval distanceBetweenDates = [lotDate timeIntervalSinceDate:curDate];
    return distanceBetweenDates;
}

+ (double)secondFromLotteryDate:(NSDate *)lotDate CurrentDate:(NSDate *)curDate {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    unsigned int unitFlags = NSCalendarUnitSecond;
    NSDateComponents *d = [calendar components:unitFlags fromDate:curDate toDate:lotDate options:0];
    return [d second];
}

+ (NSInteger)daysFromLotteryDate:(NSDate *)lotDate CurrentDate:(NSDate *)curDate {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    unsigned int unitFlags = NSCalendarUnitDay;
    NSDateComponents *d = [calendar components:unitFlags fromDate:curDate toDate:lotDate options:0];
    return [d day];
}

+ (NSDateComponents *)dateFromLotteryDate:(NSDate *)lotDate CurrentDate:(NSDate *)curDate
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    unsigned int unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitWeekday;
    NSDateComponents *d = [calendar components:unitFlags fromDate:curDate toDate:lotDate options:0];
    return d;
}

+ (NSString *)returnYYMMDDHHMMSSDateBy:(NSString *)timestr {
    NSTimeInterval time = [timestr doubleValue];
    NSDate *detaildate = [NSDate dateWithTimeIntervalSince1970:time];
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *currentDateStr = [dateFormatter stringFromDate:detaildate];
    return currentDateStr;
}

+ (NSString *)returnYYMMDDHHMMDateBy:(NSString *)timestr {
    NSTimeInterval time = [timestr doubleValue];
    NSDate *detaildate = [NSDate dateWithTimeIntervalSince1970:time];
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];
    return currentDateStr;
}

+ (NSString *)returnYYMMDDDateBy:(NSString *)timestr {
    NSTimeInterval time = [timestr doubleValue];
    NSDate *detaildate = [NSDate dateWithTimeIntervalSince1970:time];
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];
    return currentDateStr;
}

+(NSString *)CalcuLatodayOrMMdd:(NSNumber*)reference {
    
    NSDate *now = [[NSDate alloc] init];
    
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: now];
//    NSDate *today = [now  dateByAddingTimeInterval: interval];
    
    // 10 first characters of description is the calendar date:
//    NSString * todayString = [[today description] substringToIndex:10];
    NSDate *date = [[NSDate dateWithTimeIntervalSince1970:[reference doubleValue]]dateByAddingTimeInterval:interval];
    
//    NSString * dateString = [[date description] substringToIndex:10];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
//    if ([dateString isEqualToString:todayString]){
//        return [NSString stringWithFormat:@"今天"];
//    }
//    else{
        [dateFormatter setDateFormat:@"Y:M:d"];
        NSString *str = [dateFormatter stringFromDate:[date dateByAddingTimeInterval:-interval]];
        return str;
//    }
    return nil;
}

+ (NSString *)LACalcuLadate:(NSNumber*)reference{
    
    NSTimeInterval secondsPerDay = 24 * 60 * 60;
    NSDate *now = [[NSDate alloc] init];
    
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: now];
    NSDate *today = [now  dateByAddingTimeInterval: interval];
    
    NSDate *yesterday;
    yesterday = [today dateByAddingTimeInterval: -secondsPerDay];
    // 10 first characters of description is the calendar date:
    NSString * todayString = [[today description] substringToIndex:10];
    NSString * yesterdayString = [[yesterday description] substringToIndex:10];
    NSDate *date = [[NSDate dateWithTimeIntervalSince1970:[reference doubleValue]] dateByAddingTimeInterval:interval];
    
    NSString * dateString = [[date description] substringToIndex:10];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    //    FLog(@"***********************************\nrefrernce%@    date %@\ntoday %@,\ntodayString %@,\nyesterday %@,\nyesterdayString %@,\ndate %@,\ndateString %@ \n*****************",reference,date,today,todayString,yesterday,yesterdayString,date,dateString);
    
    if ([dateString isEqualToString:todayString]){
        [dateFormatter setDateFormat:@"HH:mm"];
        NSString *str = [dateFormatter stringFromDate:[date dateByAddingTimeInterval:-interval]];
        return [NSString stringWithFormat:@"今天 %@",str];
    }
    else if ([dateString isEqualToString:yesterdayString]){
        [dateFormatter setDateFormat:@"HH:mm"];
        NSString *str = [dateFormatter stringFromDate:[date dateByAddingTimeInterval:-interval]];
        
        
        return [NSString stringWithFormat:@"昨天 %@",str];
    }
    else{
        [dateFormatter setDateFormat:@"MM-dd HH:mm"];
        NSString *str = [dateFormatter stringFromDate:[date dateByAddingTimeInterval:-interval]];
        return str;
    }
    return nil;
}


+ (BOOL)isSameDay:(long)iTime1 Time2:(long)iTime2 {
    //传入时间毫秒数
    NSDate *pDate1 = [NSDate dateWithTimeIntervalSince1970:iTime1 / 1000];
    NSDate *pDate2 = [NSDate dateWithTimeIntervalSince1970:iTime2 / 1000];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *comp1 = [calendar components:unitFlags fromDate:pDate1];
    NSDateComponents *comp2 = [calendar components:unitFlags fromDate:pDate2];
    
    return [comp1 day] == [comp2 day] &&
    [comp1 month] == [comp2 month] &&
    [comp1 year] == [comp2 year];
}

//获取当前时间戳
+ (NSString *)currentTimeStr{
    NSDate* date = [NSDate dateWithTimeIntervalSinceNow:0];//获取当前时间0秒后的时间
    NSTimeInterval time=[date timeIntervalSince1970]*1000;// *1000 是精确到毫秒，不乘就是精确到秒
    NSString *timeString = [NSString stringWithFormat:@"%.0f", time];
    return timeString;
}


@end
