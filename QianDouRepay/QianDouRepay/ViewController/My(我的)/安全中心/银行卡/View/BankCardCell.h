//
//  BankCardCell.h
//  QianDouRepay
//
//  Created by <15>帝云科技 on 2018/4/16.
//  Copyright © 2018年 帝云科技<15>. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BankCardModel.h"

@interface BankCardCell : UITableViewCell

@property (nonatomic , strong) UIImageView *backImg;
@property (nonatomic , strong) UILabel *bankNameLabel;
@property (nonatomic , strong) UILabel *cardNumLabel;
@property (nonatomic , strong) UILabel *nameLabel;

@property (nonatomic , strong) BankCardModel *bankModel;

@end
