//
//  YJMKPointAnotation.h
//  YJMeituan
//
//  Created by wanyongjian on 2017/8/10.
//  Copyright © 2017年 eco. All rights reserved.
//

#import <MapKit/MapKit.h>
#import "YJInnotationModel.h"

@interface YJMKPointAnotation : BMKPointAnnotation

@property (nonatomic,strong) YJInnotationModel *annotationModel;
@end
