//
//  BillCell.h
//  QianDouRepay
//
//  Created by <15>帝云科技 on 2018/4/12.
//  Copyright © 2018年 帝云科技<15>. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BillModel.h"

@interface BillCell : UITableViewCell

@property (nonatomic , strong) UILabel *moneyLabel;
@property (nonatomic , strong) UILabel *timeLabel;
@property (nonatomic , strong) UILabel *typeLabel;
@property (nonatomic , strong) BillSubModel *billmodel;
@property (nonatomic , strong) receiptRecordModel *receiptModel;

@end
