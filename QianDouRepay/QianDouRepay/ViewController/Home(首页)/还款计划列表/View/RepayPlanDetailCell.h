//
//  RepayPlanDetailCell.h
//  QianDouRepay
//
//  Created by <15>帝云科技 on 2018/4/20.
//  Copyright © 2018年 帝云科技<15>. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RepayPlanDetailModel.h"

@interface RepayPlanDetailCell : UITableViewCell

@property (nonatomic , strong) UIButton *titleBtn;
@property (nonatomic , strong) UIImageView *rowImg;
@property (nonatomic , strong) UIView *lineV_1;
@property (nonatomic , strong) UIView *lineV_10;
@property (nonatomic, copy) void (^openClickedBlock)(void);
@property (nonatomic , strong) RepayPlanDetailModel *repayPlanModel;

@end
