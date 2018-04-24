//
//  Define.h
//  QianDouRepay
//
//  Created by <15>帝云科技 on 2018/4/9.
//  Copyright © 2018年 帝云科技<15>. All rights reserved.
//

#ifndef Define_h
#define Define_h

#if DEBUG

#define NSLog(format, ...) do {                                             \
fprintf(stderr, "<%s : %d行> %s\n",                                           \
[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String],  \
__LINE__, __func__);                                                        \
(NSLog)((format), ##__VA_ARGS__);                                           \
fprintf(stderr, "-------\n");                                               \
} while (0)
#define NSLogRect(rect) NSLog(@"%s x:%.4f, y:%.4f, w:%.4f, h:%.4f", #rect, rect.origin.x, rect.origin.y, rect.size.width, rect.size.height)
#define NSLogSize(size) NSLog(@"%s w:%.4f, h:%.4f", #size, size.width, size.height)
#define NSLogPoint(point) NSLog(@"%s x:%.4f, y:%.4f", #point, point.x, point.y)
#else
#define NSLog(FORMAT, ...) nil
#define NSLogRect(rect) nil
#define NSLogSize(size) nil
#define NSLogPoint(point) nil

#endif

/// others
#define DefineWeakSelf __weak __typeof(self) weakSelf = self;
#define UIImageWithName(a) [[UIImage imageNamed:a] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
#define IMAGESTRING(_STRING) [UIImage imageNamed:_STRING]
#define IMAGECONTENT(_STRING) \
[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:_STRING ofType:nil]]


/// UIColor快捷创建
#define Default_BackgroundGray UIColorFromRGBx(0xf8f7f7)

#define UIColorFromRGB(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define UIColorFromRGBa(r, g, b, a)   [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
#define UIColorFromRGBx(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define HEXACOLOR_a(rgbValue,a)     [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:(a)]\

#define HEXACOLOR(rgbValue)     [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define randomColor [UIColor colorWithRed:(arc4random() % 255)/255.0 green:(arc4random() % 255)/255.0 blue:(arc4random() % 255)/255.0 alpha:1]
#define WhiteColor HEXACOLOR(0xffffff)
#define defaultTextColor HEXACOLOR(0x333333)
#define APPMainColor HEXACOLOR(0xfccb36)

//字体
#define kFont(_SIZE) [UIFont systemFontOfSize:_SIZE]
#define kBoldFont(_SIZE) [UIFont boldSystemFontOfSize:_SIZE]

/// 屏幕尺寸
//#define Iphone6ScalingFloat           MIN(SCREEN_WIDTH, SCREEN_HEIGHT)  / 750
#define kAUTOLAYOUTSCALE_X            (SCREEN_WIDTH / 375.0)
#define kAUTOLAYOUTSCALE_Y            (SCREEN_HEIGHT / 667.0)
#define SCREEN_WIDTH                  [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT                 [UIScreen mainScreen].bounds.size.height

#define kScaleWidth(value) ((value)/375.0f * SCREEN_WIDTH)
#define kScaleHeight(value) ((value)/667.0f * SCREEN_HEIGHT)

/// 机型判断
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_IPHONE_5_OR_LESS (IS_IPHONE && MAX(SCREEN_WIDTH, SCREEN_HEIGHT) <= 568.0)
#define IS_IPHONE_5 (fabs((double)[[UIScreen mainScreen] bounds].size.height - (double )568) < DBL_EPSILON )
#define IS_IPHONE_6 (fabs((double)[[UIScreen mainScreen] bounds].size.height - (double )667) < DBL_EPSILON )
#define IS_IPHONE_X (fabs((double)[[UIScreen mainScreen] bounds].size.height - (double )812) < DBL_EPSILON )
#define IS_IPHONE_6_PLUS (fabs((double)[[UIScreen mainScreen] bounds].size.height - (double )736) < DBL_EPSILON )
/// 系统判断
#define IS_IOS7     ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
#define IS_IOS8     ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
#define IS_IOS9     ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0)
#define IS_IOS10    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0)
#define IS_IOS11    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 11.0)

//数据过滤
//字符串过滤
#define kValidString(_str)  ([NSObject isValidString:_str] ? _str : @" ")

//app版本号
#define BundleVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
//手机系统版本
#define PhoneVersion  [[UIDevice currentDevice] systemVersion]

/// 图片
#define IMG(a) [UIImage imageNamed:a]
//bundle IMG
#define LOADIMAGE(file) [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle] pathForResource:@"ZDImages" ofType :@"bundle"] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.gif",file]]]

//数据库沙盒指向
#define PATH_OF_DB [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]
#define DB_PATH [PATH_OF_DB stringByAppendingPathComponent:@"account.db"]

#define UserDefaults [NSUserDefaults standardUserDefaults]

#define SafeAreaBottomHeight (IS_IPHONE_X ? 34 : 0)
#define SafeAreaTopHeight (IS_IPHONE_X ? 24 : 0)

//push 控制器
#define PUSHVC(vc) [self.navigationController pushViewController:vc animated:YES]

// pop 控制器
#define POPVC [self.navigationController popViewControllerAnimated:YES];

#endif /* Define_h */
