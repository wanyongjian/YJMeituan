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
#import "YJRecommentCell.h"
#import "YJShopDetailController.h"
#import "YJMapController.h"

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
    [self tableRefresh];
    [self navigationBar];
}

- (void)navigationBar{
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0, 0, 40, 35);
    leftButton.titleLabel.font = [UIFont systemFontOfSize:12];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    [leftButton setImage:[UIImage imageNamed:@"icon_homepage_upArrow"] forState:UIControlStateNormal];
    [leftButton setImage:[UIImage imageNamed:@"icon_homepage_downArrow"] forState:UIControlStateSelected];
    [leftButton setTitle:@"上海" forState:UIControlStateNormal];
//    leftButton.contentHorizontalAlignment = YES;
    leftButton.titleEdgeInsets = UIEdgeInsetsMake(0, -30, 0, 0);
    leftButton.imageEdgeInsets = UIEdgeInsetsMake(0, 30, 0, 0);
    [leftButton addTarget:self action:@selector(leftBarbuttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *mapButton = [UIButton buttonWithType:UIButtonTypeCustom];
    mapButton.frame = CGRectMake(0, 0, 50, 35);
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:mapButton];
    [mapButton setImage:[UIImage imageNamed:@"icon_homepage_map_old"] forState:UIControlStateNormal];
    [mapButton addTarget:self action:@selector(rightMapbuttonClicked) forControlEvents:UIControlEventTouchUpInside];
    UISearchBar *searchBar = [[UISearchBar alloc]init];
    searchBar.layer.cornerRadius = 15;
    searchBar.layer.masksToBounds = YES;
//    [searchBar setBackgroundImage:[UIImage imageNamed:@"icon_homepage_search"]];
    self.navigationItem.titleView = searchBar;
    searchBar.placeholder = @"点击查找";
}

- (void)rightMapbuttonClicked{
    YJMapController *mapcontroller = [[YJMapController alloc] init];
    [self presentViewController:mapcontroller animated:YES completion:nil];
}

- (void)leftBarbuttonClicked:(UIButton *)sender{
    sender.selected = !sender.selected;
}

- (void)tableRefresh{
    
    NSMutableArray *idleImgArray = [@[] mutableCopy];
    for (NSInteger i=1; i<=60; i++) {
        NSString *imageName = [NSString stringWithFormat:@"dropdown_anim__000%ld",(long)i];
        UIImage *image = [UIImage imageNamed:imageName];
        [idleImgArray addObject:image];
    }
    
    NSMutableArray *pullImgArray = [@[] mutableCopy];
    for (int i=1; i<=3; i++) {
        NSString *imageName = [NSString stringWithFormat:@"dropdown_loading_%02d",i];
        UIImage *image = [UIImage imageNamed:imageName];
        [pullImgArray addObject:image];
    }
    
    MJRefreshGifHeader *gifHeader = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshAction)];
    self.tableview.mj_header = gifHeader;
    [gifHeader setImages:idleImgArray forState:MJRefreshStateIdle];
    [gifHeader setImages:pullImgArray forState:MJRefreshStatePulling];
    [gifHeader setImages:pullImgArray forState:MJRefreshStateRefreshing];
    [gifHeader beginRefreshing];
}

                                     
- (void)refreshAction{
   
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [self loadRushbuyData];
        [self loadDiscountData];
        [self loadRecommentData];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
        });
    });
}
#pragma mark - 网络数据的获取
- (void)loadRushbuyData{
    //抢购数据
    NSString *url = [[GetUrlString sharedManager] urlWithRushBuy];
    [NetWrok getDataFromURL:url paraments:nil success:^(id response) {
        
    } failure:^(NSError *error) {
        [self.tableview.mj_header endRefreshing];
    }];
}

- (void)loadDiscountData{
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
        [self.tableview.mj_header endRefreshing];
    }];
}


- (void)loadRecommentData{
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
        
        [self.tableview reloadData];
        [self.tableview.mj_header endRefreshing];
    } failure:^(NSError *error) {
        [self.tableview.mj_header endRefreshing];
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
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section  == 4) {
        if (indexPath.row != 0) {
            YJShopDetailController *controller = [[YJShopDetailController alloc]init];
            YJRecommentModel *model = self.recommentArray[indexPath.row-1];
            controller.shopID = model.id;
            [self.navigationController pushViewController:controller animated:YES];
        }
    }
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 4) {
        return self.recommentArray.count+1;
    }
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
            static NSString *use = @"recomment";
            YJRecommentCell *cell = [tableView dequeueReusableCellWithIdentifier:use];
            if (!cell) {
                cell = [[YJRecommentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:use];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            cell.recommentModel = self.recommentArray[indexPath.row-1];
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

- (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size

{
    
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    
    CGContextFillRect(context, rect);
    
    
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    
    
    return image;
    
}
@end
