//
//  CXTabBar.m
//  CXWeibo
//
//  Created by 陈擎霄 on 15/12/17.
//  Copyright © 2015年 chenqingxiao007. All rights reserved.
//

#import "CXTabBar.h"

@implementation CXTabBar

- (instancetype)initWithFrame:(CGRect)frame andTabBarNames:(NSArray *)tabBarNames{
    if (self = [super initWithFrame:frame]) {
        
        NSMutableArray *items = [[NSMutableArray alloc] init];
        for (NSString *tabBarName in tabBarNames) {
            UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:tabBarName image:nil tag:1];
            

            
            [items addObject:item];
        }
        [self setItems:items];
        
    }
    return self;
}
@end
