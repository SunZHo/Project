//
//  PayWayCell.h
//  QianDouRepay
//
//  Created by <15>帝云科技 on 2018/4/25.
//  Copyright © 2018年 帝云科技<15>. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PayWayModel.h"

@interface PayWayCell : UITableViewCell

@property (nonatomic , strong) UILabel *nameLabel;
@property (nonatomic , strong) UIImageView *iconImg;
@property (nonatomic , strong) UIImageView *selectImg;


@property (nonatomic , strong) PayWayModel *payModel;
@end
