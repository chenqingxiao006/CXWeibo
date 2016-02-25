//
//  CXStatuePicView.m
//  CXWeibo
//
//  Created by 陈擎霄 on 16/1/8.
//  Copyright © 2016年 chenqingxiao007. All rights reserved.
//

#import "CXStatuePicView.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "CXImageView.h"

@implementation CXStatuePicView

- (instancetype)initWithPic_urls:(NSArray *)pic_urls{
    if (self = [super init]) {
//        self.backgroundColor = [UIColor clearColor];

        CGFloat imageWidth = (SCREENWIDTH - 75 - 50) / 3 ;
        self.width = SCREENWIDTH - 75;
        
        if (pic_urls.count > 1) {
            // 九宫格布局
            // 几行
            int rowNums = pic_urls.count / 3.01 + 1;
            
            self.height = imageWidth * rowNums;
            for (int i = 0; i < pic_urls.count; i++) {
                
                CXImageView *imageView = [[CXImageView alloc] initWithImageUrls:pic_urls imageIndex:[NSNumber numberWithInt:i]];
                
                [self addSubview:imageView];
//                imageView.backgroundColor = [UIColor clearColor];
                // 图片
                [imageView sd_setImageWithURL:[NSURL URLWithString:[pic_urls[i] valueForKey:@"thumbnail_pic"]] placeholderImage:nil options:SDWebImageCacheMemoryOnly completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                    
                }];
                
                // 设置size
                imageView.size = CGSizeMake(imageWidth, imageWidth);
                // 设置坐标
                imageView.origin = CGPointMake(i%3 * (imageWidth + 5) , i/3 * (imageWidth + 5));
                
            }
            
        }else if(pic_urls.count == 1){
            // 单独一个图片
            CXImageView *imageView = [[CXImageView alloc] initWithImageUrls:pic_urls imageIndex:[NSNumber numberWithInt:0]];
            
            [self addSubview:imageView];
//            imageView.backgroundColor = [UIColor clearColor];
            // 图片
            [imageView sd_setImageWithURL:[NSURL URLWithString:[pic_urls[0] valueForKey:@"thumbnail_pic"]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                
            }];
            
            imageView.frame = CGRectMake(0, 0, imageWidth, imageWidth);
            
            self.height = imageWidth;
        }else{
            //没有图片布局
            self.frame = CGRectZero;
        }
    }
    return self;
}

@end
