//
//  CXBaseGradientView.m
//  zbj-iPhone
//
//  Created by 陈擎霄 on 15/12/25.
//  Copyright © 2015年 ZhuBaiJia. All rights reserved.
//

#import "CXBaseGradientView.h"

@implementation CXBaseGradientView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT);
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.9];
        self.alpha = 0;
        
        [UIView animateWithDuration:0.3 animations:^{
            self.alpha = 1;
        }];
    }
    return self;
}

- (void)show{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}

- (void)hide{
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
}

@end


















