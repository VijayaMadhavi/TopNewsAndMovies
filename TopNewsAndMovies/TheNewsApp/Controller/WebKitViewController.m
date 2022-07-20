//
//  WebKitViewController.m
//  TheNewsApp
//
//  Created by Vijaya Madhavi on 16/07/22.
//

#import "WebKitViewController.h"

@interface WebKitViewController ()

@end

@implementation WebKitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    WKWebViewConfiguration *theConfiguration = [[WKWebViewConfiguration alloc] init];
    self.newsWebKitView = [[WKWebView alloc] initWithFrame:self.view.frame configuration:theConfiguration];
    [self.view addSubview:self.newsWebKitView];
    self.newsWebKitView.navigationDelegate = self;
    
    [self displayPageForUrl];
}

- (void) displayPageForUrl {
    NSURL *nsURL = [NSURL URLWithString:self.webUrl];
    NSURLRequest *nsRequest = [NSURLRequest requestWithURL:nsURL];
    [self.newsWebKitView loadRequest:nsRequest];

}

@end
