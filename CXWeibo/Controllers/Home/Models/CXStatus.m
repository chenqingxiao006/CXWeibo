//
//  CXStatus.m
//  CXWeibo
//
//  Created by 陈擎霄 on 15/12/30.
//  Copyright © 2015年 chenqingxiao007. All rights reserved.
//

#import "CXStatus.h"

@interface CXStatus ()

@end

@implementation CXStatus

- (instancetype)initWithDic:(NSDictionary *)dic{
    if (self = [super init]) {
        self.id = (long long)[dic valueForKey:@"id"];
        self.created_at = [dic valueForKey:@"created_at"];
        self.mid = [dic valueForKey:@"in_reply_to_screen_name"];
        self.mid = [dic valueForKey:@"source"];
        self.mid = [dic valueForKey:@"in_reply_to_status_id"];
        self.mid = [dic valueForKey:@"geo"];
        self.mid = [dic valueForKey:@"annotations"];
        self.mid = [dic valueForKey:@"in_reply_to_user_id"];
        self.mid = [dic valueForKey:@"text"];
        self.mid = [dic valueForKey:@"favorited"];
        self.mid = [dic valueForKey:@"truncated"];
        self.mid = [dic valueForKey:@"comments_count"];
        self.mid = [dic valueForKey:@"reposts_count"];
        
    }
    return self;
}

@end
