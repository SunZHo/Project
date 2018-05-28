//
//  FormCell.h
//  QianDouRepay
//
//  Created by <15>帝云科技 on 2018/4/9.
//  Copyright © 2018年 帝云科技<15>. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FormCellModel.h"


@interface FormCell : UITableViewCell

/** textField回传值 */ 
@property (nonatomic, copy) void (^cellTextFieldBlock)(NSString *text);

@property (nonatomic , strong) FormCellModel *formcellModel;

/** 获取验证码 */
@property (nonatomic, copy) void (^getVerifyCodeBlock)(void);

@end
