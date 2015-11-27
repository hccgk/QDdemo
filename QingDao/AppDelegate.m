//
//  AppDelegate.m
//  QingDao
//
//  Created by 何川 on 15/11/21.
//  Copyright © 2015年 hechuan. All rights reserved.
//

#import "AppDelegate.h"
#import "QDHomeViewController.h"
#import "QDTabBarViewController.h"
#import "QDHotsViewController.h"
#import "QDCircleViewController.h"
#import "QDToolsViewController.h"
#import "QDXMPPViewController.h"
#import "QDUSViewController.h"
#import "QDShakeViewController.h"
#import "QDOnliveViewController.h"
#import "QDGuideViewController.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>

//腾讯开放平台（对应QQ和QQ空间）SDK头文件
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>

//微信SDK头文件
#import "WXApi.h"

//新浪微博SDK头文件
#import "WeiboSDK.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    [self shareSDK];
    self.window  = [[UIWindow alloc]initWithFrame:kUIScreenBounds];
    
    [self.window makeKeyAndVisible];
    //监听通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(enterMain)
                                                 name:kNotificationGuideEnter object:nil];
    
    BOOL flag = [[NSUserDefaults standardUserDefaults]boolForKey:kFirstLanuch];
    
    if (flag) {
        [self enterMain];
    }else
    {
        self.window.rootViewController = [[QDGuideViewController alloc]init];
    }
    
    return YES;
}
-(void)shareSDK
{
    [ShareSDK registerApp:@"cc7ca7261489"
     
          activePlatforms:@[
                            @(SSDKPlatformTypeSinaWeibo),
                            @(SSDKPlatformTypeWechat),
                            @(SSDKPlatformTypeQQ)]
                           // @(SSDKPlatformTypeDouBan)
                 onImport:^(SSDKPlatformType platformType)
     {
         switch (platformType)
         {
             case SSDKPlatformTypeWechat:
                 [ShareSDKConnector connectWeChat:[WXApi class]];
                 break;
             case SSDKPlatformTypeQQ:
                 [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
                 break;
             case SSDKPlatformTypeSinaWeibo:
                 [ShareSDKConnector connectWeibo:[WeiboSDK class]];
                 break;
             default:
                 break;
         }
     }
          onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo)
     {
         
         switch (platformType)
         {
             case SSDKPlatformTypeSinaWeibo:
                 //设置新浪微博应用信息,其中authType设置为使用SSO＋Web形式授权
                 [appInfo SSDKSetupSinaWeiboByAppKey:@"568898243"
                                           appSecret:@"38a4f8204cc784f81f9f0daaf31e02e3"
                                         redirectUri:@"http://www.sharesdk.cn"
                                            authType:SSDKAuthTypeBoth];
                 break;
             case SSDKPlatformTypeWechat:
                 [appInfo SSDKSetupWeChatByAppId:@"wx4868b35061f87885"
                                       appSecret:@"64020361b8ec4c99936c0e3999a9f249"];
                 break;
             case SSDKPlatformTypeQQ:
                 [appInfo SSDKSetupQQByAppId:@"100371282"
                                      appKey:@"aed9b0303e3ed1e27bae87c33761161d"
                                    authType:SSDKAuthTypeBoth];
                 break;
             
             default:
                 break;
         }
     }];
   
}

-(void)enterMain
{
    UIStoryboard *stroryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    NSMutableArray *tabbarArray = [NSMutableArray array];
    NSArray *controllersStringArray = @[@"QDHomeViewController",@"QDHotsViewController",
                                        @"QDCircleViewController",@"QDToolsViewController",
                                        @"QDXMPPViewController",@"QDShakeViewController",
                                        @"QDOnliveViewController",@"QDUSViewController"];
    for (NSString *vcName in controllersStringArray) {
        Class vc = [stroryboard instantiateViewControllerWithIdentifier:vcName];
        UINavigationController  *nav = [[UINavigationController alloc]initWithRootViewController:vc];
        [tabbarArray addObject:nav];
    }
    
     _tab = [[QDTabBarViewController alloc]init];
    _tab.viewControllers = tabbarArray;
    self.window.rootViewController = _tab;
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
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
