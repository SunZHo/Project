//
//  NoticeDetailVC.h
//  QianDouRepay
//
//  Created by <15>帝云科技 on 2018/4/18.
//  Copyright © 2018年 帝云科技<15>. All rights reserved.
//

#import "BaseViewController.h"

@interface NoticeDetailVC : BaseViewController

@property (nonatomic , copy) NSString *notiID;
/** 是否是公告通知 */
@property (nonatomic , assign) BOOL isNoti;

@end
