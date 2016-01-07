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


@interface CXHomeViewController ()

@end

@implementation CXHomeViewController

- (void)viewDidLoad {

    self.title = @"首页";
    
    self.ifAddPullToRefreshControl = YES;
    
    [super viewDidLoad];

    
}

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
        CXHomeStatue *statue = self.listData[0];
        
        NSLog(@"%@",statue);
        
        
        [self.tableView reloadData];
        
    } failed:^(NSError *error) {
        
    } showLodingView:YES];
    
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
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifer];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifer];
    }
    
    CXHomeStatue *statue = self.listData[indexPath.row];
    
    cell.textLabel.text = statue.text;
    cell.detailTextLabel.text = statue.screen_name;
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:statue.thumbnail_pic]];
    
    return cell;
 }




@end









