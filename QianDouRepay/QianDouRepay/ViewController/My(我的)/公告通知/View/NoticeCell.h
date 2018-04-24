//
//  NoticeCell.h
//  QianDouRepay
//
//  Created by <15>帝云科技 on 2018/4/18.
//  Copyright © 2018年 帝云科技<15>. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NoticeModel.h"

@interface NoticeCell : UITableViewCell

@property (nonatomic , strong) UILabel *titleLabel;
@property (nonatomic , strong) UILabel *timeLabel;
@property (nonatomic , strong) NoticeModel *noticeModel;

@end
