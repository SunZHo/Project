//
//  ChooseCreditCardCell.h
//  QianDouRepay
//
//  Created by <15>帝云科技 on 2018/4/13.
//  Copyright © 2018年 帝云科技<15>. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChooseCreditCardModel.h"

@interface ChooseCreditCardCell : UITableViewCell

@property (nonatomic , strong) UIImageView *backImg;
@property (nonatomic , strong) UILabel *nameLabel;
@property (nonatomic , strong) UILabel *cardNumLabel;
@property (nonatomic , strong) UIButton *unBindBtn;

@property (nonatomic, copy) void (^unBindBlock)(void);

@property (nonatomic , strong) ChooseCreditCardModel *chooseModel;

@end
