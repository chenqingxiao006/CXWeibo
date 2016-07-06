//
//  CXImageView.m
//  CXWeibo
//
//  Created by 陈擎霄 on 16/2/25.
//  Copyright © 2016年 chenqingxiao007. All rights reserved.
//

#import "CXImageView.h"
#import "STPhotoBrowserController.h"

@interface CXImageView ()<STPhotoBrowserDelegate>

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
    STPhotoBrowserController *browserVc = [[STPhotoBrowserController alloc] init];
    browserVc.sourceImagesContainerView = self.superview; // 原图的父控件
    browserVc.countImage = self.imAgeUrls.count; // 图片总数
    browserVc.currentPage = [self.index integerValue];
    browserVc.delegate = self;
    [browserVc show];
}

#pragma mark - STPhotoBrowserDelegate

- (UIImage *_Nonnull)photoBrowser:(STPhotoBrowserController *_Nullable)browser
         placeholderImageForIndex:(NSInteger)index {
    return self.image;
}

- (NSURL *_Nullable)photoBrowser:(STPhotoBrowserController *_Nullable)browser
     highQualityImageURLForIndex:(NSInteger)index {
    NSString *urlStr = [self.imAgeUrls[index] objectForKey:@"thumbnail_pic"];
    
    NSString *largeUrl = [urlStr stringByReplacingCharactersInRange:NSMakeRange(22, 9) withString:@"large"];
    
    return [NSURL URLWithString:largeUrl];

}

@end
