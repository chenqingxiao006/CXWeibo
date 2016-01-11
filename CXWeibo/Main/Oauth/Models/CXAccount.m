//
//  CXAccount.m
//  CXWeibo
//
//  Created by 陈擎霄 on 15/12/16.
//  Copyright © 2015年 chenqingxiao007. All rights reserved.
//

#import "CXAccount.h"
#import "CXNetManager.h"

@implementation CXAccount

+ (instancetype)accountWithDic:(NSDictionary *)dic{

    CXAccount *account = [[CXAccount alloc] init];
    account.access_token = [dic valueForKey:@"access_token"];
    account.uid = [dic valueForKey:@"uid"];
    account.expires_in = [dic valueForKey:@"expires_in"];
    account.remind_in = [dic valueForKey:@"remind_in"];
    
      
    return account;
}

#pragma mark 归档的时候调用
- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:_access_token forKey:@"access_token"];
    [encoder encodeObject:_uid forKey:@"uid"];
    [encoder encodeObject:_uid forKey:@"expires_in"];
    [encoder encodeObject:_uid forKey:@"remind_in"];
    
    
    [encoder encodeObject:_dic forKey:@"userManager"];
    /*
     "expires_in" = 157679999; 过期时间
     "remind_in" = 157679999;  过期提醒时间
     */

}

- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init]) {
        self.access_token = [decoder decodeObjectForKey:@"access_token"];
        self.uid = [decoder decodeObjectForKey:@"uid"];
        self.expires_in = [decoder decodeObjectForKey:@"expires_in"];
        self.remind_in = [decoder decodeObjectForKey:@"remind_in"];
        self.dic = [decoder decodeObjectForKey:@"userManager"];
    }
    return self;
}

- (CXUserManager *)userManager{
    if (!_userManager) {
        _userManager = [[CXUserManager alloc] initWithDic:self.dic];
    }
    return _userManager;
}



@end
