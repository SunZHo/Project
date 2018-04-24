//
//  RepayFeeCell.h
//  QianDouRepay
//
//  Created by <15>帝云科技 on 2018/4/13.
//  Copyright © 2018年 帝云科技<15>. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyFeeRateModel.h"

@interface RepayFeeCell : UITableViewCell

@property (nonatomic , strong) UIImageView *iconImg;
@property (nonatomic , strong) UILabel *nameLabel;
@property (nonatomic , strong) UILabel *D0Label;
@property (nonatomic , strong) UIView *lineV_1;
@property (nonatomic , strong) UIView *lineV_10;

@property (nonatomic , strong) MyFeeRateModel *myFeeModel;

@end
