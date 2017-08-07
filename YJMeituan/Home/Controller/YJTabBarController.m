//
//  YJTabBarController.m
//  YJMeituan
//
//  Created by wanyongjian on 2017/8/1.
//  Copyright © 2017年 eco. All rights reserved.
//

#import "YJTabBarController.h"
#import "HomeController.h"
#import "YJNavigationController.h"
//#define TabbarColor RGB(0x21c0ae,1)
#define KFont [UIFont systemFontOfSize:12]
//#define TabbarColor RGB(33,192,174)

@interface YJTabBarController () <UITabBarDelegate>

@end

@implementation YJTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self addController];
}

- (void)addController{
    HomeController *con1 = [[HomeController alloc]init];
    [self addChildViewControllerWithController:con1 title:@"首页" imgName:@"icon_tabbar_mine" selectImgName:@"icon_tabbar_mine_selected"];
    
    UIViewController *con2 = [[UIViewController alloc]init];
    [self addChildViewControllerWithController:con2 title:@"商家" imgName:@"icon_tabbar_merchant_normal" selectImgName:@"icon_tabbar_merchant_selected"];
    
    
    UIViewController *con3 = [[UIViewController alloc]init];
    [self addChildViewControllerWithController:con3 title:@"上门" imgName:@"icon_tabbar_onsite" selectImgName:@"icon_tabbar_onsite_selected"];
    
    UIViewController *con4 = [[UIViewController alloc]init];
    [self addChildViewControllerWithController:con4 title:@"我的" imgName:@"icon_tabbar_mine" selectImgName:@"icon_tabbar_mine_selected"];
    

    UIViewController *con5 = [[UIViewController alloc]init];
    [self addChildViewControllerWithController:con5 title:@"更多" imgName:@"icon_tabbar_misc" selectImgName:@"icon_tabbar_misc_selected"];
}

- (void)addChildViewControllerWithController:(UIViewController*)controller title:(NSString*)title imgName:(NSString *)imgName selectImgName:(NSString*)selectedImgName{
    
    YJNavigationController *nav = [[YJNavigationController alloc]initWithRootViewController:controller];
    controller.title = title;
    controller.tabBarItem.image =[[UIImage imageNamed:imgName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    controller.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImgName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    [controller.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:KFont} forState:UIControlStateNormal];
    [controller.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:TabbarColor} forState:UIControlStateSelected];
    [self addChildViewController:nav];
    
}

@end
