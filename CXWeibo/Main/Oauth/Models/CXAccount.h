//
//  CXAccount.h
//  CXWeibo
//
//  Created by 陈擎霄 on 15/12/16.
//  Copyright © 2015年 chenqingxiao007. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "CXUserManager.h"

@interface CXAccount : NSObject
/**
 *  用户信息字典
 */
@property (strong, nonatomic) NSDictionary *dic;

@property (strong, nonatomic) CXUserManager *userManager;

/**
 *  accessToken
 */
@property (nonatomic, copy) NSString *access_token;

/**
 *  用户ID
 */
@property (nonatomic, copy) NSString *uid;

/**
 *  授权过期时间
 */
@property (nonatomic, copy) NSString *expires_in;

/**
 *   授权过期提醒时间
 */
@property (nonatomic, copy) NSString *remind_in;

/**
 *  创建账号
 *
 *  @param dic 账号信息字典
 *
 */
+ (instancetype)accountWithDic:(NSDictionary *)dic;

@end
