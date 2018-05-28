//
//  CYLPlusButtonSubclass.m
//  CYLTabBarControllerDemo
//
//  v1.10.0 Created by 微博@iOS程序犭袁 ( http://weibo.com/luohanchenyilong/ ) on 15/10/24.
//  Copyright (c) 2015年 https://github.com/ChenYilong . All rights reserved.
//

#import "CYLPlusButtonSubclass.h"
#import "CYLTabBarController.h"
#import "ShareViewController.h"
#import "LoginViewController.h"


@interface CYLPlusButtonSubclass ()<UIActionSheetDelegate> {
    
}

@end

@implementation CYLPlusButtonSubclass

#pragma mark -
#pragma mark - Life Cycle

+ (void)load {
    //请在 `-application:didFinishLaunchingWithOptions:` 中进行注册，否则iOS10系统下存在Crash风险。
    //[super registerPlusButton];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.adjustsImageWhenHighlighted = NO;
    }
    return self;
}

//上下结构的 button
- (void)layoutSubviews {
    [super layoutSubviews];
    
    // 控件大小,间距大小
    // 注意：一定要根据项目中的图片去调整下面的0.7和0.9，Demo之所以这么设置，因为demo中的 plusButton 的 icon 不是正方形。
    CGFloat const imageViewEdgeWidth   = self.bounds.size.width * 0.4;
    CGFloat const imageViewEdgeHeight  = imageViewEdgeWidth ;
    
    CGFloat const centerOfView    = self.bounds.size.width * 0.5;
    CGFloat const labelLineHeight = self.titleLabel.font.lineHeight;
    CGFloat const verticalMargin  = (self.bounds.size.height - labelLineHeight - imageViewEdgeHeight) * 0.5;
    
    // imageView 和 titleLabel 中心的 Y 值
    CGFloat const centerOfImageView  = verticalMargin + imageViewEdgeHeight * 0.5;
    //    CGFloat const centerOfTitleLabel = imageViewEdgeHeight  + verticalMargin * 2 + labelLineHeight * 0.5 + 5;
    CGFloat const centerOfTitleLabel = imageViewEdgeHeight  + verticalMargin + labelLineHeight * 0.5 + 5;
    
    //imageView position 位置
    self.imageView.bounds = CGRectMake(0, 0, imageViewEdgeWidth, imageViewEdgeHeight);
    self.imageView.center = CGPointMake(centerOfView, centerOfImageView);
    
    //title position 位置
    self.titleLabel.bounds = CGRectMake(0, 0, self.bounds.size.width, labelLineHeight);
    self.titleLabel.center = CGPointMake(centerOfView, centerOfTitleLabel);
}

#pragma mark -
#pragma mark - CYLPlusButtonSubclassing Methods

/*
 *
 Create a custom UIButton with title and add it to the center of our tab bar
 *
 */
+ (id)plusButton {
    
    CYLPlusButtonSubclass *button = [[CYLPlusButtonSubclass alloc] init];
    UIImage *buttonImage = [UIImage imageNamed:@"mid"];
    [button setImage:buttonImage forState:UIControlStateNormal];
    [button setTitle:@"推广" forState:UIControlStateNormal];
    [button setTitleColor:APPMainColor forState:UIControlStateNormal];
    [button setTitleColor:APPMainColor forState:UIControlStateSelected];
    button.frame = CGRectMake(0.0, 0.0, 60, 60);
    button.titleLabel.font = [UIFont systemFontOfSize:12];
    button.layer.cornerRadius = 30;
    button.layer.borderColor = HEXACOLOR(0xf0f1f2).CGColor;
    button.layer.borderWidth = 0.5;
    button.backgroundColor = WhiteColor;
    // if you use `+plusChildViewController` , do not addTarget to plusButton.
    [button addTarget:button action:@selector(clickPublish) forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}
/*
 *
 Create a custom UIButton without title and add it to the center of our tab bar
 *
 */
//+ (id)plusButton
//{
//
//    UIImage *buttonImage = [UIImage imageNamed:@"hood.png"];
//    UIImage *highlightImage = [UIImage imageNamed:@"hood-selected.png"];
//
//    CYLPlusButtonSubclass* button = [CYLPlusButtonSubclass buttonWithType:UIButtonTypeCustom];
//
//    button.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin;
//    button.frame = CGRectMake(0.0, 0.0, 44, 44);
//    [button setBackgroundImage:buttonImage forState:UIControlStateNormal];
//    [button setBackgroundImage:highlightImage forState:UIControlStateHighlighted];
//    [button addTarget:button action:@selector(clickPublish) forControlEvents:UIControlEventTouchUpInside];
//
//    return button;
//}

#pragma mark -
#pragma mark - Event Response

- (void)clickPublish {
    UIViewController *vc = [AppCommon getCurrentVC];
    if ([LoginStatus integerValue] == 1) {
        ShareViewController *shareVC = [[ShareViewController alloc]init];
        [vc.navigationController pushViewController:shareVC animated:YES];
    }else{
        LoginViewController *loginVc = [[LoginViewController alloc]init];
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:loginVc];
        [vc presentViewController:nav animated:NO completion:nil];
    }
    
    
}


#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
//    DLog(@"buttonIndex = %@", @(buttonIndex));
}

#pragma mark - CYLPlusButtonSubclassing

//+ (UIViewController *)plusChildViewController {
//    UIViewController *plusChildViewController = [[UIViewController alloc] init];
//    plusChildViewController.view.backgroundColor = [UIColor redColor];
//    plusChildViewController.navigationItem.title = @"PlusChildViewController";
//    UIViewController *plusChildNavigationController = [[UINavigationController alloc]
//                                                   initWithRootViewController:plusChildViewController];
//    return plusChildNavigationController;
//}
//
//+ (NSUInteger)indexOfPlusButtonInTabBar {
//    return 4;
//}
//
//+ (BOOL)shouldSelectPlusChildViewController {
//    BOOL isSelected = CYLExternPlusButton.selected;
//    if (isSelected) {
//        DLog(@"🔴类名与方法名：%@（在第%@行），描述：%@", @(__PRETTY_FUNCTION__), @(__LINE__), @"PlusButton is selected");
//    } else {
//        DLog(@"🔴类名与方法名：%@（在第%@行），描述：%@", @(__PRETTY_FUNCTION__), @(__LINE__), @"PlusButton is not selected");
//    }
//    return YES;
//}

+ (CGFloat)multiplierOfTabBarHeight:(CGFloat)tabBarHeight {
    if (CYL_IS_IPHONE_X) {
        return 0.3;
    }
    return  0.37;
}

+ (CGFloat)constantOfPlusButtonCenterYOffsetForTabBarHeight:(CGFloat)tabBarHeight {
    return  0;
}

@end

