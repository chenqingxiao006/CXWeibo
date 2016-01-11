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
#import "CXHomeViewController.h"

@interface CXPostWeiboViewController ()<UITextViewDelegate>

@property (strong, nonatomic) UIButton *postBtn;

/** 内容框 */
@property (strong, nonatomic) UITextView *textView;

/** 下方工具条 */
@property (strong, nonatomic) UIView *toolBarView;
@end

@implementation CXPostWeiboViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.title = @"发布微博";
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
    postBtn.userInteractionEnabled = NO;
    
    [postBtn setTitleColor:[UIColor grayColor] forState:(UIControlStateNormal)];
    self.postBtn = postBtn;
    [postBtn setTitle:@"发布" forState:(UIControlStateNormal)];
    [postBtn sizeToFit];
    [postBtn setTitleColor:[UIColor grayColor] forState:(UIControlStateNormal)];
    [postBtn addTarget:self action:@selector(postWeibo) forControlEvents:(UIControlEventTouchUpInside)];
    
    UIBarButtonItem *postItem = [[UIBarButtonItem alloc] initWithCustomView:postBtn];
    self.navigationItem.rightBarButtonItems = @[postItem];
    
    [self.view addSubview:self.textView];
    [self.textView becomeFirstResponder];
    
    [self.view addSubview:self.toolBarView];
}

#pragma mark - event

- (void)postWeibo{
    if (self.textView.text.length > 0) {
        [self postWeiboWithText:self.textView.text];
    }
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
            [CXProgressHUD showMessage:@"发送成功" durationTime:1.2 completionBlock:^{
                [self dismissPostWeiboViewController];
                
            } inView:self.view];
            
            
        } failure:^(NSError *error) {
            NSLog(@"%@",error);
            [CXProgressHUD showMessage:@"发送失败" durationTime:1.2 completionBlock:^{
                
            } inView:self.view];
        }];
    }else{
        [CXProgressHUD showMessage:@"文字不能为空" durationTime:1.2 completionBlock:^{
            
        } inView:self.view];
    }
}

- (void)dismissPostWeiboViewController{
    [self.textView endEditing:YES];
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        
    }];
}

#pragma mark - UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView{
    if (textView.text.length > 0 && textView.text.length < 140) {
        self.postBtn.userInteractionEnabled = YES;
        [self.postBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];

    }else{
        self.postBtn.userInteractionEnabled = NO;
        [self.postBtn setTitleColor:[UIColor grayColor] forState:(UIControlStateNormal)];

    }

}

#pragma mark - getter and setter

- (UITextView *)textView{
    if (!_textView) {
        _textView = [[UITextView alloc] init];
        _textView.frame = CGRectMake(0, 64, SCREENWIDTH, SCREENHEIGHT - 64 - 49);
        
        self.automaticallyAdjustsScrollViewInsets = NO;// 光标位于左上角
        
        _textView.backgroundColor = [UIColor purpleColor];
        _textView.delegate = self;
        
    }
    return _textView;
}

- (UIView *)toolBarView{
    if (!_toolBarView) {
        _toolBarView = [[UIView alloc] init];
        _toolBarView.frame = CGRectMake(0, SCREENHEIGHT - 49, SCREENWIDTH, 49);
        _toolBarView.backgroundColor = [UIColor yellowColor];
    }
    return _toolBarView;
}


@end
