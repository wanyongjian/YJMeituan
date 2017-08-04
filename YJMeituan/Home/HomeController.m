//
//  ViewController.m
//  YJMeituan
//
//  Created by wanyongjian on 2017/7/26.
//  Copyright © 2017年 eco. All rights reserved.
//

#import "HomeController.h"
#import "HomeMenuCell.h"

@interface HomeController () <UITableViewDelegate,UITableViewDataSource,MenuCellDelegate>

@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) NSMutableArray *menuArray;
@end

@implementation HomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.view addSubview:self.tableview];
    

}
#pragma mark - menu代理方法
- (void)menuButtonClickedAtIndex:(NSInteger)index{
    NSLog(@"按钮点击--%ld",(long)index);
}

#pragma mark - lazyload

- (UITableView *)tableview{
    if (!_tableview) {
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight-64) style:UITableViewStylePlain];
        _tableview.delegate = self;
        _tableview.dataSource = self;
    }
    return _tableview;
}

- (NSArray *)menuArray{
    if (!_menuArray) {
        _menuArray = [CommonTool arrayFromPlist:@"menuData.plist"];
    }
    return _menuArray;
}

#pragma mark - tableview代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        static NSString *use = @"menu";
        HomeMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:use];
        if (!cell) {
            cell = [[HomeMenuCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:use];
            cell.dataArray = self.menuArray;
            cell.delegate = self;
            
        }
        
        return cell;
    }else{
        static NSString *use = @"menu";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:use];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:use];
        }
        
        return cell;
    }
  
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 180;
    }else{
        return 70;
    }
}
@end
