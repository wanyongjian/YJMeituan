//
//  MenuButton.m
//  YJMeituan
//
//  Created by wanyongjian on 2017/8/4.
//  Copyright © 2017年 eco. All rights reserved.
//

#import "MenuButton.h"

@implementation MenuButton

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.titleLabel.font = [UIFont systemFontOfSize:13];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return self;
}


- (CGRect)titleRectForContentRect:(CGRect)contentRect{
    return CGRectMake(0, contentRect.size.height-20, contentRect.size.width, 20);
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect{
    CGFloat width = MIN(contentRect.size.height-20-15, contentRect.size.width);
    return CGRectMake((contentRect.size.width-width)/2, 15, width, width);
}
@end
