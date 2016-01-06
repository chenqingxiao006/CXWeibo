//
//  CXUserManager.h
//  CXWeibo
//
//  Created by 陈擎霄 on 15/12/30.
//  Copyright © 2015年 chenqingxiao007. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CXStatus;
@interface CXUserManager : NSObject

@property (nonatomic, assign) NSInteger online_status;

@property (nonatomic, copy) NSString *location;

@property (nonatomic, assign) NSInteger statuses_count;

@property (nonatomic, copy) NSString *province;

@property (nonatomic, copy) NSString *url;

@property (nonatomic, assign) BOOL allow_all_act_msg;

@property (nonatomic, assign) NSInteger friends_count;

@property (nonatomic, assign) BOOL follow_me;

@property (nonatomic, copy) NSString *city;

@property (nonatomic, assign) NSInteger bi_followers_count;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *screen_name;

@property (nonatomic, copy) NSString *verified_reason;

@property (nonatomic, assign) BOOL verified;

@property (nonatomic, copy) NSString *domain;

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, copy) NSString *gender;

@property (nonatomic, assign) BOOL allow_all_comment;

@property (nonatomic, assign) BOOL geo_enabled;

@property (nonatomic, copy) NSString *profile_image_url;

@property (nonatomic, assign) NSInteger followers_count;

@property (nonatomic, assign) BOOL following;

@property (nonatomic, copy) NSString *avatar_large;

@property (nonatomic, copy) NSString *created_at;

@property (nonatomic, assign) NSInteger favourites_count;

@property (nonatomic, copy) NSString *description_CXWeibo;

@property (strong, nonatomic) CXStatus *status;

@end
