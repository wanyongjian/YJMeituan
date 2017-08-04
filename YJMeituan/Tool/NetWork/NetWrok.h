//
//  NetWrok.h
//  YJMeituan
//
//  Created by wanyongjian on 2017/8/4.
//  Copyright © 2017年 eco. All rights reserved.
//

#import <Foundation/Foundation.h>

//typedef void(^SuccessBlock)(id response);
//typedef void(^FailureBlock)(NSError *error);
@interface NetWrok : NSObject


+ (void)getDataFromURL:(NSString*)url paraments:(NSDictionary*)paraments success:(void(^)(id response))success failure:(void(^)(NSError *error))failure;
@end
