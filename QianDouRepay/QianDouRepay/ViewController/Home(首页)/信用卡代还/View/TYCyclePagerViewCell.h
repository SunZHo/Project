//
//  TYCyclePagerViewCell.h
//  TYCyclePagerViewDemo
//
//  Created by tany on 2017/6/14.
//  Copyright © 2017年 tany. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CreditCardModel.h"

@interface TYCyclePagerViewCell : UICollectionViewCell

@property (nonatomic , strong) UIImageView *backImg;
@property (nonatomic , strong) UILabel *bankLabel;
@property (nonatomic , strong) UILabel *cardNumLabel;
@property (nonatomic , strong) UILabel *timeLabel;
@property (nonatomic , strong) UILabel *nameLabel;
@property (nonatomic , strong) CreditCardModel *cardModel;

@end
