//
//  NSDate+ANDate.m
//  时间和时间戳的相互转换
//
//  Created by PENG BAI on 15/8/12.
//  Copyright (c) 2015年 bp1010. All rights reserved.
//

#import "NSDate+ANDate.h"

@implementation NSDate (ANDate)

/***
 功能：将时间转换为时时间戳
 
 date：时间
 
 返回值：时间戳
 */
+ (NSInteger)timestampWithDate:(NSDate *)date
{
    return [date timeIntervalSince1970];
}


/***
 功能：将时间戳转换成时间
 
 timestamp：时间戳
 
 返回值：时间
 */
+ (NSDate *)dateWithTimestamp:(NSInteger)timestamp
{
    return [NSDate dateWithTimeIntervalSince1970:timestamp];
}


/***
 功能：将global时间转换为本地时间
 
 date：global时间
 
 返回值：本地时间
 */
+ (NSDate *)localDateWithGlobalDate:(NSDate *)date
{
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    
    NSInteger interval = [zone secondsFromGMTForDate:date];
    
    NSDate *localeDate = [date  dateByAddingTimeInterval: interval];
    
    return localeDate;
}

/***
 功能：将时间转换为格式化字符串
 
 参数：
 date：时间
 dateFormatterStyle：格式化类型
 
 返回值：格式化时间字符串
 */

+ (NSString *)stringDateWithDate:(NSDate *)date dateFormatterStyle:(ANDateFormatterStyle)dateFormatterStyle
{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];//格式化
    
    switch (dateFormatterStyle) {
        case ANDateFormatterStyle_yyyy_MM_dd:
            
            [df setDateFormat:@"yyyy-MM-dd"];
            break;
            
        case ANDateFormatterStyle_Year_Month_Day:
            [df setDateFormat:@"yyyy年MM月dd日"];
            break;
            
        case ANDateFormatterStyle_Year_Month_Day_Hour_Minute_Second:
            [df setDateFormat:@"yyyy年MM月dd日 HH时mm分ss秒"];
            break;
            
        case ANDateFormatterStyle_yyyy_MM_dd_HH_mm:
            
            [df setDateFormat:@"yyyy-MM-dd HH:mm"];
            break;
            
        case ANDateFormatterStyle_yyyyPMMPdd:
            
            [df setDateFormat:@"yyyy.MM.dd"];
            break;
            
        default:
            [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            break;
    }
    
    NSString *stringDate = [df stringFromDate:date];
    
    return stringDate;
}

/***
 功能：获取时分字符串：09:22
 
 */

+ (NSString *)timeStringWithDate:(NSDate *)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:(NSCalendarUnitHour | NSCalendarUnitMinute) fromDate:date];
    
    NSInteger hour = [components hour];
    NSInteger minute = [components minute];
    
    NSString *hourStr;
    if (hour < 10) {
        hourStr = [NSString stringWithFormat:@"0%ld:", hour];
    } else {
        hourStr = [NSString stringWithFormat:@"%ld:", hour];
    }
    
    NSString *minuteStr;
    if (minute < 10) {
        minuteStr = [NSString stringWithFormat:@"0%ld", minute];
    } else {
        minuteStr = [NSString stringWithFormat:@"%ld", minute];
    }
    
    return [hourStr stringByAppendingString:minuteStr];
}

+ (NSString *)hourMSStringWithDate:(NSDate *)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:(NSCalendarUnitHour | NSCalendarUnitMinute |NSCalendarUnitSecond) fromDate:date];
    
    NSInteger hour = [components hour] - 8;
    NSInteger minute = [components minute];
    NSInteger second = [components second];
    
    NSString *hourStr;
    
    if (hour < 10) {
        hourStr = [NSString stringWithFormat:@"0%ld:", hour];
    } else {
        hourStr = [NSString stringWithFormat:@"%ld:", hour];
    }
    
    NSString *minuteStr;
    if (minute < 10) {
        minuteStr = [NSString stringWithFormat:@"0%ld:", minute];
    } else {
        minuteStr = [NSString stringWithFormat:@"%ld:", minute];
    }
    
    NSString *secondStr;
    if (second < 10) {
        secondStr = [NSString stringWithFormat:@"0%ld", second];
    } else {
        secondStr = [NSString stringWithFormat:@"%ld", second];
    }
    
    NSString *timeStr = [[hourStr stringByAppendingString:minuteStr]stringByAppendingString:secondStr];
    
    return timeStr;
}





/***
 功能：计算某个日期经过多少时间后的日期
 
 参数：
 date：指定的日期
 minutes：指多少时间后

 返回值：某个日期经过多少时间后的日期
 
 */

+ (NSDate *)date:(NSDate *)date AfterMinutes:(NSInteger)minutes
{
    NSTimeInterval timeInterval = 60 * minutes;
    
    return [date initWithTimeIntervalSinceNow:timeInterval];
}

/***
 功能：计算几天过了多少时间了
 
 
 */

+ (NSInteger)pastTimeOnToday
{
    NSDate *today = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:(NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond) fromDate:today];
    
    NSInteger hour = [components hour];
    NSInteger minute = [components minute];
    NSInteger second = [components second];
    
    return hour * 3600 + 60 * minute + second;
}


/***
 
 功能：获取目前凌晨日期
 */
+ (NSDate *)zeroHourDate:(NSDate *)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:(NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond) fromDate:date];
    
    NSInteger hour = [components hour];
    NSInteger minute = [components minute];
    NSInteger second = [components second];
    
    NSInteger passTimestamp = hour * 3600 + minute * 60 + second;
    NSInteger dateTimestamp = [self timestampWithDate:date];
    NSInteger zeroHourTimestamp = dateTimestamp - passTimestamp;
    
    return [self dateWithTimestamp:zeroHourTimestamp];
}




/***
 date:选择的日期
 hour:选择的时间
 minute:选择的分钟
 
 返回一个日期时间字符串，类似于：20110527163422（2011-05-27 16:34:22 ）
 
 */
+ (NSString *)stringWithDate:(NSDate *)date hour:(NSInteger)hour minute:(NSInteger)minute
{
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    
    
    NSString *str = nil;
    NSString *monthStr = nil;
    NSString *dayStr = nil;
    NSString *hourStr = nil;
    NSString *minuteStr = nil;
    
    if ([components month] < 10) {
        monthStr = [NSString stringWithFormat:@"0%ld", [components month]];
    } else {
        monthStr = [NSString stringWithFormat:@"%ld", components.month];
    }
    
    if (components.day < 10) {
        dayStr = [NSString stringWithFormat:@"0%ld", components.day];
    } else {
        dayStr = [NSString stringWithFormat:@"%ld", components.day];
    }
    
    if (hour < 10) {
        hourStr = [NSString stringWithFormat:@"0%ld", hour];
    } else {
        hourStr = [NSString stringWithFormat:@"%ld", hour];
    }
    
    if (minute < 10) {
        minuteStr = [NSString stringWithFormat:@"0%ld", minute];
    } else {
        minuteStr = [NSString stringWithFormat:@"%ld", minute];
    }
    
    str = [[NSString stringWithFormat:@"%ld", components.year] stringByAppendingString:[NSString stringWithFormat:@"%@%@%@%@00", monthStr, dayStr, hourStr, minuteStr]];
    
    return str;
}



/***
 dateString:时间字符串，类似于：20110527163422（2011-05-27 16:34:22 ）
 
 返回值：一个时间戳字符串 ：1435398060
 
 */
+ (NSInteger)timestampChangeFromDateString:(NSString *)dateString
{
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];//格式化
    
    [df setDateFormat:@"yyyyMMddHHmmss"];
    [df setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    
    NSDate *date =[[NSDate alloc]init];
    date =[df dateFromString:dateString];
    
    return [self timestampWithDate:date];
}


/***
 功能：获取日期元素
 
 elemen：日期的某个元素
 
 date：日期
 
 返回值：日期元素，如：年 或 月 或...
 
 */

+ (NSInteger)dateElement:(ANDateElement)element date:(NSDate *)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond) fromDate:date];
    
    NSInteger dateElement;
    
    switch (element) {
        case ANDateElementYear:
            
            dateElement = [components year];
            break;
            
            case ANDateElementMonth:
            dateElement = [components month];
            break;
            
            case ANDateElementDay:
            dateElement = [components day];
            break;
            
            case ANDateElementHour:
            dateElement = [components hour];
            break;
            
            case ANDateElementMunute:
            dateElement = [components minute];
            break;
            
            case ANDateElementSecond:
            dateElement = [components second];
            break;
            
        default:
            break;
    }
    
    return dateElement;
}


+ (NSString *)weekFromDateString:(NSString *)dateString
{
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc]init];
    [inputFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *inputDate = [inputFormatter dateFromString:dateString];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSCalendarUnitYear |
    NSCalendarUnitMonth |
    NSCalendarUnitDay |
    NSCalendarUnitWeekday |
    NSCalendarUnitHour |
    NSCalendarUnitMinute |
    NSCalendarUnitSecond;
    
    comps = [calendar components:unitFlags fromDate:inputDate];

    NSString *week = @"";
    switch ([comps weekday]) {
        case 1:
            week = @"星期天";
            break;
        case 2:
            week = @"星期一";
            break;
        case 3:
            week = @"星期二";
            break;
        case 4:
            week = @"星期三";
            break;
        case 5:
            week = @"星期四";
            break;
        case 6:
            week = @"星期五";
            
            break;
        case 7:
            week = @"星期六";
            break;
            
        default:
            break;
    }
    return week;
}

+ (NSDate *)dateFromDateString:(NSString *)dateString
{
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc]init];
    [inputFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *date = [inputFormatter dateFromString:dateString];
    
    return date;
}


@end
