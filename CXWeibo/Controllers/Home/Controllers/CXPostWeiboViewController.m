//
//  CXPostWeiboViewController.m
//  CXWeibo
//
//  Created by 陈擎霄 on 16/1/11.
//  Copyright © 2016年 chenqingxiao007. All rights reserved.
//

#import "CXPostWeiboViewController.h"
#import "CXAccountTool.h"
#import "CXNetManager.h"
#import "CXProgressHUD.h"

@interface CXPostWeiboViewController ()

@end

@implementation CXPostWeiboViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"发布微博";
    [self creatUI];
}

- (void)creatUI{
    self.view.backgroundColor = [UIColor orangeColor];
    
    // 取消按钮
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelBtn setTitle:@"取消" forState:(UIControlStateNormal)];
    [cancelBtn sizeToFit];
    [cancelBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [cancelBtn addTarget:self action:@selector(dismissPostWeiboViewController) forControlEvents:(UIControlEventTouchUpInside)];
    
    UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithCustomView:cancelBtn];
    self.navigationItem.leftBarButtonItems = @[cancelItem];

    
    // 发布按钮
    UIButton *postBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [postBtn setTitle:@"发布" forState:(UIControlStateNormal)];
    [postBtn sizeToFit];
    [postBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [postBtn addTarget:self action:@selector(postWeibo) forControlEvents:(UIControlEventTouchUpInside)];
    
    UIBarButtonItem *postItem = [[UIBarButtonItem alloc] initWithCustomView:postBtn];
    self.navigationItem.rightBarButtonItems = @[postItem];
    
    
}

#pragma mark - event

- (void)postWeibo{
    [self postWeiboWithText:@""];
}

- (void)postWeiboWithText:(NSString *)text{
    
    if (text.length > 0) {
        CXAccount *account = [CXAccountTool shareAccountTool].account;
        NSDictionary *params = @{
                                 @"access_token" : account.access_token,
                                 @"uid" :account.uid,
                                 @"feature":@1,
                                 @"status":text
                                 };
        
        [CXNetManager postWithUrl:@"https://api.weibo.com/2/statuses/update.json" params:params success:^(id responseObject) {
            NSLog(@"%@",responseObject);
        } failure:^(NSError *error) {
            NSLog(@"%@",error);
        }];
    }else{
        [CXProgressHUD showMessage:@"文字不能为空" durationTime:1.2 completionBlock:^{
            
        } inView:self.view];
    }
}


- (void)dismissPostWeiboViewController{
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        
    }];
}


@end
