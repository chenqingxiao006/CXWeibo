//
//  CXProgressHUD.h
//  ;
//
//  Created by 陈擎霄 on 15/12/2.
//  Copyright © 2015年 chenqingxiao007. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CXProgressHUD : UIView


//+ (void)showLoadingInView:(UIView *)view;
//+ (void)showLoadingWithMesssage:(NSString *)msg inView:(UIView *)view;
//+ (void)showLoadingWithMessage:(NSString *)msg detial:(NSString *)detail inView:(UIView *)view;
//+ (void)hidenForView:(UIView *)view;
//
//+ (void)showMessage:(NSString *)msg inView:(UIView *)view;
//+ (void)showSuccessMessage:(NSString *)msg inView:(UIView *)view;
//+ (void)showErrorMessage:(NSString *)msg inView:(UIView *)view;

/**
 *  显示loading 界面
 *
 *  @param msg          内容
 *  @param durationTime 时间
 *  @param completion   完成回调
 *  @param view         在哪个view显示
 */
+ (void)showMessage:(NSString *)msg durationTime:(NSTimeInterval)durationTime completionBlock:(void (^)())completion inView:(UIView *)view;

/**
 *  显示loading
 *
 *  @param view 在哪个view显示
 */
+ (void)showLoadingInView:(UIView *)view;

/**
 *  显示带有文字的loading
 *
 *  @param msg  loading 提示
 *  @param view 在哪个view显示
 */
+ (void)showLoadingWithMesssage:(NSString *)msg inView:(UIView *)view;

/**
 *  隐藏 loading显示
 *
 *  @param view 消失loading
 */
+ (void)hidenForView:(UIView *)view;

@end


























