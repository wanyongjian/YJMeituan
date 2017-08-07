//
//  DiscountCellView.m
//  YJMeituan
//
//  Created by wanyongjian on 2017/8/7.
//  Copyright © 2017年 eco. All rights reserved.
//

#import "DiscountCellView.h"
@implementation DiscountCellView

- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        self.layer.borderWidth = 0.25;
        self.layer.borderColor = [separaterColor CGColor];
        
        [self addSubview:self.rightImage];
        [self addSubview:self.mainTitleLabel];
        [self addSubview:self.subTitleLabel];
        
    }
    return self;
}

- (void)setDiscountModel:(YJDiscountModel *)discountModel{
    _discountModel = discountModel;
    
    _mainTitleLabel.text = discountModel.maintitle;
    _mainTitleLabel.textColor = [CommonTool colorFromStr:discountModel.typeface_color];
    
    _subTitleLabel.text = discountModel.deputytitle;
    _subTitleLabel.textColor = [CommonTool colorFromStr:discountModel.deputy_typeface_color];
    
    [_rightImage sd_setImageWithURL:[NSURL URLWithString:[discountModel.imageurl stringByReplacingOccurrencesOfString:@"w.h" withString:@"120.0"]] placeholderImage:nil];
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [_mainTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(20);
        make.bottom.mas_equalTo(self.mas_centerY);
        
    }];
    
    [_subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(20);
        make.top.mas_equalTo(_mainTitleLabel).offset(20);
    }];
    
    [_rightImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self);
        make.bottom.mas_equalTo(self);
        make.top.mas_equalTo(self);
        make.width.mas_equalTo(80);
    }];
}
#pragma mark - lazyload
- (UILabel *)mainTitleLabel{
    if (!_mainTitleLabel) {
        _mainTitleLabel = [[UILabel alloc]init];
        _mainTitleLabel.numberOfLines = 0;
        _mainTitleLabel.font = [UIFont systemFontOfSize:16];
    }
    
    return _mainTitleLabel;
}

- (UILabel *)subTitleLabel{
    if (!_subTitleLabel) {
        _subTitleLabel = [[UILabel alloc]init];
        _subTitleLabel.numberOfLines = 0;
        _subTitleLabel.font = [UIFont systemFontOfSize:12];
    }
    return _subTitleLabel;
}

- (UIImageView *)rightImage{
    if (!_rightImage) {
        _rightImage = [[UIImageView alloc]init];
//        _rightImage.backgroundColor = [UIColor greenColor];
    }
    return _rightImage;
}
@end
