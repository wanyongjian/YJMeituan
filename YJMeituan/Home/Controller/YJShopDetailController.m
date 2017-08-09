//
//  YJShopDetailController.m
//  YJMeituan
//
//  Created by wanyongjian on 2017/8/8.
//  Copyright © 2017年 eco. All rights reserved.
//

#import "YJShopDetailController.h"
#import "YJRecommentModel.h"
#import "YJRecommentCell.h"

@interface YJShopDetailController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) NSMutableArray *otherLookArray;
@end

@implementation YJShopDetailController


- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if(self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]){
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;

}
- (void)
viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    
    //推荐数据
    NSString *url = [[GetUrlString sharedManager] urlWithOtherRecommendShop:self.shopID];
    [NetWrok getDataFromURL:url paraments:nil success:^(id response) {
        NSMutableDictionary *dataArray = response[@"data"];
        NSMutableArray *dealsArray = dataArray[@"deals"];
        [self.otherLookArray removeAllObjects];
        for (NSInteger i=0; i<dealsArray.count; i++) {
            YJRecommentModel *recommentModel = [YJRecommentModel mj_objectWithKeyValues:dealsArray[i]];
            [self.otherLookArray addObject:recommentModel];
        }
        
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
}


#pragma mark - tableview代理方法
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return 190;
        } else if (indexPath.row == 1){
            return 65;
        } else if (indexPath.row == 2){
            return 45;
        }
    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            return 30;
        }else{
            return 100;
        }
    }
    return 100;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0;
    }
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 5;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 3;
    }else{
        return self.otherLookArray.count+1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        static NSString *reUseId = @"otherLookCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reUseId];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reUseId];
        }
        return cell;
    }else if(indexPath.section == 1){
        if (indexPath.row == 0) {
            static NSString *reUseId = @"otherLookCell";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reUseId];
            if (!cell) {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reUseId];
            }
            cell.textLabel.text = @"看了本团购的用户还看了";
            return cell;
        }else{
            static NSString *use = @"recomment";
            YJRecommentCell *cell = [tableView dequeueReusableCellWithIdentifier:use];
            if (!cell) {
                cell = [[YJRecommentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:use];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            cell.recommentModel = self.otherLookArray[indexPath.row-1];
            return cell;
        }
    }else{
        static NSString *reUseId = @"otherLookCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reUseId];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reUseId];
        }
        return cell;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        if (indexPath.row != 0) {
            YJRecommentModel *model = self.otherLookArray[indexPath.row-1];
            YJShopDetailController *shopController = [[YJShopDetailController alloc]init];
            shopController.shopID = model.id;
            [self.navigationController pushViewController:shopController animated:YES];
        }
    }
}
#pragma mark - lazyload

- (UITableView *)tableView{
    
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorInset = UIEdgeInsetsZero;
    }
    return _tableView;
}

- (NSMutableArray *)otherLookArray{
    if (!_otherLookArray) {
        _otherLookArray = [@[] mutableCopy];
    }
    return _otherLookArray;
}
@end
