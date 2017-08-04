//
//  NetWrok.m
//  YJMeituan
//
//  Created by wanyongjian on 2017/8/4.
//  Copyright © 2017年 eco. All rights reserved.
//

#import "NetWrok.h"
@implementation NetWrok

+ (void)getDataFromURL:(NSString *)url paraments:(NSDictionary *)paraments success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:url parameters:paraments progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        success(responseObject);
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
    
    
}
@end
