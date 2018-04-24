//
//  AppGuideView.m
//  QianDouRepay
//
//  Created by <15>帝云科技 on 2018/4/10.
//  Copyright © 2018年 帝云科技<15>. All rights reserved.
//

#import "AppGuideView.h"

@interface AppGuideView()<UIScrollViewDelegate>
{
    UIPageControl *pageControl;
}

@end

@implementation AppGuideView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor =[UIColor yellowColor];
        NSArray *imageArr = @[@"ydy1",@"ydy2",@"ydy3"];
        UIScrollView* scrollView = [[UIScrollView alloc] initWithFrame:frame];
        scrollView.backgroundColor = [UIColor whiteColor];
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.delegate = self;
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.contentSize = CGSizeMake(frame.size.width*imageArr.count, frame.size.height);
        scrollView.pagingEnabled = YES;
        
        for (int i=0; i<imageArr.count; i++) {
            UIImageView* imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i*frame.size.width, 0, frame.size.width, frame.size.height)];
            imageView.contentMode = UIViewContentModeScaleAspectFill;
            imageView.userInteractionEnabled = YES;
            imageView.image = [UIImage imageNamed:imageArr[i]];
            if (i == imageArr.count - 1) {
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismiss)];
                [imageView addGestureRecognizer:tap];
            }
            [scrollView addSubview:imageView];
        }
        
        
        [self addSubview:scrollView];
        //        pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, frame.size.height - 60 , frame.size.width, 30)];
        //        pageControl.numberOfPages  = 4;
        //        pageControl.pageIndicatorTintColor = [UIColor blueColor];
        //        pageControl.currentPageIndicatorTintColor = [UIColor yellowColor];
        //        [self addSubview:pageControl];
        
        
    }
    return self;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    int itemIndex = (scrollView.contentOffset.x + self.frame.size.width * 0.5) / self.frame.size.width;
    int indexOnPageControl = itemIndex % 4;
    pageControl.currentPage = indexOnPageControl;
//    DDLogVerbose(@"%.2f,,%d..%d",scrollView.contentOffset.x,itemIndex,indexOnPageControl);
    
}

-(void)show{
    UIViewController *vc = [[UIViewController alloc]init];
    vc.view.hidden = YES;
    // UIWindow 要有个rootViewController 才行，这里创建一个隐藏的UIViewController
    self.rootViewController = vc;
    // 让UIWindow 级别处于最高
    self.windowLevel = UIWindowLevelAlert + 1;
    // 让UIWindow 显示
    self.hidden = NO;
}
-(void)dismiss{
    [[NSUserDefaults standardUserDefaults] setObject:@"APP_Version" forKey:[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]];
    self.rootViewController = nil;
    self.hidden = YES;
}

@end
