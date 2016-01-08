//
//  CXStatuePicView.m
//  CXWeibo
//
//  Created by 陈擎霄 on 16/1/8.
//  Copyright © 2016年 chenqingxiao007. All rights reserved.
//

#import "CXStatuePicView.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation CXStatuePicView

- (instancetype)initWithPic_urls:(NSArray *)pic_urls{
    if (self = [super init]) {
        self.backgroundColor = [UIColor clearColor];

        
        if (pic_urls.count > 1) {
            // 九宫格布局
            /*
                整个宽度为屏幕宽度 - 75,间隔为25
             */
            CGFloat imageWidth = (SCREENWIDTH - 75 - 50) / 3 ;
            self.width = SCREENWIDTH - 75;
            
            // 几行
            int rowNums = (int)pic_urls.count / 3 + 1;
            
            self.height = imageWidth * rowNums;
            for (int i = 0; i < pic_urls.count; i++) {
                
                
                UIImageView *imageView = [[UIImageView alloc] init];
                [self addSubview:imageView];
                imageView.backgroundColor = [UIColor yellowColor];
                // 图片
                [imageView sd_setImageWithURL:[NSURL URLWithString:[pic_urls[i] valueForKey:@"thumbnail_pic"]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                    
                }];
                // 设置size
                imageView.size = CGSizeMake(imageWidth, imageWidth);
                // 设置坐标
                imageView.origin = CGPointMake(i%3 * imageWidth , i/rowNums * imageWidth);
                
            }
            
        }else if(pic_urls.count == 1){
            // 单独一个图片
            
        }else{
            //没有图片布局
            self.frame = CGRectZero;
        }
    }
    return self;
}

@end
