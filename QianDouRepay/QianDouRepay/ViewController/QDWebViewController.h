//
//  QDWebViewController.h
//  QianDouRepay
//
//  Created by <15>帝云科技 on 2018/5/10.
//  Copyright © 2018年 帝云科技<15>. All rights reserved.
//

#import "BaseViewController.h"

@interface QDWebViewController : BaseViewController

/** 加载URL */
@property (nonatomic , copy) NSString *loadUrl;

/** 加载html */
@property (nonatomic , copy) NSString *loadHtml;

/** 是否是收款页面过来的 */
@property (nonatomic , assign) BOOL isReceiptPush ;



@end
