//
//  CXUserManager.m
//  CXWeibo
//
//  Created by 陈擎霄 on 15/12/30.
//  Copyright © 2015年 chenqingxiao007. All rights reserved.
//

#import "CXUserManager.h"
#import "CXStatus.h"

@implementation CXUserManager

- (instancetype)initWithDic:(NSDictionary *)dic{
    if (self = [super init]) {
        self.online_status = (long long)[dic valueForKey:@"online_status"];
        self.location = [dic valueForKey:@"statuses_count"];
        self.statuses_count = (long)[dic valueForKey:@"in_reply_to_screen_name"];
        self.province = [dic valueForKey:@"province"];
        self.url = [dic valueForKey:@"url"];
        self.allow_all_act_msg = [dic valueForKey:@"allow_all_act_msg"];
        self.friends_count = (long)[dic valueForKey:@"friends_count"];
        self.follow_me = [dic valueForKey:@"follow_me"];
        self.city = [dic valueForKey:@"city"];
        self.bi_followers_count = (NSInteger)[dic valueForKey:@"bi_followers_count"];
        self.name = [dic valueForKey:@"name"];
        self.screen_name = [dic valueForKey:@"screen_name"];
        self.verified_reason = [dic valueForKey:@"verified_reason"];
        
        self.verified = [dic valueForKey:@"verified"];
        self.domain = [dic valueForKey:@"domain"];
        self.id = (NSInteger)[dic valueForKey:@"id"];
        self.gender = [dic valueForKey:@"gender"];
        self.allow_all_comment = [dic valueForKey:@"allow_all_comment"];
        self.geo_enabled = [dic valueForKey:@"geo_enabled"];
        self.followers_count = (NSInteger)[dic valueForKey:@"followers_count"];
        self.following = [dic valueForKey:@"following"];
        self.created_at = [dic valueForKey:@"created_at"];
        self.description_CXWeibo = [dic valueForKey:@"description_CXWeibo"];
        self.status = [[CXStatus alloc] initWithDic:[dic valueForKey:@"status"]];
//
    }
    return self;
}

@end


