//
//  PromotionCell.h
//  QianDouRepay
//
//  Created by <15>帝云科技 on 2018/4/17.
//  Copyright © 2018年 帝云科技<15>. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PromotionModel.h"

@interface PromotionCell : UITableViewCell

@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) UILabel *phoneLabel;
@property (strong, nonatomic) UILabel *vipTypeLabel;
@property (strong, nonatomic) UILabel *timeLabel;
@property (nonatomic , strong) PromotionModel *promotionModel;

@end
