//
//  ViewController.m
//  YJMeituan
//
//  Created by wanyongjian on 2017/7/26.
//  Copyright © 2017年 eco. All rights reserved.
//

#import "HomeController.h"
#import "HomeMenuCell.h"
#import "YJDiscountModel.h"
#import "DiscountCell.h"
#import "YJDiscountWebViewController.h"
#import "YJRecommentModel.h"

@interface HomeController () <UITableViewDelegate,UITableViewDataSource,MenuCellDelegate,DiscountCellDelegate>

@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) NSMutableArray *menuArray;

//存放数据数组
@property (nonatomic, strong) NSMutableArray *discountArray;
@property (nonatomic, strong) NSMutableArray *recommentArray;
@end

@implementation HomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.view addSubview:self.tableview];
    
    //抢购数据
    NSString *url = [[GetUrlString sharedManager] urlWithRushBuy];
    [NetWrok getDataFromURL:url paraments:nil success:^(id response) {
        
    } failure:^(NSError *error) {
        
    }];
    
    //折扣数据
    NSString *discountUrl = [[GetUrlString sharedManager] urlWithDiscount];
    [NetWrok getDataFromURL:discountUrl paraments:nil success:^(id response) {
        NSMutableArray *array = response[@"data"];
        
        [self.discountArray removeAllObjects];
        for (NSDictionary *dict in array) {
            NSLog(@"折扣--%@",dict);
            YJDiscountModel *discountModel = [YJDiscountModel mj_objectWithKeyValues:dict];
            NSLog(@"%@",discountModel);
            [self.discountArray addObject:discountModel];
        }
        
        [self.tableview reloadData];
    } failure:^(NSError *error) {
        
    }];
    
    //推荐
    NSString *recommentUrl = [[GetUrlString sharedManager] urlWithRecomment];
    [NetWrok getDataFromURL:recommentUrl paraments:nil success:^(id response) {
        NSMutableArray *dataArray = response[@"data"];
        NSLog(@"-=-=-==-=  %@",dataArray);
        [self.recommentArray removeAllObjects];
        for (NSInteger i=0; i<dataArray.count; i++) {
            YJRecommentModel *recommentModel = [YJRecommentModel mj_objectWithKeyValues:dataArray[i]];
            [self.recommentArray addObject:recommentModel];
        }
    } failure:^(NSError *error) {
        
    }];
}
#pragma mark - 代理方法
- (void)menuButtonClickedAtIndex:(NSInteger)index{
    NSLog(@"按钮点击--%ld",(long)index);
}

- (void)discountItemClicked:(NSString *)str{
    
    NSLog(@"-==-=   %@",str);
    NSString *urlStr = [[GetUrlString sharedManager] urlWithDiscountWebData:str];
    YJDiscountWebViewController *controller = [[YJDiscountWebViewController alloc] init];
    [controller setHidesBottomBarWhenPushed:YES];
    controller.urlStr = urlStr;
    [self.navigationController  pushViewController:controller animated:YES];
    
}
#pragma mark - lazyload

- (UITableView *)tableview{
    if (!_tableview) {
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight-64) style:UITableViewStylePlain];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.separatorInset = UIEdgeInsetsZero;
    }
    return _tableview;
}

- (NSArray *)menuArray{
    if (!_menuArray) {
        _menuArray = [CommonTool arrayFromPlist:@"menuData.plist"];
    }
    return _menuArray;
}

- (NSMutableArray *)discountArray{
    if (!_discountArray) {
        _discountArray = [@[] mutableCopy];
    }
    return _discountArray;
}

- (NSMutableArray *)recommentArray{
    if (!_recommentArray) {
        _recommentArray = [@[] mutableCopy];
    }
    return _recommentArray;
}
#pragma mark - tableview代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        static NSString *use = @"menu";
        HomeMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:use];
        if (!cell) {
            cell = [[HomeMenuCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:use];
            cell.dataArray = self.menuArray;
            cell.delegate = self;
            
        }
        return cell;
    }else if (indexPath.section == 2){
        static NSString *use = @"discount";
        DiscountCell *cell = [tableView dequeueReusableCellWithIdentifier:use];
        if (!cell) {
            cell = [[DiscountCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:use];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.delegate = self;
        cell.discountArray = self.discountArray;
        return cell;
    }else if (indexPath.section == 4){
        if (indexPath.row == 0) {
            static NSString *use = @"guesslike";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:use];
            if (!cell) {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:use];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            cell.textLabel.text = @"猜你喜欢";
            return cell;
        }else{
            static NSString *use = @"guesslike";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:use];
            if (!cell) {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:use];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            cell.textLabel.text = @"猜你喜欢";
            return cell;
        }
    }else{
        static NSString *use = @"menu";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:use];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:use];
        }
        
        return cell;
    }
  
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    
//}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 180;
    }else if(indexPath.section == 1){
        return 120;
    }else if(indexPath.section == 2){
        return 160;
    }else if(indexPath.section == 3){
        return 50;
    }else if(indexPath.section == 4){
        if (indexPath.row==0) {
            return 35;
        }
        return 100;
    }else{
        return 70;
    }
}
@end
