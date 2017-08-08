//
//  YJRecommentCell.m
//  YJMeituan
//
//  Created by wanyongjian on 2017/8/8.
//  Copyright © 2017年 eco. All rights reserved.
//

#import "YJRecommentCell.h"

@interface YJRecommentCell()

@property (nonatomic,strong) UIImageView *shopImg;
@property (nonatomic,strong) UILabel *shopNameLabel;
@property (nonatomic,strong) UILabel *shopDesLabel;
@property (nonatomic,strong) UILabel *priceLabel;
@end



@implementation YJRecommentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.shopImg];
        [self.contentView addSubview:self.shopNameLabel];
        [self.contentView addSubview:self.shopDesLabel];
        [self.contentView addSubview:self.priceLabel];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [_shopImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(2);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.width.height.mas_equalTo(80);
        
    }];
    
    [_shopNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_shopImg.mas_right).offset(10);
        make.top.mas_equalTo(self);
        make.height.mas_equalTo(30);
        make.right.mas_equalTo(self);
    }];
    
    [_shopDesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_shopImg.mas_right).offset(10);
        make.top.mas_equalTo(_shopNameLabel.mas_bottom);
        make.right.mas_equalTo(self);
        make.height.mas_equalTo(45);
    }];
    
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_shopImg.mas_right).offset(10);
        make.bottom.mas_equalTo(self);
        make.top.mas_equalTo(_shopDesLabel.mas_bottom);
        make.right.mas_equalTo(self);
    }];
}


- (void)setRecommentModel:(YJRecommentModel *)recommentModel{
    _recommentModel = recommentModel;
    
    NSString *shopImgUrl = [recommentModel.squareimgurl stringByReplacingOccurrencesOfString:@"w.h" withString:@"160.0"];
    [_shopImg sd_setImageWithURL:[NSURL URLWithString:shopImgUrl] placeholderImage:nil];
    
    _shopNameLabel.text = recommentModel.mname;
    _shopDesLabel.text = [NSString stringWithFormat:@"[%@]%@",recommentModel.range,recommentModel.title];
    _priceLabel.text = [NSString stringWithFormat:@"%@元",recommentModel.price];
    ;
    
}


#pragma mark - lazyload
- (UIImageView *)shopImg{
    if (!_shopImg) {
        _shopImg = [[UIImageView alloc]init];
    }
    return _shopImg;
}

- (UILabel *)shopNameLabel{
    if (!_shopNameLabel) {
        _shopNameLabel = [[UILabel alloc]init];
        _shopNameLabel.font = [UIFont systemFontOfSize:17];
    }
    return _shopNameLabel;
}

- (UILabel *)shopDesLabel{
    if (!_shopDesLabel) {
        _shopDesLabel = [[UILabel alloc]init];
        _shopDesLabel.font = [UIFont systemFontOfSize:14];
        _shopDesLabel.textColor = [UIColor darkGrayColor];
    }
    return _shopDesLabel;
}

- (UILabel *)priceLabel{
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc]init];
        _priceLabel.font = [UIFont systemFontOfSize:16];
    }
    return _priceLabel;
}
@end
