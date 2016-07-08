//
//  ZTabbarController.m
//  ChatTest
//
//  Created by crfchina-mac-mini-1000 on 16/6/21.
//  Copyright © 2016年 crfchina-mac-mini-1000. All rights reserved.
//

#import "ZTabbarController.h"

//宏
#define kClassKey @"rootVCClassString"
#define kTitleKey @"title"
#define kImgKey @"imageName"
#define kSelImgKey  @"selectedImageName"


#import "ZBaseNavigationController.h"
#import "CXHomeViewController.h"
#import "CXMessageViewController.h"
#import "CXSearchViewController.h"
#import "CXPersonalViewController.h"
@interface ZTabbarController ()

@end

@implementation ZTabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *childItemsArray = @[
                                 @{kClassKey:@"CXHomeViewController",
                                   kTitleKey:@"首页",
                                   kImgKey:@"tabbar_home",
                                   kSelImgKey:@"tabbar_home_selected"},
                                 
                                 @{kClassKey:@"CXSearchViewController",
                                   kTitleKey:@"消息",
                                
                                   kImgKey:@"tabbar_message_center",
                                   kSelImgKey:@"tabbar_message_center_selected"},
                                 
                                 @{kClassKey:@"CXSearchViewController",
                                   kTitleKey:@"发现",
                                   kImgKey:@"tabbar_discover",
                                   kSelImgKey:@"tabbar_discover_selected"},
                                 
                                 @{kClassKey:@"CXPersonalViewController",
                                   kTitleKey:@"我",
                                   kImgKey:@"tabbar_profile",
                                   kSelImgKey:@"tabbar_profile_selected"}
                                 ];
    
    [childItemsArray enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL *stop){
        UIViewController *vc = [NSClassFromString(dict[kClassKey]) new];
        vc.title = dict[kTitleKey];
        ZBaseNavigationController *nav = [[ZBaseNavigationController alloc]initWithRootViewController:vc];
        UITabBarItem *item = nav.tabBarItem;
        item.title = dict[kTitleKey];
        item.image = [UIImage imageNamed:dict[kImgKey]];
        item.selectedImage = [[UIImage imageNamed:dict[kSelImgKey]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];//去除蒙版
        [item setTitleTextAttributes:@{NSForegroundColorAttributeName :[UIColor orangeColor]} forState:UIControlStateSelected];//选中颜色
        [self addChildViewController:nav];
    }];
}



@end
