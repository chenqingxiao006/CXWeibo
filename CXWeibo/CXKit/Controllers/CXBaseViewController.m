//
//  CXBaseViewController.m
//  CXWeibo
//
//  Created by 陈擎霄 on 15/12/15.
//  Copyright © 2015年 chenqingxiao007. All rights reserved.
//

#import "CXBaseViewController.h"
#import "MJRefresh.h"
#import "CXProgressHUD.h"
#import "CXNetManager.h"

@interface CXBaseViewController ()

@end

@implementation CXBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadNewer];
    if (self.ifAddPullToRefreshControl) {
        // 添加下拉刷新
        [self addPullToRefreshControl];
    }
    
}

/**
 *  下拉刷新
 */
- (void)addPullToRefreshControl {
    
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        [self loadNewer];
    }];
}

- (void)loadNewer{
    
}

#pragma mark - event


- (void)loadWithUrlStr:(NSString *)request requestMode:(RequestMode)requestMode params:(NSDictionary *)params completed:(RequestCompletedHandleBlock)completeHandleBlock failed:(RequestFailedHandleBlock)failedHandleBlock showLodingView:(BOOL)show{
    
    if (show) {
        [CXProgressHUD showLoadingInView:self.tableView];
    }

    if (requestMode == RequestModeGet) {
        // get
        
        [CXNetManager getWithUrl:request params:params success:^(id responseObject) {
            [CXProgressHUD hidenForView:self.tableView];
            completeHandleBlock(responseObject);
            [self.tableView.header endRefreshing];
            
            
        } failure:^(NSError *error) {
            [CXProgressHUD hidenForView:self.tableView];
            [self.tableView.header endRefreshing];
            if (failedHandleBlock) {
                failedHandleBlock(error);
            }
            
        }];
        
    }else{
        // post
        [CXNetManager postWithUrl:request params:params success:^(id responseObject) {
            [CXProgressHUD hidenForView:self.tableView];
            completeHandleBlock(responseObject);
            [self.tableView.header endRefreshing];
            
        } failure:^(NSError *error) {
            [CXProgressHUD hidenForView:self.tableView];
            [self.tableView.header endRefreshing];
            if (failedHandleBlock) {
                failedHandleBlock(error);
            }
        }];
    }
}
@end










