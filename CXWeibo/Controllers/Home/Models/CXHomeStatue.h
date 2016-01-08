//
//  CXHomeStatue.h
//  CXWeibo
//
//  Created by 陈擎霄 on 16/1/7.
//  Copyright © 2016年 chenqingxiao007. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CXHomeStatue : NSObject

/**
 *  用户头像
 */
@property (copy, nonatomic) NSString *profile_image_url;

/**
 *  用户昵称
 */
@property (copy, nonatomic) NSString *screen_name;

/**
 *  内容
 */
@property (copy, nonatomic) NSString *text;


/**
 *  图片数组
 */
@property (strong, nonatomic) NSArray *pic_urls;

/**
 *  图片
 */
@property (copy, nonatomic) NSString *thumbnail_pic;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end
