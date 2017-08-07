//
//  YJNavigationController.m
//  YJMeituan
//
//  Created by wanyongjian on 2017/8/7.
//  Copyright © 2017年 eco. All rights reserved.
//

#import "YJNavigationController.h"

@interface YJNavigationController ()

@end

@implementation YJNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationBar.barTintColor = navigationBarColor;
    [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:16]}];
    
}

@end
