//
//  RepayPlanListCell.h
//  QianDouRepay
//
//  Created by <15>帝云科技 on 2018/4/12.
//  Copyright © 2018年 帝云科技<15>. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RepayPlanListModel.h"

@interface RepayPlanListCell : UITableViewCell

@property (nonatomic , strong) UILabel *timeLabel;
@property (nonatomic , strong) UILabel *planMoneyLabel;
@property (nonatomic , strong) UILabel *totalMoneyLabel;
@property (nonatomic , strong) UILabel *firstMoneyLabel;
@property (nonatomic , strong) UILabel *secondMoneyLabel;
@property (nonatomic , strong) UILabel *feeLabel;
@property (nonatomic , strong) RepayPlanListModel *planModel;

@end
