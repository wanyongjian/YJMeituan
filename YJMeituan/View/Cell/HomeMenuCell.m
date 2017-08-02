//
//  HomeMenuCell.m
//  YJMeituan
//
//  Created by wanyongjian on 2017/8/2.
//  Copyright © 2017年 eco. All rights reserved.
//

#import "HomeMenuCell.h"

@interface HomeMenuCell() <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIPageControl *pageController;
@end

@implementation HomeMenuCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.scrollView];
        [self.contentView addSubview:self.pageController];
    }
    return self;
}

//- (void)layoutSubviews{
//    [super layoutSubviews];
//    
//}

- (void)setDataArray:(NSMutableArray *)dataArray{
    
}


#pragma mark - lazyload
- (UIScrollView *)scrollView{
    
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 180)];
        _scrollView.pagingEnabled = YES;
        _scrollView.backgroundColor = [UIColor darkGrayColor];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.delegate = self;
        _scrollView.contentSize = CGSizeMake(KScreenWidth*2, 180);
    }
    return _scrollView;
}

- (UIPageControl *)pageController{
    if (!_pageController) {
        _pageController = [[UIPageControl alloc]initWithFrame:CGRectMake(KScreenWidth/2, 160, 0, 20)];
        _pageController.numberOfPages = 2;
        _pageController.pageIndicatorTintColor = [UIColor grayColor];
        _pageController.currentPageIndicatorTintColor = TabbarColor;
        _pageController.backgroundColor = [UIColor redColor];
    }
    return _pageController;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    self.pageController.currentPage = scrollView.contentOffset.x/KScreenWidth;
}
@end
