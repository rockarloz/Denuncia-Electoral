//
//  AppDelegate.m
//  DenunciaElectoral
//
//  Created by Carlos Castellanos on 20/05/15.
//  Copyright (c) 2015 Carlos Castellanos. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.distanceFilter = kCLDistanceFilterNone;
    _locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    [_locationManager startUpdatingLocation];

    // Override point for customization after application launch.
    ViewController *vc=[[ViewController alloc]init];
    UINavigationController *nv=[[UINavigationController alloc]initWithRootViewController:vc];
    self.window.rootViewController=nv;
    [nv.navigationBar setBarTintColor:[UIColor colorWithRed:86/255.0 green:119/255.0 blue:174/255.0 alpha:1]];
    _locationManager = [[CLLocationManager alloc]init]; // initializing locationManager
    _locationManager.delegate = self; // we set the delegate of locationManager to self.
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest; // setting the accuracy
    
    [_locationManager startUpdatingLocation];
    
#ifdef __IPHONE_8_0
    if(IS_OS_8_OR_LATER) {
        // Use one or the other, not both. Depending on what you put in info.plist
        [_locationManager requestWhenInUseAuthorization];
        [_locationManager requestAlwaysAuthorization];
    }
#endif
    
    
    return YES;
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

@end
