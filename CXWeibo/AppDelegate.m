//
//  AppDelegate.m
//  CXWeibo
//
//  Created by 陈擎霄 on 15/12/15.
//  Copyright © 2015年 chenqingxiao007. All rights reserved.
//

#import "AppDelegate.h"
#import "CXTabBarViewController.h"
#import "CXOauthController.h"
#import "CXAccountTool.h"
#import "CXPostWeiboViewController.h"
#import "CXNavigationController.h"
#import "CXHomeViewController.h"

#import "ZTabBarController.h"
@interface AppDelegate ()

@property (strong, nonatomic) CXTabBarViewController *tabVC;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
   

//    //1.创建Window
//    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
//    self.window.backgroundColor = [UIColor whiteColor];
//    
//    //2.设置控制器为Window的根控制器
//    if([CXAccountTool shareAccountTool].account){
//        // 用户已经授权过
//        CXTabBarViewController *tabBarVC = [[CXTabBarViewController alloc] init];
//        self.window.rootViewController = tabBarVC;
//        self.tabVC = tabBarVC;
//    }else{
//        // 未授权加载授权页面
//        CXOauthController *oauthVC = [[CXOauthController alloc] init];
//        self.window.rootViewController = oauthVC;
//    }

    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];

    //2.设置控制器为Window的根控制器
    if([CXAccountTool shareAccountTool].account){
        // 用户已经授权过
        ZTabbarController *tabBarVC = [[ZTabbarController alloc] init];
        self.window.rootViewController = tabBarVC;
    }else{
        // 未授权加载授权页面
        CXOauthController *oauthVC = [[CXOauthController alloc] init];
        self.window.rootViewController = oauthVC;
    }
    [self.window makeKeyAndVisible];
    [self setupNavBar];
    
    //0.添加3D Touch
    UIApplicationShortcutIcon *firstItemIcon = [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeAdd];
    
    UIMutableApplicationShortcutItem *lookWeiboItem = [[UIMutableApplicationShortcutItem alloc]initWithType:@"lookWeiboItem" localizedTitle:@"看微博" localizedSubtitle:nil icon:firstItemIcon userInfo:nil];
    
    UIApplicationShortcutIcon *secondItemIcon = [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeAdd];
    UIMutableApplicationShortcutItem *postWeiboItem = [[UIMutableApplicationShortcutItem alloc]initWithType:@"postWeibo" localizedTitle:@"发微博" localizedSubtitle:nil icon:secondItemIcon userInfo:nil];
    
    application.shortcutItems = @[lookWeiboItem,postWeiboItem];
    
    return YES;
}

-(void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler{
    
    
    
    if ([shortcutItem.type isEqual:@"lookWeibo"]) {
        
//        NSLog(@"跳转到firstItem界面");
//        
//        firstItemView *first = [[firstItemView alloc]init];
//        
//        [nav pushViewController:first animated:YES];
        
    }else if([shortcutItem.type isEqual:@"postWeibo"]){
        
        
        if([CXAccountTool shareAccountTool].account){
            self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
            self.window.backgroundColor = [UIColor whiteColor];
            // 用户已经授权过


            
            CXNavigationController *nav1 = self.tabVC.childViewControllers[0];
            
            CXPostWeiboViewController *postVC = [[CXPostWeiboViewController alloc] init];
            
            CXNavigationController *nav2 = [[CXNavigationController alloc] initWithRootViewController:postVC];
            [nav1 presentViewController:nav2 animated:YES completion:^{
                
            }];

            
        }else{
            // 未授权加载授权页面
            CXOauthController *oauthVC = [[CXOauthController alloc] init];
            self.window.rootViewController = oauthVC;
        }
        
        
        
                                             
                                             
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
#pragma mark - setupNavBar
- (void)setupNavBar{
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
}

@end
