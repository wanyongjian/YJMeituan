//
//  CommonTool.h
//  YJMeituan
//
//  Created by wanyongjian on 2017/8/2.
//  Copyright © 2017年 eco. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CommonTool : NSObject

+ (NSMutableArray *)arrayFromPlist:(NSString*)name;

+ (UIColor *)colorFromStr:(NSString *)str;
@end
