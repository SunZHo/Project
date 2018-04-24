//
//  MessageCell.h
//  QianDouRepay
//
//  Created by <15>帝云科技 on 2018/4/19.
//  Copyright © 2018年 帝云科技<15>. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageModel.h"

@interface MessageCell : UITableViewCell

@property (nonatomic , strong) UIView *noteImg;
@property (nonatomic , strong) UILabel *titleLabel;
@property (nonatomic , strong) UILabel *timeLabel;
@property (nonatomic , strong) UILabel *contentLabel;
@property (nonatomic , strong) MessageModel *messageModel;

@end
