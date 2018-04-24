//
//  FilterCell.h
//  QianDouRepay
//
//  Created by <15>帝云科技 on 2018/4/17.
//  Copyright © 2018年 帝云科技<15>. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FilterModel.h"

@interface FilterCell : UICollectionViewCell

@property (nonatomic , strong) UILabel *label;

@property (nonatomic , strong) FilterModel *filterModel;

@end
