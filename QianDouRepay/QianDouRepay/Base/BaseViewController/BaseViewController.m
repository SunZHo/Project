//
//  BaseViewController.m
//  QianDouRepay
//
//  Created by <15>帝云科技 on 2018/4/9.
//  Copyright © 2018年 帝云科技<15>. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = HEXACOLOR(0xf0f1f2);
    self.navlineV = [[UIView alloc]initWithFrame:CGRectMake(0, 64 + SafeAreaTopHeight, SCREEN_WIDTH, 0.5)];
    self.navlineV.backgroundColor = HEXACOLOR(0xf1f2f3);
    [self.view addSubview:self.navlineV];
    self.navlineV.layer.zPosition = 10;
}

- (void)setNavAlphaZero{
    self.navlineV.alpha = 0;
    [self wr_setStatusBarStyle:UIStatusBarStyleLightContent];
    [self wr_setNavBarBackgroundAlpha:0];
    [self wr_setNavBarShadowImageHidden:YES];
    [self wr_setNavBarTintColor:WhiteColor];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
