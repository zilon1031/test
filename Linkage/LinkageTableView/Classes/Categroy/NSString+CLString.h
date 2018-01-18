//
//  NSString+CLString.h
//  ksptproject
//
//  Created by Mac on 2017/11/13.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSString (CLString)

+(int) getWHint:(int)value;

+ (BOOL)isBlankString:(NSString *)str;
//计算字符串一行的长度，当字符串不换行的情况下
+(float) getContentMaxWidth:(NSString *)content FontSize:(int)fontsize;
//计算字符串在给定宽度下的高度
+(float) getContentHeight:(NSString *)content Width:(float)width FontSize:(int)fontsize;


/*  获取有话说显示时间的格式：
 *  当天 显示具体时和分，采用24小时显示制。 如 09:45
 *   一周以内，显示星期几+时分； 如  星期一  15:20
 *   一周以上，显示年月日+时分；  如    2017-04-13 21:00
 *  输入时间（dateStr）格式  yyyy-MM-dd HH:mm
 */
+ (NSString *)getYHSChatTime:(NSString *)dateStr;
//  输入时间格式  NSTimeInterval
+ (NSString *)getYHSChatTimestamp:(NSTimeInterval)timeInterval;
//根据输入的日期，获取当天是星期几。  输入时间（dateStr）格式  yyyy-MM-dd
+ (NSString *)getWhatDayOfTheWeekByDateString:(NSString *)dateStr;
//将NSTimeInterval变量转换成格式化的日期
+(NSString *)changeTimestampToDate:(NSTimeInterval)timeInterval;
//判断两个时间是否间隔3min。 相隔时间超过3min，return YES，反之 return NO。
+ (BOOL)isIntervalTimeOverThreeMinutes:(NSTimeInterval)timeInterval preTimeInterval:(NSTimeInterval)preTimeInterval;
@end
