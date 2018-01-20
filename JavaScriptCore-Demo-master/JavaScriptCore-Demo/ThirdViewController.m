//
//  ThirdViewController.m
//  JavaScriptCore-Demo
//
//  Created by haohao on 2018/1/19.
//  Copyright © 2018年 www.skyfox.org. All rights reserved.
//

#import "ThirdViewController.h"
#import <WebKit/WebKit.h>
//https://api.zjhemai.com/clientweb/index.html  uid=73
@interface ThirdViewController ()<WKNavigationDelegate,WKUIDelegate,WKScriptMessageHandler>

@property (strong, nonatomic) WKWebView *webView;


@end

@implementation ThirdViewController

- (void)dealloc
{
    [_webView.configuration.userContentController removeScriptMessageHandlerForName:@"NativeMethod"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    WKWebViewConfiguration *congfig = [[WKWebViewConfiguration alloc] init];
    WKUserContentController *usercontent = [[WKUserContentController alloc] init];
    [usercontent addScriptMessageHandler:self name:@"NativeMethod"];
    congfig.userContentController = usercontent;
    
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:@"POST"];
    //设置参数
    [request setHTTPBody:[@"user=1" dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    _webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) configuration:congfig];
    _webView.scrollView.scrollEnabled = NO;
    _webView.UIDelegate = self;
    _webView.navigationDelegate = self;
    [self.view addSubview:_webView];
    
    NSString *path = [[[NSBundle mainBundle] bundlePath]  stringByAppendingPathComponent:@"JSCallOC.html"];
//    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL fileURLWithPath:path]];
    [self.webView loadRequest:request];
}

#pragma mark - WKScriptMessageHandler
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
