//
//  CXHomeViewController.m
//  CXWeibo
//
//  Created by 陈擎霄 on 15/12/15.
//  Copyright © 2015年 chenqingxiao007. All rights reserved.
//

#import "CXHomeViewController.h"
#import "CXAccountTool.h"
#import "CXNetManager.h"
#import "CXAccount.h"
#import "CXProgressHUD.h"
#import "CXUserManager.h"
#import "CXHomeModel.h"
#import "CXHomeStatue.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "CXHomeStatueCell.h"
#import "CXPostWeiboViewController.h"
#import "CXNavigationController.h"

@interface CXHomeViewController ()

@end

@implementation CXHomeViewController

- (void)viewDidLoad {
    self.title = @"首页";
    self.ifAddPullToRefreshControl = YES;
    [super viewDidLoad];
    [self creatUI];
}

- (void)creatUI{
    // 添加发布微博按钮
    UIBarButtonItem *btn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(postWeibo)];
    
    self.navigationItem.rightBarButtonItems = @[btn];
    
    
}

#pragma mark - 继承父类
- (void)loadNewer{
    [super loadNewer];
    CXAccount *account = [CXAccountTool shareAccountTool].account;
    NSDictionary *params = @{
                             @"access_token" : account.access_token,
                             @"uid" :account.uid,
                             @"feature":@1
                             };
    
    [self loadWithUrlStr:@"https://api.weibo.com/2/statuses/home_timeline.json" requestMode:RequestModeGet params:params completed:^(id responseObject) {
                CXHomeModel *homeModel = [[CXHomeModel alloc] initWithDic:responseObject];

        self.listData = homeModel.homeStatuses;

        [self.tableView reloadData];
        
    } failed:^(NSError *error) {
        
    } showLodingView:YES];
    
}

#pragma mark - events

- (void)postWeibo{
    
    CXPostWeiboViewController *postVC = [[CXPostWeiboViewController alloc] init];
    __weak typeof(self) weakSelf = self;
    postVC.refreshHomeBlock = ^{
        [weakSelf loadNewer];
    };
    
    CXNavigationController *nav = [[CXNavigationController alloc] initWithRootViewController:postVC];
    [self.navigationController presentViewController:nav animated:YES completion:^{
        
    }];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listData.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *cellIdentifer = @"reuseCell";
    CXHomeStatueCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifer];
    if (!cell) {
        cell = [[CXHomeStatueCell alloc] init];
    }
    CXHomeStatue *statue = self.listData[indexPath.row];
    cell.statue = statue;

    return cell;
 }

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.height;
}

@end