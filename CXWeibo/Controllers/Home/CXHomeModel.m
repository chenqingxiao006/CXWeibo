//
//  CXHomeModel.m
//  CXWeibo
//
//  Created by 陈擎霄 on 16/1/7.
//  Copyright © 2016年 chenqingxiao007. All rights reserved.
//

#import "CXHomeModel.h"
#import "CXHomeStatue.h"

@implementation CXHomeModel

- (instancetype)initWithDic:(NSDictionary *)dic{
    if (self = [super init]) {
        self.homeStatuses = [[NSMutableArray alloc] init];
        NSArray *array = [dic valueForKey:@"statuses"];
        
        for (NSDictionary *statueDic in array) {
            CXHomeStatue *statue = [[CXHomeStatue alloc] initWithDic:statueDic];
            
            
            [self.homeStatuses addObject:statue];
        }
        
    }
    return self;
}

@end
