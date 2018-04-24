//
//  DivideRecordViewController.m
//  QianDouRepay
//
//  Created by <15>帝云科技 on 2018/4/13.
//  Copyright © 2018年 帝云科技<15>. All rights reserved.
//

#import "DivideRecordViewController.h"
#import "DivideRecordSubVC.h"

@interface DivideRecordViewController ()

@end

@implementation DivideRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"分润记录";
    self.titleArray = @[@"收款分润",@"还款分润"];
    NSMutableArray *childVCs = [[NSMutableArray alloc]init];
    for (NSString *title in self.titleArray) {
        DivideRecordSubVC *vc = [[DivideRecordSubVC alloc]init];
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
