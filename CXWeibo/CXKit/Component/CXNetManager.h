//
//  CXNetManager.h
//  CXZhihuDaily
//
//  Created by 陈擎霄 on 15/12/1.
//  Copyright © 2015年 chenqingxiao007. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CXNetManager : NSObject


/**
 *  get请求
 *
 *  @param url     请求地址
 *  @param params  参数
 *  @param success 请求成功回调
 *  @param failure 请求失败回调
 */
+ (void)getWithUrl:(NSString *)url params:(NSDictionary *)params success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

/**
 *  post请求
 *
 *  @param url     请求地址
 *  @param params  参数
 *  @param success 请求成功回调
 *  @param failure 请求失败回调
 */

+ (void)postWithUrl:(NSString *)url params:(NSDictionary *)params success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

/**
 *  网络管理单例
 *
 */
+ (instancetype)sharedNetManager;



@end














