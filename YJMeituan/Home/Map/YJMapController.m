//
//  YJMapController.m
//  YJMeituan
//
//  Created by wanyongjian on 2017/8/10.
//  Copyright © 2017年 eco. All rights reserved.
//

#import "YJMapController.h"
#import <MapKit/MapKit.h>
#import "AppDelegate.h"
#import "YJInnotationModel.h"
#import "YJMKPointAnotation.h"
#import "YJAnnotationView.h"

@interface YJMapController () <BMKMapViewDelegate,BMKLocationServiceDelegate>
{
    BMKMapView *_bmapView;
    BMKLocationService *_locationService;
    
}

@property (nonatomic,strong) UIButton *backButton;
@property (nonatomic,strong) NSMutableArray *innotationArray;
@end

@implementation YJMapController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    //定位
//    _locationService = [[BMKLocationService alloc]init];
//    _locationService.delegate = self;
//    [_locationService startUserLocationService];
    
    _bmapView = [[BMKMapView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:_bmapView];
    [self.view addSubview:self.backButton];
    
//    _bmapView.showsUserLocation = YES;
    [self mapInnotationData];
}


- (void)mapInnotationData{
    NSString *url = [[GetUrlString sharedManager]urlWithMapData];
    [NetWrok getDataFromURL:url paraments:nil success:^(id response) {
        NSMutableArray *array = response[@"data"];
        [self.innotationArray removeAllObjects];
        [_bmapView removeAnnotations:_bmapView.annotations];
        for (NSInteger i=0; i<array.count; i++) {
            
           
            YJInnotationModel *innotationModel = [YJInnotationModel mj_objectWithKeyValues:array[i]];
            
            
            YJMKPointAnotation *annotation = [[YJMKPointAnotation alloc]init];
            annotation.annotationModel = innotationModel;
            annotation.title = innotationModel.mname;
            annotation.subtitle = innotationModel.price;
            
            if (innotationModel.rdplocs.count >0) {
                NSDictionary *dict = innotationModel.rdplocs[0];
                annotation.coordinate = CLLocationCoordinate2DMake([dict[@"lat"] doubleValue], [dict[@"lng"] doubleValue]);
            }
            [_bmapView addAnnotation:annotation];
            [self.innotationArray addObject:annotation];
        }
        
    } failure:^(NSError *error) {
        
    }];
}


- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation{
    
}

- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation{
    [_bmapView updateLocationData:userLocation];
    [_bmapView setCenterCoordinate:userLocation.location.coordinate animated:YES];
}


- (void)addAnnotation{
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    CLLocationCoordinate2D coor = CLLocationCoordinate2DMake(delegate.latitude, delegate.longitude);//原始坐标
    NSDictionary* testdic = BMKConvertBaiduCoorFrom(coor,BMK_COORDTYPE_GPS);
    NSLog(@"x=%@,y=%@",[testdic objectForKey:@"x"],[testdic objectForKey:@"y"]);
    CLLocationCoordinate2D baiduCoor = BMKCoorDictionaryDecode(testdic);//转换后的百度坐标
    
    //    _bmapView.userTrackingMode = BMKUserTrackingModeFollow;
    //    _bmapView.showsUserLocation = YES;
    //设置显示区域
//    [_bmapView setRegion:BMKCoordinateRegionMakeWithDistance(baiduCoor, 5000, 5000) animated:YES];
    
    //添加标注
    BMKPointAnnotation *anotation = [[BMKPointAnnotation alloc]init];
    anotation.coordinate = baiduCoor;
    anotation.title = @"苏州";
    anotation.subtitle = @"工作的地方";
    [_bmapView addAnnotation:anotation];
}

- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id<BMKAnnotation>)annotation{
    if ([annotation isKindOfClass:[YJMKPointAnotation class]]) {
        YJMKPointAnotation *YJAnnotation = (YJMKPointAnotation *)annotation;
        
        YJAnnotationView *annotationView = (YJAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"myAnnotation"];
        if (!annotationView) {
            annotationView = [[YJAnnotationView alloc]initWithAnnotation:YJAnnotation reuseIdentifier:@"myAnnotation"];
        }
        
        annotationView.annotationModel = YJAnnotation.annotationModel;
        
        return annotationView;
    }
    return nil;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [_bmapView viewWillAppear];
    _bmapView.delegate = self;
    
//    [self addAnnotation];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [_bmapView viewWillDisappear];
    _bmapView.delegate = nil;
}

- (UIButton *)backButton{
    if (!_backButton) {
        _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
        _backButton.frame = CGRectMake(20, 20, 30, 30);
        [_backButton addTarget:self action:@selector(backButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backButton;
}

- (NSMutableArray *)innotationArray{
    if (!_innotationArray) {
        _innotationArray = [@[] mutableCopy];
    }
    return _innotationArray;
}
- (void)backButtonClicked{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
