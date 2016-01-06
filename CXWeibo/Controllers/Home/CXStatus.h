//
//  CXStatus.h
//  CXWeibo
//
//  Created by 陈擎霄 on 15/12/30.
//  Copyright © 2015年 chenqingxiao007. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CXStatus : NSObject

@property (nonatomic, assign) long long id;

@property (nonatomic, copy) NSString *mid;

@property (nonatomic, copy) NSString *created_at;

@property (nonatomic, copy) NSString *in_reply_to_screen_name;

@property (nonatomic, copy) NSString *source;

@property (nonatomic, copy) NSString *in_reply_to_status_id;

@property (nonatomic, copy) NSString *geo;

@property (nonatomic, strong) NSArray *annotations;

@property (nonatomic, copy) NSString *in_reply_to_user_id;

@property (nonatomic, copy) NSString *text;

@property (nonatomic, assign) BOOL favorited;

@property (nonatomic, assign) BOOL truncated;

@property (nonatomic, assign) NSInteger comments_count;

@property (nonatomic, assign) NSInteger reposts_count;

@end
