//
//  BaseTableView.m
//  QianDouRepay
//
//  Created by <15>帝云科技 on 2018/4/9.
//  Copyright © 2018年 帝云科技<15>. All rights reserved.
//

#import "BaseTableView.h"

@implementation BaseTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.tableFooterView = [UIView new];
        self.backgroundColor = Default_BackgroundGray;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.estimatedSectionHeaderHeight = 0;
        self.estimatedSectionFooterHeight = 0;
        self.estimatedRowHeight = 0;
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
    }
    return self;
}


- (void)endRefresh{
    [self.mj_header endRefreshing];
    [self.mj_footer endRefreshing];
}


@end
