//
//  AppDelegate.m
//  YJMeituan
//
//  Created by wanyongjian on 2017/7/26.
//  Copyright © 2017年 eco. All rights reserved.
//



//git 提交测试

#import "AppDelegate.h"
#import "YJTabBarController.h"
#import <CoreLocation/CoreLocation.h>




@interface AppDelegate () <CLLocationManagerDelegate>{
    BMKMapManager* _mapManager;
}

@property (strong,nonatomic) CLLocationManager *locationManager;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = [[YJTabBarController alloc]init];
    [self.window makeKeyAndVisible];
    
//    _latitude = LATITUDE_DEFAULT;
//    _longitude = LONGITUDE_DEFAULT;
    
    if ([CLLocationManager locationServicesEnabled]) {
        self.locationManager = [[CLLocationManager alloc]init];
        self.locationManager.distanceFilter = 500;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        self.locationManager.delegate = self;
        
        if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
            [self.locationManager requestWhenInUseAuthorization];
        }
        [self.locationManager startUpdatingLocation];
    }else{
        NSLog(@"请开启定位服务");
    }
    
    //百度地图引擎启动
    _mapManager = [[BMKMapManager alloc]init];
    // 如果要关注网络及授权验证事件，请设定     generalDelegate参数
    BOOL ret = [_mapManager start:@"ZG2OtDO4RVZAlMCDdbCOA7sExMbcxXIH"  generalDelegate:nil];
    if (!ret) {
        NSLog(@"manager start failed!");
    }
    
    return YES;
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    CLLocation *location = locations.firstObject;
//    location.coordinate
    self.latitude = location.coordinate.latitude;
    self.longitude = location.coordinate.longitude;
    [self.locationManager stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    switch (status) {
        case kCLAuthorizationStatusNotDetermined:
            NSLog(@"还没决定");
            break;
            
        case kCLAuthorizationStatusDenied:
            NSLog(@"用户拒绝");
            break;
            
        case kCLAuthorizationStatusAuthorizedAlways:
            NSLog(@"允许后台");
            break;
            
        case kCLAuthorizationStatusAuthorizedWhenInUse:
            NSLog(@"仅限使用中");
            break;
        default:
            break;
    }
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
