//
//  AgreementViewController.m
//  QianDouRepay
//
//  Created by <15>帝云科技 on 2018/5/3.
//  Copyright © 2018年 帝云科技<15>. All rights reserved.
//

#import "AgreementViewController.h"

@interface AgreementViewController ()

@property (nonatomic , strong) UIWebView *myweb;

@end

@implementation AgreementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.myweb];
    
    [AppNetworking requestWithType:HttpRequestTypeGet withUrlString:regAgreement withParaments:nil withSuccessBlock:^(id json) {
        NSDictionary *infoDic = [json objectForKey:@"info"];
        [self.myweb loadHTMLString:[infoDic objectForKey:@"content"] baseURL:nil];
        
    } withFailureBlock:^(NSString *errorMessage, int code) {
        
    }];
    
}

- (UIWebView *)myweb{
    if (!_myweb) {
        _myweb = [[UIWebView alloc]initWithFrame:self.view.bounds];
    }
    return _myweb;
}

@end
