//
//  HomeMenuCell.m
//  YJMeituan
//
//  Created by wanyongjian on 2017/8/2.
//  Copyright © 2017年 eco. All rights reserved.
//

#import "HomeMenuCell.h"
#import "MenuButton.h"

@interface HomeMenuCell() <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIPageControl *pageController;

@property (nonatomic,strong) UIView *leftView;
@property (nonatomic,strong) UIView *rightView;

@property (nonatomic,strong) NSMutableArray *buttonArray;
@end

@implementation HomeMenuCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.scrollView];
        [self.contentView addSubview:self.pageController];
        [self.scrollView addSubview:self.leftView];
        [self.scrollView addSubview:self.rightView];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [_pageController mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.contentView.mas_centerX);
        make.bottom.mas_equalTo(self.contentView.mas_bottom);
        make.height.mas_equalTo(20);
    }];
}

- (void)setDataArray:(NSMutableArray *)dataArray{
    for (NSInteger i=0; i<dataArray.count; i++) {
        UIButton *button = self.buttonArray[i];
        NSDictionary *dataDict = dataArray[i];
        [button setTitle:dataDict[@"title"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:dataDict[@"image"]] forState:UIControlStateNormal];
    }
}


#pragma mark - lazyload
- (UIScrollView *)scrollView{
    
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 160)];
        _scrollView.pagingEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.delegate = self;
        _scrollView.contentSize = CGSizeMake(KScreenWidth*2, 160);
    }
    return _scrollView;
}

- (UIPageControl *)pageController{
    if (!_pageController) {
        _pageController = [[UIPageControl alloc]init];
        
        _pageController.numberOfPages = 2;
        _pageController.pageIndicatorTintColor = [UIColor grayColor];
        _pageController.currentPageIndicatorTintColor = TabbarColor;
    }
    return _pageController;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    self.pageController.currentPage = scrollView.contentOffset.x/KScreenWidth;
}

- (UIView *)leftView{
    if (!_leftView) {
        _leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 160)];
        _leftView.backgroundColor = [UIColor greenColor];
        
        CGFloat piceWidth = KScreenWidth/4.0f;
        CGFloat piceHeight = 160/2;
        for (NSInteger i=0; i<8; i++) {
            MenuButton *button = [[MenuButton alloc]initWithFrame:CGRectMake(piceWidth*(i%4), (i<=3?0:1)*piceHeight, piceWidth, piceHeight)];
            [button addTarget:self action:@selector(menuButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            [_leftView addSubview:button];
            button.backgroundColor = [UIColor whiteColor];
            [self.buttonArray addObject:button];
        }
    }
    return _leftView;
}

- (UIView *)rightView{
    if (!_rightView) {
        _rightView = [[UIView alloc]initWithFrame:CGRectMake(KScreenWidth, 0, KScreenWidth, 160)];
        _rightView.backgroundColor = [UIColor whiteColor];
        
        CGFloat piceWidth = KScreenWidth/4.0f;
        CGFloat piceHeight = 160/2;
        for (NSInteger i=0; i<8; i++) {
            MenuButton *button = [[MenuButton alloc]initWithFrame:CGRectMake(piceWidth*(i%4), (i<=3?0:1)*piceHeight, piceWidth, piceHeight)];
            [button addTarget:self action:@selector(menuButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            [_rightView addSubview:button];
            [self.buttonArray addObject:button];
        }
    }
    return _rightView;
}

- (NSMutableArray *)buttonArray{
    if (!_buttonArray) {
        _buttonArray = [@[] mutableCopy];
    }
    return _buttonArray;
}

- (void)menuButtonClick:(UIButton *)sender{
//    self.menuClick(sender);
    NSInteger index = [self.buttonArray indexOfObject:sender];
    if ([self.delegate respondsToSelector:@selector(menuButtonClickedAtIndex:)]) {
        [self.delegate menuButtonClickedAtIndex:index];
    }
}
@end
