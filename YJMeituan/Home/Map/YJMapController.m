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
@interface YJMapController () <MKMapViewDelegate>

@end

@implementation YJMapController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    MKMapView *mapView = [[MKMapView alloc]init];
    mapView.frame = CGRectMake(0, 0, KScreenWidth, KScreenHeight);
    [self.view addSubview:mapView];
    mapView.delegate = self;
    
    /**  跟踪位置并显示 */
//    mapView.userTrackingMode = MKUserTrackingModeFollow;
    /**  地图类型 */
    mapView.mapType = MKMapTypeStandard;
    
    /**  设置显示区域 */
    mapView.showsUserLocation = YES;
    AppDelegate *delegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    [mapView setRegion:MKCoordinateRegionMakeWithDistance(CLLocationCoordinate2DMake(delegate.latitude, delegate.longitude), 5000, 5000) animated:YES];
    
    /**  移动地图 */
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        CLLocationCoordinate2D mapcenter = mapView.centerCoordinate;
        mapcenter = [mapView convertPoint:CGPointMake(1, KScreenWidth/2) toCoordinateFromView:mapView];
        [mapView setCenterCoordinate:mapcenter animated:YES];
    });
    
    /**  缩放地图 */
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        MKCoordinateRegion region = mapView.region;
        region.span.latitudeDelta *=1.1;
        region.span.latitudeDelta *=1.1;
        [mapView setRegion:region animated:YES];
    });
    
    /**  添加标注 使用默认标注*/
    /**  实现viewForAnnotation代理方法 用MKPinAnnotationView标准的大头针标注样式 */
    /**  实现viewForAnnotation代理方法 用MKAnnotationView自定义的静态图片展示样式 */
    MKPointAnnotation *anotation0 = [[MKPointAnnotation alloc]init];
    [anotation0 setCoordinate:CLLocationCoordinate2DMake(delegate.latitude, delegate.longitude)];
    [anotation0 setTitle:@"ecovacsallalalallall"];
    [anotation0 setSubtitle:@"工作的地方的地方地方地方"];
    [mapView addAnnotation:anotation0];
    
}


#pragma mark - 地图代理方法
/**  每次调用传入最新位置*/
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    NSLog(@"-----== %@",userLocation.location);
}
/**  地图显示区域即将改变调用*/
- (void)mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated{
    
}
/**  地图显示区域已经改变调用*/
- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated{
    
}

/**  实现viewForAnnotation代理方法 用MKPinAnnotationView标准的大头针标注样式 */
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation{
    // If the annotation is the user location, just return nil.（如果是显示用户位置的Annotation,则使用默认的蓝色圆点）
    if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    if ([annotation isKindOfClass:[MKPointAnnotation class]]) {
        // Try to dequeue an existing pin view first.（这里跟UITableView的重用差不多）
        MKPinAnnotationView *customPinView = (MKPinAnnotationView*)[mapView
                                                                    dequeueReusableAnnotationViewWithIdentifier:@"CustomPinAnnotationView"];
        if (!customPinView){
            // If an existing pin view was not available, create one.
            customPinView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation
                                                            reuseIdentifier:@"CustomPinAnnotationView"];
        }
        //iOS9中用pinTintColor代替了pinColor
        customPinView.pinColor = MKPinAnnotationColorPurple;
        customPinView.animatesDrop = YES;
        customPinView.canShowCallout = YES;
        
        UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 50)];
        rightButton.backgroundColor = [UIColor grayColor];
        [rightButton setTitle:@"查看详情" forState:UIControlStateNormal];
        customPinView.rightCalloutAccessoryView = rightButton;
        
        // Add a custom image to the left side of the callout.（设置弹出起泡的左面图片）
        UIImageView *myCustomImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"myimage"]];
        customPinView.leftCalloutAccessoryView = myCustomImage;
        return customPinView;
    }
    return nil;//返回nil代表使用默认样式
}

/**  实现viewForAnnotation代理方法 用MKAnnotationView自定义的静态图片展示样式 */
//- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
//{
//    // If the annotation is the user location, just return nil.
//    if ([annotation isKindOfClass:[MKUserLocation class]])
//        return nil;
//    if ([annotation isKindOfClass:[MKPointAnnotation class]]) {
//        MKAnnotationView* aView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"MKPointAnnotation"];
//        aView.image = [UIImage imageNamed:@"myimage"];
//        aView.canShowCallout = YES;
//        return aView;
//    }
//    return nil;
//}
@end
