//
//  ViewController.m
//  GCD
//
//  Created by 刘冉 on 2017/4/25.
//  Copyright © 2017年 刘冉. All rights reserved.
//

#import "ViewController.h"
#import "ViewController+Last.h"
#import "RCountdownView.h"
#import "YSCRippleView.h"
#import <WebKit/WebKit.h>
#import "Extern.h"

@interface ViewController ()<UIScrollViewDelegate>

@property(nonatomic,strong)UIButton* timerBtn;
@property(nonatomic,strong)RCountdownView* countdownView;
@property(nonatomic,strong)YSCRippleView* rippleView;
@property(nonatomic,strong)WKWebView* webView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    name = @"jjjjj";
    NSLog(@"%@",name);
//    [self.view addSubview:self.timerBtn];
//    [self.view addSubview:self.countdownView];
//    [self.view addSubview:self.rippleView];
//    [self.rippleView showWithRippleType:YSCRippleTypeCircle];
//    [self.view addSubview:self.webView];
//    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://uland.taobao.com/coupon/edetail?activityId=f5591596c94b4e31aa4674a6f2ea28c5&pid=mm_118979121_0_0&itemId=527958137179"]]];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    name = @"sjsjjs";
    NSLog(@"%@",name);
}

-(WKWebView *)webView{
    if (!_webView) {
        _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 100, self.view.bounds.size.width, 200)];
        _webView.scrollView.delegate = self;
        _webView.scrollView.scrollEnabled = NO;
    }
    return _webView;
}

-(RCountdownView *)countdownView{
    if (!_countdownView) {
        _countdownView = [[RCountdownView alloc] initWithFrame:CGRectMake(100, 200, 60, 60)];
    }
    return _countdownView;
}


-(UIButton *)timerBtn{
    if (!_timerBtn) {
        _timerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_timerBtn setTitle:@"start" forState:UIControlStateNormal];
        _timerBtn.frame = CGRectMake(100, 100, 60, 60);
        _timerBtn.backgroundColor = [UIColor yellowColor];
        [_timerBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_timerBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _timerBtn;
}

//- (YSCRippleView *)rippleView
//{
//    if (!_rippleView) {
//        self.rippleView = [[YSCRippleView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 300)];
//    }
//    
//    return _rippleView;
//}

-(void)click:(UIButton*)sender{
    NSLog(@"click");
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
