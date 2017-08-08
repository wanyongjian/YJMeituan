//
//  YJDiscountWebViewController.m
//  YJMeituan
//
//  Created by wanyongjian on 2017/8/7.
//  Copyright © 2017年 eco. All rights reserved.
//

#import "YJDiscountWebViewController.h"

@interface YJDiscountWebViewController () <UIWebViewDelegate>

@property (nonatomic,strong) UIActivityIndicatorView *indicatorView;
@end



@implementation YJDiscountWebViewController

- (void)viewDidLoad{
    
    [super viewDidLoad];
    
    [self setNav];
    
    self.view.backgroundColor = [UIColor grayColor];
    [self.view addSubview:self.webView];
    [self.view addSubview:self.indicatorView];
    
}

- (void)setNav{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 25, 25);
    [button setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(backButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
}

- (void)backButtonClicked:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - lazyload
- (UIWebView *)webView{
    if (!_webView) {
        _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight)];
        _webView.backgroundColor = [UIColor whiteColor];
        _webView.scalesPageToFit = YES;
        _webView.delegate = self;
        
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.urlStr]];
        [_webView loadRequest:request];
    }
    return _webView;
}

- (UIActivityIndicatorView *)indicatorView{
    if (!_indicatorView) {
        _indicatorView = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(0, 0, 60, 60)];
        _indicatorView.center = self.view.center;
        _indicatorView.hidesWhenStopped = YES;
        _indicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
        [_indicatorView startAnimating];
    }
    return _indicatorView;
}
- (void)webViewDidStartLoad:(UIWebView *)webView{
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [_indicatorView stopAnimating];
    NSString *title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    self.title = title;
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    return YES;
}
@end
