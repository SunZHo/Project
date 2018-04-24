//
//  AppPageViewController.m
//  QianDouRepay
//
//  Created by <15>帝云科技 on 2018/4/13.
//  Copyright © 2018年 帝云科技<15>. All rights reserved.
//

#import "AppPageViewController.h"

@interface AppPageViewController ()<FSPageContentViewDelegate,FSSegmentTitleViewDelegate>

@property (nonatomic, strong) FSPageContentView *pageContentView;
@property (nonatomic, strong) FSSegmentTitleView *titleView;

@end

@implementation AppPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}


- (void)addchildViewControllers{
    CGFloat topspace = 64 + SafeAreaTopHeight;
    self.titleView = [[FSSegmentTitleView alloc]initWithFrame:CGRectMake(0, topspace, SCREEN_WIDTH, 40) titles:self.titleArray delegate:self indicatorType:FSIndicatorTypeCustom];
    self.titleView.backgroundColor = WhiteColor;
    self.titleView.indicatorExtension = 6;
    self.titleView.indicatorColor = APPMainColor;
    self.titleView.titleSelectColor = APPMainColor;
    [self.view addSubview:_titleView];
    
    UIView *linev = [[UIView alloc]initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, 10)];
    linev.backgroundColor = Default_BackgroundGray;
    [self.view addSubview:linev];
    
    self.pageContentView = [[FSPageContentView alloc]initWithFrame:CGRectMake(0, topspace + 50, SCREEN_WIDTH, SCREEN_HEIGHT - topspace - 50) childVCs:self.subVcArray parentVC:self delegate:self];
    //    self.pageContentView.contentViewCanScroll = NO;//设置滑动属性
    [self.view addSubview:_pageContentView];
}

#pragma mark --
- (void)FSSegmentTitleView:(FSSegmentTitleView *)titleView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex
{
    self.pageContentView.contentViewCurrentIndex = endIndex;
    
}

- (void)FSContenViewDidEndDecelerating:(FSPageContentView *)contentView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex
{
    self.titleView.selectIndex = endIndex;
    
}

@end
