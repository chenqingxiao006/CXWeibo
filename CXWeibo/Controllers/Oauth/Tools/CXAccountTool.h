//
//  CXAccountTool.h
//  CXWeibo
//
//  Created by 陈擎霄 on 15/12/16.
//  Copyright © 2015年 chenqingxiao007. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CXAccount.h"

@interface CXAccountTool : NSObject

// 获得当前账号
@property (nonatomic, readonly) CXAccount *account;

/**
 *  保存当前账号到沙盒
 *
 */
- (void)saveAccount:(CXAccount *)account;


/**
 *  保存账号单例
 *
 */
+ (instancetype)shareAccountTool;

@end
