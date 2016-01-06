//
//  CXProgressHUD.m
//  CXZhihuDaily
//
//  Created by 陈擎霄 on 15/12/2.
//  Copyright © 2015年 chenqingxiao007. All rights reserved.
//

#import "CXProgressHUD.h"
#import <MBProgressHUD.h>

@implementation CXProgressHUD



+ (void)showMessage:(NSString *)msg durationTime:(NSTimeInterval)durationTime completionBlock:(void (^)())completion inView:(UIView *)view{
    
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = msg;
    
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, durationTime * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [MBProgressHUD hideHUDForView:view animated:YES];
        if (completion) {
            completion();
        }
    });
}

+ (void)showLoadingInView:(UIView *)view{
    [MBProgressHUD showHUDAddedTo:view animated:YES];
}

+ (void)showLoadingWithMesssage:(NSString *)msg inView:(UIView *)view{
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:view];
    [view addSubview:HUD];
    
    HUD.labelText = msg;
    
    [HUD show:YES];
}

+ (void)hidenForView:(UIView *)view {
    [MBProgressHUD hideAllHUDsForView:view animated:YES];
}


@end









