//
//  BankCardViewController.m
//  QianDouRepay
//
//  Created by <15>帝云科技 on 2018/4/16.
//  Copyright © 2018年 帝云科技<15>. All rights reserved.
//

#import "BankCardViewController.h"

// view
#import "BankCardCell.h"

// model
#import "BankCardModel.h"

// VC
#import "AddBankCardVC.h"

@interface BankCardViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic , strong) BaseTableView *table;

@property (nonatomic , strong) NSMutableArray *listData;

@property (nonatomic , strong) UIView *tableFootView;

@end

@implementation BankCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"银行卡";
    for (int i = 0; i < 1; i++) {
        BankCardModel *model = [[BankCardModel alloc]init];
        model.bankName = @"中国建设银行";
        model.name = @"刘晓晓";
        model.bankCardNum = @"6240  ****  ****  ****  123";
        [self.listData addObject:model];
    }
    [self.view addSubview:self.table];
    
    if (self.listData.count > 0) {
        self.table.tableFooterView = self.tableFootView;
    }
}


- (void)addBankCard{
    AddBankCardVC *vc = [[AddBankCardVC alloc]init];
    PUSHVC(vc);
}


- (void)changeCardClick{
    
}


#pragma mark - table
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.listData.count > 0) {
        return self.listData.count;
    }else{
        return 1;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.listData.count > 0) {
        return 210;
    }else{
        return 240;
    }
    
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.listData.count > 0) {
        static NSString *identifier = @"BankCardCell";
        BankCardModel *model = [self.listData objectAtIndex:indexPath.row];
        BankCardCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[BankCardCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        [cell setBankModel:model];
        
        return cell;
        
    }else{
        static NSString *identifiyImg = @"NoreplyCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifiyImg];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifiyImg];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.separatorInset = UIEdgeInsetsMake(0, SCREEN_WIDTH, 0, 0);
        }
        UIImageView *img = [[UIImageView alloc]init];
        img.image = [UIImage imageNamed:@"tjk"];
        [cell.contentView addSubview:img];
        img.sd_layout.topSpaceToView(cell.contentView, 35).widthIs(87).heightIs(87).centerXEqualToView(cell.contentView);
        
        UILabel *textLabel = [[UILabel alloc]init];
        textLabel.font = kFont(15);
        textLabel.textColor = defaultTextColor;
        textLabel.textAlignment = NSTextAlignmentCenter;
        textLabel.text = @"立即绑定银行卡";
        [cell.contentView addSubview:textLabel];
        textLabel.sd_layout.topSpaceToView(img, 30).widthIs(200).heightIs(16).centerXEqualToView(cell.contentView);
        
        UIButton *button = [AppUIKit createBtnWithType:UIButtonTypeCustom backgroundColor:nil action:@selector(addBankCard) target:self title:@"+添加银行卡" image:nil font:14 textColor:HEXACOLOR(0xe60012)];
        button.layer.cornerRadius = 5;
        button.layer.borderColor = HEXACOLOR(0xe60012).CGColor;
        button.layer.borderWidth = 0.5;
        [cell.contentView addSubview:button];
        button.sd_layout.topSpaceToView(textLabel, 25).widthIs(190).heightIs(40).centerXEqualToView(cell.contentView);
        
        return cell;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.listData.count > 0) {
        
    }
    
}



#pragma mark - LazyLoad

- (BaseTableView *)table{
    if (!_table) {
        _table = [[BaseTableView alloc]initWithFrame:CGRectMake(0, 64 + SafeAreaTopHeight, SCREEN_WIDTH, SCREEN_HEIGHT - (64 + SafeAreaTopHeight))];
        _table.dataSource = self;
        _table.delegate = self;
        _table.backgroundColor = WhiteColor;
    }
    return _table;
}

-(NSMutableArray *)listData{
    if (!_listData) {
        _listData = [[NSMutableArray alloc]init];
    }
    return _listData;
}

- (UIView *)tableFootView{
    if (!_tableFootView) {
        _tableFootView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 60)];
        _tableFootView.backgroundColor = WhiteColor;
        UIButton *sure = [AppUIKit createBtnWithType:UIButtonTypeCustom backgroundColor:WhiteColor action:@selector(changeCardClick) target:self title:@"更换" image:nil font:12 textColor:HEXACOLOR(0xe60012)];
        sure.layer.cornerRadius = 15;
        sure.layer.borderColor = HEXACOLOR(0xe60012).CGColor;
        sure.layer.borderWidth = 0.5;
        
        [_tableFootView addSubview:sure];
        
        sure.sd_layout.centerXEqualToView(_tableFootView).heightIs(30).bottomEqualToView(_tableFootView).widthIs(80);
        
    }
    return _tableFootView;
}


@end
