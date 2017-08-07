//
//  DiscountCell.m
//  YJMeituan
//
//  Created by wanyongjian on 2017/8/7.
//  Copyright © 2017年 eco. All rights reserved.
//

#import "DiscountCell.h"
#import "DiscountCellView.h"

@interface DiscountCell()

@property (nonatomic,strong) NSMutableArray *cellViewArray;
@end



@implementation DiscountCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        for (NSInteger i=0; i<4; i++) {
            DiscountCellView *view = [[DiscountCellView alloc]initWithFrame:CGRectMake((i%2)*KScreenWidth_2, i<=1?0:80, KScreenWidth_2, 80)];
            [self addSubview:view];
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(discountViewtapped:)];
            [view addGestureRecognizer:tap];
            
            [self.cellViewArray addObject:view];
        }
    }
    return self;
}

- (void)discountViewtapped:(UIGestureRecognizer *)sender{
    DiscountCellView *view = (DiscountCellView*)sender.view;
    NSString *url = view.discountModel.tplurl;
    NSRange range = [url rangeOfString:@"http"];
    NSString *str = [url substringFromIndex:range.location];
    
    if ([self.delegate respondsToSelector:@selector(discountItemClicked:)]) {
        [self.delegate  discountItemClicked:str];
    }
}

-(void)setDiscountArray:(NSMutableArray *)discountArray{
    if (discountArray.count != 4) {
        return;
    }
    
    for (NSInteger i=0; i<4; i++) {
        DiscountCellView *view = self.cellViewArray[i];
        view.discountModel = discountArray[i];
    }
}

- (NSMutableArray *)cellViewArray{
    if (!_cellViewArray) {
        _cellViewArray = [@[] mutableCopy];
    }
    return _cellViewArray;
}
@end
