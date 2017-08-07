//
//  DiscountCell.h
//  YJMeituan
//
//  Created by wanyongjian on 2017/8/7.
//  Copyright © 2017年 eco. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YJDiscountModel.h"

@protocol DiscountCellDelegate <NSObject>

- (void)discountItemClicked:(NSString *)str;

@end

@interface DiscountCell : UITableViewCell

@property(nonatomic,strong) NSMutableArray *discountArray;
@property(nonatomic,assign) id <DiscountCellDelegate> delegate;

@end
