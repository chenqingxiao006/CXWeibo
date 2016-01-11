//
//  CXNetManager.m
//  CXZhihuDaily
//
//  Created by 陈擎霄 on 15/12/1.
//  Copyright © 2015年 chenqingxiao007. All rights reserved.
//

#import "CXNetManager.h"
#import <AFNetworking/AFNetworking.h>
#import "CXProgressHUD.h"

@implementation CXNetManager


+ (instancetype)sharedNetManager{
    static id sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}


// get请求
+ (void)getWithUrl:(NSString *)url params:(NSDictionary *)params success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure{
    // 1.获得manager
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    // 让AFN支持@"text/plain" 和 application/json
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];

    [manager GET:url parameters:params success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
       
        //请求成功以后,给success(block赋值)
        if (success) {
            success(responseObject);
        }
        
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
            if (error.code == NSURLErrorNotConnectedToInternet) {
                NSLog(@"网络有点不给力");
            }

        }
        
    }];
}

// post请求
+ (void)postWithUrl:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    // 让AFN支持@"text/plain" 和 application/json
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    [manager POST:url parameters:params success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
            if (error.code == NSURLErrorNotConnectedToInternet) {
                NSLog(@"网络有点不给力");
            }

        }
    }];
}

@end























