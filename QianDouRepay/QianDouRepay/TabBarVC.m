//
//  TabBarVC.m
//  QianDouRepay
//
//  Created by <15>帝云科技 on 2018/4/24.
//  Copyright © 2018年 帝云科技<15>. All rights reserved.
//

#import "TabBarVC.h"
#import "AddCreditCardViewController.h"
#import "DivideRecordViewController.h"
#import "CYLPlusButtonSubclass.h"

@interface TabBarVC ()

@end

@implementation TabBarVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    self.navigationController.navigationBar.hidden= YES;
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
//    self.navigationController.navigationBar.hidden= NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];

    [self initTabBar];
    
    
    self.navigationItem.leftBarButtonItem =({
        [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"sz"]
                                        style:UIBarButtonItemStylePlain
                                       target:self
                                       action:@selector(leftBarButtonItemClicked)];
    });
    
    
    

}

- (void)leftBarButtonItemClicked{
//    [CYLPlusButtonSubclass registerPlusButton];
//    CYLTabBarControllerConfig *tabBarControllerConfig = [[CYLTabBarControllerConfig alloc] init];
////    tabBarControllerConfig.tabBarController.delegate = self;
//    CYLTabBarController *tabBarController = tabBarControllerConfig.tabBarController;
//    [UIApplication sharedApplication].delegate.window.rootViewController = tabBarController;
//    [[UIApplication sharedApplication].delegate.window makeKeyAndVisible];
    [self dismissViewControllerAnimated:YES completion:nil];
}


/*
 初始化Tabbar
 */
- (void)initTabBar{
    
    AddCreditCardViewController *h1 = [[AddCreditCardViewController alloc] init];
    DivideRecordViewController *h2 = [[DivideRecordViewController alloc] init];
   
    
    
    NSArray *rootArray = [NSArray arrayWithObjects:h1,h2, nil];
    
    NSArray *nameArray = [NSArray arrayWithObjects:@"首页",@"签到", nil];
    
    h1.title = nameArray[0];
    h2.title = nameArray[1];
    
    NSMutableArray *vcArray = [NSMutableArray array];
    
    
    for (int index = 0; index < rootArray.count; index++) {
        
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:rootArray[index]];
        //tabBar未选中的image
        UIImage *normalImg = [[UIImage imageNamed:[NSString stringWithFormat:@"tabBar%d_no.png",index + 1]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        //tabBar已选中的image
        UIImage *selectImg = [[UIImage imageNamed:[NSString stringWithFormat:@"tabBar%d_yes.png",index+1]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        //设置tabBar显示的文字
        nav.tabBarItem = [[UITabBarItem alloc] initWithTitle:nameArray[index] image:normalImg selectedImage:selectImg];
        
        nav.tabBarItem.tag = index +1;
        nav.tabBarItem.title = nameArray[index];
        [vcArray addObject:nav];
        
    }
    
    //tabbar未选中时文字的颜色，字体大小
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor lightGrayColor],NSForegroundColorAttributeName,[UIFont systemFontOfSize:14.0],NSFontAttributeName, nil] forState:UIControlStateNormal];
    
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:APPMainColor,NSForegroundColorAttributeName,[UIFont systemFontOfSize:12.0],NSFontAttributeName, nil] forState:UIControlStateSelected];
    
    self.viewControllers = vcArray;
    
    self.view.backgroundColor = [UIColor whiteColor];
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
