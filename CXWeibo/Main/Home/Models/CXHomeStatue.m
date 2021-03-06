//
//  CXHomeStatue.m
//  CXWeibo
//
//  Created by 陈擎霄 on 16/1/7.
//  Copyright © 2016年 chenqingxiao007. All rights reserved.
//

#import "CXHomeStatue.h"

@implementation CXHomeStatue

- (instancetype)initWithDic:(NSDictionary *)dic{
    if (self = [super init]) {
       
        NSDictionary *userInfoDic = [dic valueForKey:@"user"];
        
        self.profile_image_url = [userInfoDic valueForKey:@"profile_image_url"];
        self.screen_name = [userInfoDic valueForKey:@"screen_name"];
        self.text = [dic valueForKey:@"text"];
        self.thumbnail_pic = [dic valueForKey:@"thumbnail_pic"];
        self.pic_urls = [dic valueForKey:@"pic_urls"];
        self.created_at = [dic valueForKey:@"created_at"];

    }
    return self;
}

@end
