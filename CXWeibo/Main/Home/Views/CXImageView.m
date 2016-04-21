//
//  CXImageView.m
//  CXWeibo
//
//  Created by 陈擎霄 on 16/2/25.
//  Copyright © 2016年 chenqingxiao007. All rights reserved.
//

#import "CXImageView.h"

@interface CXImageView ()

@property (nonatomic, strong) NSArray *imAgeUrls;
@property (nonatomic, strong) NSNumber *index;

@end



@implementation CXImageView

- (instancetype)initWithImageUrls:(NSArray *)imageUrls imageIndex:(NSNumber *)index {
    
    if (self = [super init]) {
        // 添加手势
        self.imAgeUrls = imageUrls;
        self.index = index;
        
        UITapGestureRecognizer *tapges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showLargeImage)];
        tapges.numberOfTapsRequired = 1; // 单击

        [self addGestureRecognizer:tapges];
        self.userInteractionEnabled = YES;
        
    }
    return self;
}

- (void)showLargeImage {
    
//    HZPhotoGroup *group = [[HZPhotoGroup alloc] init];
//
//    NSMutableArray *temp = [NSMutableArray array];
//    
//    NSMutableArray *imageArray = [NSMutableArray array];
//    for (NSDictionary *dict in self.imAgeUrls) {
//        NSString *str = [dict valueForKey:@"thumbnail_pic"];
//        [imageArray addObject:str];
//    }
//    
//
//    [imageArray enumerateObjectsUsingBlock:^(NSString *src, NSUInteger idx, BOOL *stop) {
//        HZPhotoItem *item = [[HZPhotoItem alloc] init];
//        item.thumbnail_pic = src;
//        [temp addObject:item];
//    }];
//    
//    group.photoItemArray = [temp copy];
//    
//    [self addSubview:group];
}

@end



















