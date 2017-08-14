//
//  YJAnnotationView.m
//  YJMeituan
//
//  Created by wanyongjian on 2017/8/14.
//  Copyright © 2017年 eco. All rights reserved.
//

#import "YJAnnotationView.h"

@implementation YJAnnotationView

- (void)setAnnotationModel:(YJInnotationModel *)annotationModel{
    _annotationModel = annotationModel;
    
    self.image = [UIImage imageNamed:@"icon_map_cateid_1"];
    
    //左边图片
    UIImageView *leftCalloutImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 32, 41)];
    NSString *imgUrl = [_annotationModel.imgurl stringByReplacingOccurrencesOfString:@"w.h" withString:@"104.63"];
    [leftCalloutImg sd_setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:[UIImage imageNamed:@"bg_customReview_image_default"]];
    self.leftCalloutAccessoryView = leftCalloutImg;
}
@end
