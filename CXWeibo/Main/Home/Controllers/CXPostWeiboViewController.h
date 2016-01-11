//
//  CXPostWeiboViewController.h
//  CXWeibo
//
//  Created by 陈擎霄 on 16/1/11.
//  Copyright © 2016年 chenqingxiao007. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^RefreshHomeBlock)();

@interface CXPostWeiboViewController : UIViewController
@property (copy, nonatomic) RefreshHomeBlock refreshHomeBlock;
@end
