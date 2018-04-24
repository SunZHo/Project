//
//  MyFeeRateViewController.m
//  QianDouRepay
//
//  Created by <15>帝云科技 on 2018/4/13.
//  Copyright © 2018年 帝云科技<15>. All rights reserved.
//

#import "MyFeeRateViewController.h"
#import "MyFeeRateSubVC.h"

@interface MyFeeRateViewController ()

@end

@implementation MyFeeRateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的费率";
    self.titleArray = @[@"收款费率",@"还款费率"];
    NSMutableArray *childVCs = [[NSMutableArray alloc]init];
    for (NSString *title in self.titleArray) {
        MyFeeRateSubVC *vc = [[MyFeeRateSubVC alloc]init];
        vc.title = title;
        [childVCs addObject:vc];
    }
    self.subVcArray = childVCs;
    
    [super addchildViewControllers];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
