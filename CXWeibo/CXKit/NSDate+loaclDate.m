//
//  NSDate+loaclDate.m
//  CXWeibo
//
//  Created by 陈擎霄 on 16/1/11.
//  Copyright © 2016年 chenqingxiao007. All rights reserved.
//

#import "NSDate+loaclDate.h"

@implementation NSDate (loaclDate)

+ (NSDate *)dateWithUtcTimeString:(NSString *)str{
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    [inputFormatter setDateFormat:@"EEE MMM d HH:mm:ss zzzz yyyy"];
    NSLocale * local=[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [inputFormatter setLocale:local];
    
    NSDate *date = [inputFormatter dateFromString:str];
    
    NSLog(@"%@",date);
    return date;
}



@end
