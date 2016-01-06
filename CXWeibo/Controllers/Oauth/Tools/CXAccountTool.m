//
//  CXAccountTool.m
//  CXWeibo
//
//  Created by 陈擎霄 on 15/12/16.
//  Copyright © 2015年 chenqingxiao007. All rights reserved.
//

#import "CXAccountTool.h"
// 文件保存路径
#define kFile [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"account.data"]


@implementation CXAccountTool

- (id)init
{
    if (self = [super init]) {
        _account = [NSKeyedUnarchiver unarchiveObjectWithFile:kFile];
    }
    return self;
}

+ (instancetype)shareAccountTool{
    static id sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}

- (void)saveAccount:(CXAccount *)account
{
    _account = account;
    [NSKeyedArchiver archiveRootObject:account toFile:kFile];
}


@end
