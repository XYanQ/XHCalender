//
//  XHCalendarTool.h
//  XHCalendar
//
//  Created by sun on 2017/3/14.
//  Copyright © 2017年 xing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XHCalendarTool : NSObject
+ (NSInteger)day:(NSDate *)date;
+ (NSInteger)month:(NSDate *)date;
+ (NSInteger)year:(NSDate *)date;

+ (NSInteger)firstWeekdayInThisMonth:(NSDate *)date;
+ (NSInteger)totaldaysInMonth:(NSDate *)date;

+ (NSDate *)lastMonth:(NSDate *)date;
+ (NSDate*)nextMonth:(NSDate *)date;
+ (NSDate*)goCustomMonth:(NSDate *)date withaddNumber:(NSInteger)num;
@end
