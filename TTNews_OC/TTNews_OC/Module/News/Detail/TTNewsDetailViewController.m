//
//  TTNewsDetailViewController.m
//  TTNews_OC
//
//  Created by QDSG on 2021/3/25.
//

#import "TTNewsDetailViewController.h"
#import <WebKit/WebKit.h>

@interface TTNewsDetailViewController () <WKNavigationDelegate>

@property (nonatomic, strong) WKWebView *webView;

@property (nonatomic, strong) UIProgressView *progressView;

@property (nonatomic, copy) NSString *articleUrl;

@end

@implementation TTNewsDetailViewController

#pragma mark - life cycle

- (instancetype)initWithUrlString:(NSString *)urlString {
    self = [super init];
    if (self) {
        self.articleUrl = urlString;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self makeUI];
    [self loadRequest];
    
    [self KVO];
}

- (void)makeUI {
    [self.view addSubview:self.webView];
    [self.view addSubview:self.progressView];
    [self.view bringSubviewToFront:self.progressView];
}

- (void)loadRequest {
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.articleUrl]];
    
    [self.webView loadRequest:request];
}

#pragma mark - KVO

/// 添加监听
- (void)KVO {
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
}

/// 监听方法
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    [self.progressView setProgress:self.webView.estimatedProgress animated:YES];
    NSLog(@"");
}

/// 移除监听
- (void)dealloc {
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
}

#pragma mark - WKNavigationDelegate

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    decisionHandler(WKNavigationActionPolicyAllow);
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    self.progressView.progress = 0.0;
    NSLog(@"");
    // Webview加载完成
    // 此时并不代表整个Web页面已经渲染结束
}

#pragma mark - getter

- (WKWebView *)webView {
    if (!_webView) {
        _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 88, self.view.frame.size.width, self.view.frame.size.height - 88)];
        _webView.navigationDelegate = self;
    }
    return _webView;
}

- (UIProgressView *)progressView {
    if (!_progressView) {
        _progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 88, self.view.frame.size.width, 10)];
        _progressView.progressTintColor = [UIColor blueColor];
    }
    return _progressView;
}

@end
