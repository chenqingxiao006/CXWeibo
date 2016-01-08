//
//  CXHomeStatueCell.m
//  CXWeibo
//
//  Created by 陈擎霄 on 16/1/8.
//  Copyright © 2016年 chenqingxiao007. All rights reserved.
//

#import "CXHomeStatueCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface CXHomeStatueCell ()
@property (strong, nonatomic)  UIImageView *profile_image_url_imageView;
@property (strong, nonatomic)  UILabel *screen_name_label;
@property (strong, nonatomic)  UILabel *text_label;

@end


@implementation CXHomeStatueCell


- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.width = SCREENWIDTH;
        [self addSubview:self.profile_image_url_imageView];
        [self addSubview:self.screen_name_label];
        [self addSubview:self.text_label];
        
    }
    return self;
}


- (void)setStatue:(CXHomeStatue *)statue {
    _statue = statue;
    self.profile_image_url_imageView.frame = CGRectMake(0, 10, 50, 50);
    [self.profile_image_url_imageView sd_setImageWithURL:[NSURL URLWithString:_statue.profile_image_url] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    }];
    
    self.screen_name_label.text = _statue.screen_name;

    [self.screen_name_label sizeToFit];
    self.screen_name_label.x = self.profile_image_url_imageView.maxX + 10;
    self.screen_name_label.y = self.profile_image_url_imageView.y;
    

    
    self.text_label.text = _statue.text;
    self.text_label.width = 300;
    self.text_label.numberOfLines = 0;
    
    [self.text_label sizeToFit];
    self.text_label.x = self.screen_name_label.x;    
    self.text_label.y = self.screen_name_label.maxY + 20;
    
    
    self.height = self.cellHeight;
}

- (CGFloat)cellHeight{
    if (!_cellHeight) {
        _cellHeight = self.screen_name_label.height + self.text_label.height + 40;
    }
    return _cellHeight;
}

- (UIImageView *)profile_image_url_imageView{
    if (!_profile_image_url_imageView) {
        _profile_image_url_imageView = [[UIImageView alloc] init];
    }
    return _profile_image_url_imageView;
}
- (UILabel *)text_label{
    if (!_text_label) {
        _text_label = [[UILabel alloc] init];
    }
    return _text_label;
}
- (UILabel *)screen_name_label{
    if (!_screen_name_label) {
        _screen_name_label = [[UILabel alloc] init];
    }
    return _screen_name_label;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
