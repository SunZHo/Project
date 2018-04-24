//
//  SettingCell.h
//  QianDouRepay
//
//  Created by <15>帝云科技 on 2018/4/10.
//  Copyright © 2018年 帝云科技<15>. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,SetCellType) {
    /** 正常 */
    cellTypeNormal = 0,
    /** 有右箭头 */
    cellTypeHasRightRow = 1,
};

@interface SettingCell : UITableViewCell

@property (nonatomic , strong) UILabel *rightLabel;
@property (nonatomic , assign) SetCellType cellType ;

@end
