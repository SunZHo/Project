//
//  QDWebViewController.m
//  QianDouRepay
//
//  Created by <15>帝云科技 on 2018/5/10.
//  Copyright © 2018年 帝云科技<15>. All rights reserved.
//

#import "QDWebViewController.h"
#import "QuickCollectionVC.h"

@interface QDWebViewController ()<UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webView;
/**
 *  返回按钮
 */
@property (nonatomic ,strong) UIBarButtonItem *customBackBarItem;
/**
 关闭按钮
 */
@property (nonatomic ,strong) UIBarButtonItem *closeButtonItem;
/**
 保存请求链接
 */
@property (nonatomic, strong) NSMutableArray *snapShotsArray;
/**
 进度条相关
 */
@property (nonatomic, strong) UIProgressView *progressView;
@property (nonatomic, strong) NSTimer *progressTimer;
@property (nonatomic, assign) float progressPercent;
@end

@implementation QDWebViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.progressTimer invalidate];
    self.progressTimer = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.webView];
    _progressView = [[UIProgressView alloc]initWithFrame:CGRectMake(0, 64+SafeAreaTopHeight, SCREEN_WIDTH, 4)];
    _progressView.progressTintColor = [UIColor blueColor];
    [self.view addSubview:_progressView];
    [self loadRequest];
    [self updateNavigationItems];
    self.progressTimer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(updateSimulationProgress) userInfo:nil repeats:YES];
}
- (void)updateSimulationProgress{
    if (self.progressPercent < 0.9f) {
        self.progressPercent += 0.05f;
        [self updateProgress:self.progressPercent];
    }else{
        _progressView.alpha = 0;
    }
}
- (void)updateProgress:(float)progress{
    if (progress == 0.0) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        _progressView.progress = 0;
        [UIView animateWithDuration:0.27 animations:^{
            _progressView.alpha = 1.0;
        }];
    }
    if (progress == 1.0) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        [UIView animateWithDuration:0.27 delay:progress - _progressView.progress options:0 animations:^{
            _progressView.alpha = 0.0;
        } completion:nil];
    }
    [_progressView setProgress:progress animated:NO];
}
- (UIBarButtonItem *)customBackBarItem{
    if (!_customBackBarItem) {
        UIButton* backButton = [[UIButton alloc] init];
        [backButton setTitle:@"返回" forState:UIControlStateNormal];
        [backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [backButton.titleLabel setFont:[UIFont systemFontOfSize:17]];
        [backButton setImage:[UIImage imageNamed:@"backIcon"] forState:UIControlStateNormal];
        [backButton sizeToFit];
        [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        _customBackBarItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    }
    return _customBackBarItem;
}
- (UIBarButtonItem *)closeButtonItem{
    if (!_closeButtonItem) {
        _closeButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStylePlain target:self action:@selector(close)];
        _closeButtonItem.tintColor = [UIColor blackColor];
    }
    return _closeButtonItem;
}
- (void)back
{
    if (self.webView.canGoBack) {
        [self.webView goBack];
    }else{
        [self.navigationController popViewControllerAnimated:YES];;
    }
}
- (void)close
{
    if (self.isReceiptPush) {
        for (UIViewController *controller in self.navigationController.viewControllers) {
            if ([controller isKindOfClass:[QuickCollectionVC class]]) {
                QuickCollectionVC *revise =(QuickCollectionVC *)controller;
                [self.navigationController popToViewController:revise animated:YES];
                [[NSNotificationCenter defaultCenter] postNotificationName:ReceiptCompeleteNotiName object:nil];
            }
        }
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

#pragma 设置导航栏按钮
- (void)updateNavigationItems
{
    if (self.webView.canGoBack) {
        UIBarButtonItem *spaceButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        spaceButtonItem.width = -6.5;
        [self.navigationItem setLeftBarButtonItems:@[spaceButtonItem,self.customBackBarItem,self.closeButtonItem] animated:NO];
    }else{
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
        [self.navigationItem setLeftBarButtonItems:@[self.customBackBarItem]];
    }
    NSDictionary * attributes = @{NSForegroundColorAttributeName: UIColorFromRGBx(0x33435c),
                                  NSFontAttributeName : kFont(17)};
    self.navigationController.navigationBar.titleTextAttributes = attributes;
}


#pragma mark --  UIWebviewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    
    NSLog(@"加载完毕...");
    self.progressPercent = 1.0;
    [self updateProgress:_progressPercent];
    _progressView.alpha = 0;
    [self updateNavigationItems];
    NSLog(@"%@",[webView stringByEvaluatingJavaScriptFromString:@"document.location.herf"]);
    NSString *titlestr = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    self.title = titlestr;
    
}
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    _progressPercent = 0;
    [self updateProgress:_progressPercent];
    _progressPercent += 0.1;
    [self updateProgress:_progressPercent];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"ERROR！");
    self.progressPercent = 1.0;
    [self updateProgress:_progressPercent];
    _progressView.alpha = 0;
    self.title = @"哎呀，出错啦";
    [self showErrorText:@"网络错误，请稍后再试"];
    
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    
    NSString *requestURL = request.URL.absoluteString;
    
    NSLog(@"加载前URL：%@",requestURL);

    switch (navigationType) {
        case UIWebViewNavigationTypeLinkClicked: {
            [self pushCurrentSnapshotViewWithRequest:request];
            break;
        }
        case UIWebViewNavigationTypeFormSubmitted: {
            [self pushCurrentSnapshotViewWithRequest:request];
            break;
        }
        case UIWebViewNavigationTypeBackForward: {
            break;
        }
        case UIWebViewNavigationTypeReload: {
            break;
        }
        case UIWebViewNavigationTypeFormResubmitted: {
            break;
        }
        case UIWebViewNavigationTypeOther: {
            [self pushCurrentSnapshotViewWithRequest:request];
            break;
        }
        default: {
            break;
        }
    }
    [self updateNavigationItems];
    return YES;
}
//请求链接处理
- (void)pushCurrentSnapshotViewWithRequest:(NSURLRequest*)request{
    //    NSLog(@"push with request %@",request);
    NSURLRequest* lastRequest = (NSURLRequest*)[[self.snapShotsArray lastObject] objectForKey:@"request"];
    
    //如果url是很奇怪的就不push
    if ([request.URL.absoluteString isEqualToString:@"about:blank"]) {
        return;
    }
    //如果url一样就不进行push
    if ([lastRequest.URL.absoluteString isEqualToString:request.URL.absoluteString]) {
        return;
    }
    UIView* currentSnapShotView = [self.webView snapshotViewAfterScreenUpdates:YES];
    [self.snapShotsArray addObject:
     @{@"request":request,@"snapShotView":currentSnapShotView}];
}

#pragma lazyloading.....
- (UIWebView *)webView
{
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64 + SafeAreaTopHeight, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - SafeAreaTopHeight)];
        _webView.delegate = self;
        _webView.scalesPageToFit = YES;
        
    }
    return _webView;
}

- (void)loadRequest
{
    if (self.loadUrl) {
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:self.loadUrl]];
        [self.webView loadRequest:request];
    }
    if (self.loadHtml) {
        [self.webView loadHTMLString:self.loadHtml baseURL:nil];
    }
    
}

@end
