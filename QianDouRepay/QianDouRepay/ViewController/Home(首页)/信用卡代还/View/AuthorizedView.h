//
//  AuthorizedView.h
//  QianDouRepay
//
//  Created by <15>帝云科技 on 2018/5/17.
//  Copyright © 2018年 帝云科技<15>. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CreditCardModel.h"

@interface AuthorizedView : UIView

- (instancetype)initWithFrame:(CGRect)frame andModel:(CreditCardModel *)creModel;
@property (nonatomic, copy) void (^AuthorizedBlock)(void);

- (void)show;

@end
