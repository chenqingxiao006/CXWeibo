//
//  CXLoginViewController.m
//  CXWeibo
//
//  Created by 陈擎霄 on 15/12/16.
//  Copyright © 2015年 chenqingxiao007. All rights reserved.
//

#import "CXLoginViewController.h"
#import "CXProgressHUD.h"
#import "CXNetManager.h"
#import "AFNetworking.h"
#import "CXAccount.h"
#import "CXAccountTool.h"
#import "CXTabBarViewController.h"

@interface CXLoginViewController ()<UIWebViewDelegate>

@end

@implementation CXLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createUI];
    [self loadLoginView];
    
}

- (void)createUI{
    self.title = @"登录";
    self.view.backgroundColor = [UIColor yellowColor];
    //取消按钮的位置
    UIBarButtonItem *cancelBtn = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = cancelBtn;
}

- (void)loadLoginView{
    
    // 添加webview
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
    
    self.view = webView;

    
    NSString *urlStr = [AUTHORIZE_URL stringByAppendingFormat:@"?display=mobile&client_id=%@&redirect_uri=%@", APPKEY, REDIRECT_URl];
    NSURL *url = [NSURL URLWithString:urlStr];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];

    // 2.设置代理
    webView.delegate = self;

}

#pragma mark - events
- (void)cancel{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

#pragma mark - webview代理方法
// webView开始加载
- (void)webViewDidStartLoad:(UIWebView *)webView
{

    [CXProgressHUD showLoadingInView:self.view];
    
}

// webView请求完毕
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [CXProgressHUD hidenForView:self.view];
}

#pragma mark 拦截webView的所有请求
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    //需要做拦截
    // 1.获得全路径
    NSString *urlStr = request.URL.absoluteString;
    
    // 2.查找code=的范围
    NSRange range = [urlStr rangeOfString:@"code="];
    
    if (range.length != 0) {
        // 跳到“回调地址”，说明已经授权成功
        NSInteger index = range.location + range.length;
        // 获取requestToken
        NSString *requestToken = [urlStr substringFromIndex:index];
        
        // 3.换取accessToken
        [self getAccessToken:requestToken];
        
        // 拦截跳转
        return NO;
    }
    
    return YES;
}

- (void)getAccessToken:(NSString *)requestToken{

    // 1.定义参数
    NSDictionary *params = @{
                             @"client_id" : APPKEY,
                             @"client_secret" : APPSECRET,
                             @"grant_type" : @"authorization_code",
                             @"redirect_uri" : REDIRECT_URl,
                             @"code" : requestToken
                             };
    
    
    // 请求授权的token
    [CXNetManager postWithUrl:ACCESS_TOKENURL params:params success:^(id responseObject) {

        // 1.获取当前账号
        CXAccount *account = [CXAccount accountWithDic:responseObject];
        
        // 1.5
        //获取用户信息
        
        NSDictionary *params = @{
                                 @"access_token" : account.access_token,
                                 @"uid" :account.uid
                                 };
        
        [CXNetManager getWithUrl:@"https://api.weibo.com/2/users/show.json" params:params success:^(id responseObject) {
            
            account.userManager = [[CXUserManager alloc] initWithDic:responseObject];
            
            // 2.保存到沙盒
            [[CXAccountTool shareAccountTool] saveAccount:account];
            
            // 3.提示信息
            [CXProgressHUD hidenForView:self.view];
            [CXProgressHUD showMessage:@"登录成功" durationTime:1.2 completionBlock:^{
                // 切换到首页
                self.view.window.rootViewController = [[CXTabBarViewController alloc] init];
                
            } inView:self.view];
            
        } failure:^(NSError *error) {
            
            account.userManager = nil;
        }];

        
        
       
        
    } failure:^(NSError *error) {
        // 授权失败
        NSLog(@"%@",error);
//        [CXProgressHUD hidenForView:self.view];
//        [CXProgressHUD showMessage:@"登录失败" durationTime:1.2 completionBlock:^{
//        } inView:self.view];
    }];

    
    
}
@end












