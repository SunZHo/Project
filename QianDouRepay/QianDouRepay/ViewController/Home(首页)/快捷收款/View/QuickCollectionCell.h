//
//  QuickCollectionCell.h
//  QianDouRepay
//
//  Created by <15>帝云科技 on 2018/4/13.
//  Copyright © 2018年 帝云科技<15>. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuickCollectionModel.h"

@interface QuickCollectionCell : UITableViewCell

@property (nonatomic , strong) UIView *lineV_10pt;
@property (nonatomic , strong) UIImageView *iconImg;
@property (nonatomic , strong) UILabel *pathLabel;
@property (nonatomic , strong) UIView *lineVTop_1pt;
@property (nonatomic , strong) UILabel *rateLabel;
@property (nonatomic , strong) UILabel *timeLabel;
@property (nonatomic , strong) UILabel *limitLabel;
@property (nonatomic , strong) UILabel *typeLabel;
@property (nonatomic , strong) UIView *lineVBottom_1pt;
@property (nonatomic , strong) UILabel *moneyLabel;
@property (nonatomic , strong) UIButton *payButtton;

@property (nonatomic , strong) QuickCollectionModel *quickModel;

@end
