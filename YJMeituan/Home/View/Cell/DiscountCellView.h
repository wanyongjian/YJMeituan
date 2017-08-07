//
//  DiscountCellView.h
//  YJMeituan
//
//  Created by wanyongjian on 2017/8/7.
//  Copyright © 2017年 eco. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YJDiscountModel.h"

@interface DiscountCellView : UIView

@property (nonatomic,strong) UILabel *mainTitleLabel;
@property (nonatomic,strong) UILabel *subTitleLabel;
@property (nonatomic,strong) UIImageView *rightImage;

@property (nonatomic,strong) YJDiscountModel *discountModel;
@end
