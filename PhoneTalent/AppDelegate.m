//
//  AppDelegate.m
//  PhoneTalent
//
//  Created by gaozhichao on 2016/12/5.
//  Copyright © 2016年 GZC. All rights reserved.
//

#import "AppDelegate.h"
#import "GZCHomeViewController.h"
#import "GZCScanQRCodeSystemViewController.h"
#import "GZCJZMerchantViewController.h"
#import "GZCMineViewController.h"
#import "CustomTabbarController.h"
#import "ToolController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    CustomTabbarController*custom=[[CustomTabbarController alloc] init];
    self.window.rootViewController=custom;
//    NSRunLoop *runloop = [NSRunLoop currentRunLoop];
//    NSLog(@"===%@",[NSRunLoop currentRunLoop]);

//
//    dispatch_queue_t queue = dispatch_queue_create("gcdtest.rongfzh.yc", DISPATCH_QUEUE_CONCURRENT);
//    dispatch_async(queue, ^{
//        [NSThread sleepForTimeInterval:3];
//        NSLog(@"dispatch_async1");
//    });
//    dispatch_async(queue, ^{
//        [NSThread sleepForTimeInterval:1];
//        NSLog(@"dispatch_async2");
//    });
//    dispatch_barrier_async(queue, ^{
//        NSLog(@"dispatch_barrier_async");
//        [NSThread sleepForTimeInterval:0.5];
//
//    });
//    dispatch_async(queue, ^{
//        [NSThread sleepForTimeInterval:1];
//        NSLog(@"dispatch_async3");
//    });
//
    
    dispatch_queue_t queue1 = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_async(group, queue1, ^{
        [NSThread sleepForTimeInterval:6];
        NSLog(@"group1 [NSThread sleepForTimeInterval:6];");
    });
    dispatch_group_async(group, queue1, ^{
        [NSThread sleepForTimeInterval:3];
        NSLog(@"group2 [NSThread sleepForTimeInterval:3];");
    });
    dispatch_group_async(group, queue1, ^{
        [NSThread sleepForTimeInterval:1];
        NSLog(@"group3 [NSThread sleepForTimeInterval:1];");
    });
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"main thread.");
    });
  
    
    dispatch_apply(5, queue1, ^(size_t index) {
        NSLog(@"%ld",index);
    });
    
    
    return YES;
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
