//
//  NSString+CLString.m
//  ksptproject
//
//  Created by Mac on 2017/11/13.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "NSString+CLString.h"
#define aMinute 60
#define aDay 86400

@implementation NSString (CLString)
//取偶
+(int) getWHint:(int)value
{
    if(value % 2 != 0 )
    {
        value = value +1;
    }
    return value;
}
+ (BOOL)isBlankString:(NSString *)str {
    NSString *string = str;
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] == 0) {
        return YES;
    }
    if ([string rangeOfString:@"(null)"].location != NSNotFound) {
        return YES;
    }
    return NO;
}
//计算字符串一行的长度，当字符串不换行的情况下
+(float) getContentMaxWidth:(NSString *)content FontSize:(int)fontsize {
    NSArray *arr = [content componentsSeparatedByString:@"\n"];
    int maxWidth = 0;
    for(int i = 0; i < [arr count] ; i++){
        NSString *str = [arr objectAtIndex:i];
        
        CGSize size = [str sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontsize]}];
        if(size.width > maxWidth){
            maxWidth = size.width;
        }
    }
    return [self getWHint:(maxWidth + 2)];
}
//计算字符串在给定宽度下的高度
+(float) getContentHeight:(NSString *)content Width:(float)width FontSize:(int)fontsize{
    //此处的换行类型（lineBreakMode）可根据自己的实际情况进行设置
    CGSize sizeToFit = [content boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontsize]} context:nil].size;
    return sizeToFit.height;
}

//  获取当前系统时间，输出格式是YYYY-MM-dd HH:mm
+(NSString *)getCurrentTime {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm"];
    NSDate *currentDate = [NSDate date];
    NSString *currentTimeStr = [formatter stringFromDate:currentDate];
    return currentTimeStr;
}
//判断两个日期是不是同一天。  输入时间（dateStr）格式  yyyy-MM-dd HH:mm
+ (BOOL)judgeSameDayWithDayString:(NSString *)dateString otherDateString:(NSString *)otherDateString {
    NSArray *dateArray = [dateString componentsSeparatedByString:@" "];
    NSArray *otherDateArray = [otherDateString componentsSeparatedByString:@" "];
    NSString *dateStr = [dateArray objectAtIndex:0];
    NSString *otherDateStr = [otherDateArray objectAtIndex:0];
    NSArray *dayArray = [dateStr componentsSeparatedByString:@"-"];
    NSArray *otherDayArray = [otherDateStr componentsSeparatedByString:@"-"];
    NSString *day = [dayArray objectAtIndex:([dayArray count] - 1)];
    NSString *otherDay = [otherDayArray objectAtIndex:([otherDayArray count] - 1)];
    if ([day isEqualToString:otherDay]) {
        return YES;
    } else
        return NO;
}
/*  获取有话说显示时间的格式：
 *  当天 显示具体时和分，采用24小时显示制。 如 09:45
 *   一周以内，显示星期几+时分； 如  星期一  15:20
 *   一周以上，显示年月日+时分；  如    2017-04-13 21:00
 *  输入时间（dateStr）格式  yyyy-MM-dd HH:mm
 */
+ (NSString *)getYHSChatTime:(NSString *)dateStr {
    NSString *time = [NSString stringWithFormat:@""];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSDate *date = [dateFormatter dateFromString:dateStr];

    if (dateFormatter) {
        NSTimeInterval timeSinceLastUpdate = [date timeIntervalSinceNow];
        timeSinceLastUpdate *= -1;
        NSArray *timeArray = [dateStr componentsSeparatedByString:@" "];
        NSString *date = [timeArray objectAtIndex:0];
        NSString *clockStr = [timeArray objectAtIndex:1];
        if (timeSinceLastUpdate < aDay) {
            BOOL isSameDay = [self judgeSameDayWithDayString:dateStr otherDateString: [self getCurrentTime]];
            if (isSameDay) {
                time = clockStr;
            } else {
                NSString *weekDay = [self getWhatDayOfTheWeekByDateString:date];
                time = [NSString stringWithFormat:@"%@ %@", weekDay, clockStr];
            }
        } else if (timeSinceLastUpdate < aDay *7) {
            NSString *weekDay = [self getWhatDayOfTheWeekByDateString:date];
            time = [NSString stringWithFormat:@"%@ %@", weekDay, clockStr];
        } else {
            time = dateStr;
        }
    }
    return time;
}
/*  获取有话说显示时间的格式：
 *  当天 显示具体时和分，采用24小时显示制。 如 09:45
 *   一周以内，显示星期几+时分； 如  星期一  15:20
 *   一周以上，显示年月日+时分；  如    2017-04-13 21:00
 *  输入时间格式  NSTimeInterval
 */
+ (NSString *)getYHSChatTimestamp:(NSTimeInterval)timeInterval {
    NSString *dateStr = [self changeTimestampToDate:timeInterval];
    NSString *time = [self getYHSChatTime:dateStr];
    return time;
}
//根据输入的日期，获取当天是星期几。  输入时间（dateStr）格式  yyyy-MM-dd
+ (NSString *)getWhatDayOfTheWeekByDateString:(NSString *)dateStr {
    NSString *dayStr = [NSString stringWithFormat:@""];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *formatterDate = [dateFormatter dateFromString:dateStr];
    NSDateFormatter *weekFormatter = [[NSDateFormatter alloc] init];
    [weekFormatter setDateFormat:@"EEEE-MMMM-d"];
    NSString *weekStr = [weekFormatter stringFromDate:formatterDate];
    NSArray *weekArray = [weekStr componentsSeparatedByString:@"-"];
    dayStr = [NSString stringWithFormat:@"%@", [weekArray objectAtIndex:0]];
    return dayStr;
}
//将NSTimeInterval变量转换成格式化的日期
+(NSString *)changeTimestampToDate:(NSTimeInterval)timeInterval {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm";
    NSString *dateString = [formatter stringFromDate:date];
    return dateString;
}
//判断两个时间是否间隔3min。 相隔时间超过3min，return YES，反之 return NO。
+ (BOOL)isIntervalTimeOverThreeMinutes:(NSTimeInterval)timeInterval preTimeInterval:(NSTimeInterval)preTimeInterval {
    if ((timeInterval - preTimeInterval) < aMinute * 3) {
        return NO;
    } else
        return YES;
}
@end
