//
//  NSDate+ANDate.h
//  时间和时间戳的相互转换
//
//  Created by PENG BAI on 15/8/12.
//  Copyright (c) 2015年 bp1010. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, ANDateFormatterStyle) {
    
    ANDateFormatterStyle_yyyy_MM_dd  =  1001,               // 2015-08-23
    ANDateFormatterStyle_yyyy_MM_dd_HH_mm,                  // 2015-08-23 23:12
    ANDateFormatterStyle_yyyy_MM_dd_HH_mm_ss,               // 2015-08-23 23:12:56
    ANDateFormatterStyle_Year_Month_Day,                    // 2015年8月23日
    ANDateFormatterStyle_Year_Month_Day_Hour_Minute_Second, // 2015年8月23日23时12分56秒
    ANDateFormatterStyle_yyyyPMMPdd                         // 2015.08.23
    
}NS_ENUM_AVAILABLE_IOS(6_0);

typedef NS_ENUM(NSInteger, ANDateElement) {
    
    ANDateElementYear = 101, // 日期元素 年
    ANDateElementMonth,
    ANDateElementDay,
    ANDateElementHour,
    ANDateElementMunute,
    ANDateElementSecond
    
}NS_ENUM_AVAILABLE_IOS(6_0);

@interface NSDate (ANDate)

// 将时间转换为时间戳
+ (NSInteger)timestampWithDate:(NSDate *)date;

// 将时间戳转换为时间
+ (NSDate *)dateWithTimestamp:(NSInteger)timestamp;

// 将时间转换为本地时间
+ (NSDate *)localDateWithGlobalDate:(NSDate *)date;

// 将时间转换为格式字符串
+ (NSString *)stringDateWithDate:(NSDate *)date dateFormatterStyle:(ANDateFormatterStyle)dateFormatterStyle;

// 获取"时:分"字符串
+ (NSString *)timeStringWithDate:(NSDate *)date;

// 时分秒字符串
+ (NSString *)hourMSStringWithDate:(NSDate *)date;

// 多少时间之后的日期
+ (NSDate *)date:(NSDate *)date AfterMinutes:(NSInteger)minutes;


// 计算几天过了多少时间了
+ (NSInteger)pastTimeOnToday;

// 获取目前凌晨日期
+ (NSDate *)zeroHourDate:(NSDate *)date;

/***
 date:选择的日期
 hour:选择的时间
 minute:选择的分钟
 
 返回一个日期时间字符串，类似于：20110527163422（2011-05-27 16:34:22 ）
 
 */
+ (NSString *)stringWithDate:(NSDate *)date hour:(NSInteger)hour minute:(NSInteger)minute;


/***
 dateString:时间字符串，类似于：20110527163422（2011-05-27 16:34:22 ）
 
 返回值：一个时间戳字符串 ：1435398060
 
 */
+ (NSInteger)timestampChangeFromDateString:(NSString *)dateString;


// 得到日期元素
+ (NSInteger)dateElement:(ANDateElement)element date:(NSDate *)date;

/**
 *  根据日期获取星期几
 *
 *  @param dateString 日期字符串 “2012-12-12 00:00:00”
 *
 *  @return 星期几
 */
+ (NSString *)weekFromDateString:(NSString *)dateString;

/**
 *  将日期字符串转化为NSDate
 *
 *  @param dateString 日期字符串
 *
 *  @return 日期对象
 */
+ (NSDate *)dateFromDateString:(NSString *)dateString;


@end
