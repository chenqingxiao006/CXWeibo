//
//  CXBaseViewController.h
//  CXWeibo
//
//  Created by 陈擎霄 on 15/12/15.
//  Copyright © 2015年 chenqingxiao007. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^RequestCompletedHandleBlock)(id responseObject);
typedef void (^RequestFailedHandleBlock)(NSError *error);
typedef enum {

    RequestModeGet,
    RequestModePost
}RequestMode;

@interface CXBaseViewController : UITableViewController

@property (assign, nonatomic) BOOL ifAddPullToRefreshControl;

@property (strong, nonatomic) NSMutableArray *listData;


- (void)loadWithUrlStr:(NSString *)request
            requestMode:(RequestMode)requestMode
            params:(NSDictionary *)params
            completed:(RequestCompletedHandleBlock)completeHandleBlock
            failed:(RequestFailedHandleBlock)failedHandleBlock
            showLodingView:(BOOL)show;



- (void)loadNewer;

@end
