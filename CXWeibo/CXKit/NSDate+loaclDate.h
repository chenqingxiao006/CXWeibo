//
//  NSDate+loaclDate.h
//  CXWeibo
//
//  Created by 陈擎霄 on 16/1/11.
//  Copyright © 2016年 chenqingxiao007. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (loaclDate)

/** UTC时间转化为NSDate */
+ (NSDate *)dateWithUtcTimeString:(NSString *)str;

@end
