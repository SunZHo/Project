//
//  InviteRecordCell.h
//  QianDouRepay
//
//  Created by <15>帝云科技 on 2018/4/13.
//  Copyright © 2018年 帝云科技<15>. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InviteRecordModel.h"

@interface InviteRecordCell : UITableViewCell

@property (nonatomic , strong) UILabel *phoneLabel;
@property (nonatomic , strong) UILabel *timeLabel;
@property (nonatomic , strong) UILabel *stateLabel;

@property (nonatomic , strong) InviteRecordModel *inviteModel;

@end
