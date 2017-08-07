//
//  CommonTool.m
//  YJMeituan
//
//  Created by wanyongjian on 2017/8/2.
//  Copyright © 2017年 eco. All rights reserved.
//

#import "CommonTool.h"

@implementation CommonTool

+ (NSMutableArray *)arrayFromPlist:(NSString *)name{
    
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:nil];
    NSMutableArray *array = [[NSMutableArray alloc]initWithContentsOfFile:path];
    return array;
}

+ (UIColor *)colorFromStr:(NSString*)colorStr{
    
    NSString *cString = [[colorStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    if ([cString length] != 6) return [UIColor blackColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    // Scan values
    unsigned int r, g, b;
    
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}
@end
