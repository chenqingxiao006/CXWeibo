//
//  CXImageView.m
//  CXWeibo
//
//  Created by 陈擎霄 on 16/2/25.
//  Copyright © 2016年 chenqingxiao007. All rights reserved.
//

#import "CXImageView.h"
#import "HZPhotoGroup.h"
#import "HZPhotoItem.h"

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
        
//        UITapGestureRecognizer *tapges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showLargeImage)];
//        tapges.numberOfTapsRequired = 1; // 单击
//
//        [self addGestureRecognizer:tapges];
//        
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, 0, 100, 100);
        button.backgroundColor = [UIColor orangeColor];
        
        [button addTarget:self action:@selector(showLargeImage) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        
    }
    return self;
}

- (void)showLargeImage {
    
    HZPhotoGroup *group = [[HZPhotoGroup alloc] init];

    NSMutableArray *temp = [NSMutableArray array];

    [self.imAgeUrls enumerateObjectsUsingBlock:^(NSString *src, NSUInteger idx, BOOL *stop) {
        HZPhotoItem *item = [[HZPhotoItem alloc] init];
        item.thumbnail_pic = src;
        [temp addObject:item];
    }];
    
    group.photoItemArray = [temp copy];
    
    [self addSubview:group];
}

@end



















