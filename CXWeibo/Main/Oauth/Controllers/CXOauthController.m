//
//  CXOauthController.m
//  CXWeibo
//
//  Created by 陈擎霄 on 15/12/15.
//  Copyright © 2015年 chenqingxiao007. All rights reserved.
//

#import "CXOauthController.h"
#import "CXNavigationController.h"
#import "CXLoginViewController.h"

@interface CXOauthController ()
@property (nonatomic, strong) UIButton *loginBtn;
@end

@implementation CXOauthController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.loginBtn];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIButton *)loginBtn{
    if (!_loginBtn) {
        
        // 中心点距离下方 123个点
        _loginBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 50)];
        _loginBtn.centerX = SCREENWIDTH / 2;
        _loginBtn.centerY = SCREENHEIGHT - 123;
        _loginBtn.backgroundColor = [UIColor purpleColor];
        
        [_loginBtn setTitle:@"login" forState:(UIControlStateNormal)];
        [_loginBtn addTarget:self action:@selector(login) forControlEvents:(UIControlEventTouchUpInside)];
        
    }
    return _loginBtn;
}

- (void)login{
    CXLoginViewController *loginVC = [[CXLoginViewController alloc] init];
    
    // 跳转到登陆界面
    CXNavigationController *nav = [[CXNavigationController alloc] initWithRootViewController:loginVC];
    [self presentViewController:nav animated:YES completion:^{
        
    }];

}
@end














