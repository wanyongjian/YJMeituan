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
@end
