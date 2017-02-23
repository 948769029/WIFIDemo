//
//  AppDelegate.m
//  WIFIDemo
//
//  Created by apple on 2016/10/19.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "AppDelegate.h"
#import "RealReachability.h"

@interface AppDelegate ()

@property (nonatomic, assign) BOOL isUserReal; // 当前网络是否可用
@property (nonatomic, assign) NSInteger status; // 当前网络状态

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    // 方式一
    [GLobalRealReachability startNotifier];
    
    // 方式二
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(netWorkChanged:) name:kRealReachabilityChangedNotification object:nil];
    
    return YES;
}

- (void)netWorkChanged:(NSNotification *)notification
{
    RealReachability *reachability = (RealReachability *)notification.object;
    ReachabilityStatus status = [reachability currentReachabilityStatus];
    self.isUserReal = YES;
    switch (status) {
        case RealStatusNotReachable:
            self.isUserReal = NO;
            self.status = 0;
            [self alertMessage:@"没网络"];
            break;
        case RealStatusViaWiFi:
            self.isUserReal = YES;
            self.status = 1;
            [self alertMessage:@"WIFI"];
            break;
        case RealStatusViaWWAN:
            self.isUserReal = YES;
            self.status = 2;
            [self alertMessage:@"2G/3G/4G"];
            break;
            
        default:
            break;
    }
}

- (void)alertMessage:(NSString *)message
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:nil cancelButtonTitle:@"取消" otherButtonTitles: nil];
    [alertView show];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}




@end
