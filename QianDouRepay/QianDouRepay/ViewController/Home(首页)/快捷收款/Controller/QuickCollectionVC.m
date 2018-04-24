//
//  QuickCollectionVC.m
//  QianDouRepay
//
//  Created by <15>帝云科技 on 2018/4/13.
//  Copyright © 2018年 帝云科技<15>. All rights reserved.
//

#import "QuickCollectionVC.h"

// model
#import "QuickCollectionModel.h"

// view
#import "QuickCollectionCell.h"

// controller
#import "CollectRecordVC.h"

@interface QuickCollectionVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic , strong) BaseTableView *table;

@property (nonatomic , strong) NSMutableArray *listData;

@property (nonatomic , strong) UITextField *tradeMoneyTF;

@property (nonatomic , strong) UIView *tableheadView;
@property (nonatomic , strong) UIView *tableheadViewEmpty;

@property (nonatomic , strong) UIView *backview;

@end

@implementation QuickCollectionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"快捷收款";
    [super setNavAlphaZero];
    [self wr_setNavBarTitleColor:WhiteColor];

    
    for (int i = 0; i < 5; i++) {
        QuickCollectionModel *model = [[QuickCollectionModel alloc]init];
        model.pathName = @"交通银行";
        model.rate = @"费率：0.530%+2.00元/笔";
        model.time = @"交易时间：08:00-22:00";
        model.limitMoney = @"额度：单笔限制最低消费500元";
        model.type = @"结算：立即到账";
        CGFloat money = [self.tradeMoneyTF.text floatValue] * (0.0053 + 2);
        model.money = [NSString stringWithFormat:@"%.2f",money];
        
        [self.listData addObject:model];
    }
    _backview = [[UIView alloc]init];
    _backview.backgroundColor = HEXACOLOR(0x36b4fc);
    [self.view addSubview:_backview];
    _backview.sd_layout.topSpaceToView(self.view,0)
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .heightIs(100);
    [self.view addSubview:self.table];
    
    [self setNavRightBarItem];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFildDidChanged) name:UITextFieldTextDidChangeNotification object:nil];
}




- (void)setNavRightBarItem{
    UIButton *billCardBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [billCardBtn addTarget:self action:@selector(collectRecord) forControlEvents:UIControlEventTouchUpInside];
    [billCardBtn setTitle:@"收款记录" forState:UIControlStateNormal];
    billCardBtn.titleLabel.font = kFont(15);
    [billCardBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
    [billCardBtn sizeToFit];
    UIBarButtonItem *billItem = [[UIBarButtonItem alloc] initWithCustomView:billCardBtn];
    self.navigationItem.rightBarButtonItems  = @[billItem];
}

- (void)collectRecord{
    CollectRecordVC *collectVC = [[CollectRecordVC alloc]init];
    PUSHVC(collectVC);
}

#pragma mark - textfieldChange_Noti
- (void)textFildDidChanged{
    for (QuickCollectionModel *model in self.listData) {
        CGFloat money = [self.tradeMoneyTF.text floatValue] * (0.0053 + 2);
        model.money = [NSString stringWithFormat:@"%.2f",money];
    }
    [self.table reloadData];
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
        return 246;
    }else{
        return 180;
    }
    
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.listData.count > 0) {
        static NSString *identifier = @"QuickCollectionCell";
        QuickCollectionModel *model = [self.listData objectAtIndex:indexPath.row];
        QuickCollectionCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[QuickCollectionCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        [cell setQuickModel:model];
        
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
        img.image = [UIImage imageNamed:@"zwsj"];
        [cell.contentView addSubview:img];
        img.sd_layout.topSpaceToView(cell.contentView, 35).widthIs(103).heightIs(103).centerXEqualToView(cell.contentView);
        
        UILabel *textLabel = [[UILabel alloc]init];
        textLabel.font = kFont(15);
        textLabel.textColor = defaultTextColor;
        textLabel.textAlignment = NSTextAlignmentCenter;
        textLabel.text = @"暂无数据";
        [cell.contentView addSubview:textLabel];
        textLabel.sd_layout.topSpaceToView(img, 15).widthIs(100).heightIs(16).centerXEqualToView(cell.contentView);
        
        return cell;
    }
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (self.listData.count > 0) {
        return self.tableheadView;
    }
    return self.tableheadViewEmpty;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (self.listData.count > 0) {
        return 148 + 64 + SafeAreaTopHeight;
    }
    return 64 + SafeAreaTopHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.00001;
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat imageOffsetY = scrollView.contentOffset.y;
    CGFloat height = 100 - imageOffsetY;
    if (height < 0) {
        height = 0;
    }
    _backview.sd_layout.topSpaceToView(self.view,0)
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .heightIs(height);
    [self.view layoutSubviews];
    
}

#pragma mark - LazyLoad

- (BaseTableView *)table{
    if (!_table) {
        _table = [[BaseTableView alloc]initWithFrame:CGRectMake(0, -(64 + SafeAreaTopHeight), SCREEN_WIDTH, SCREEN_HEIGHT + 64 + SafeAreaTopHeight)];
        _table.dataSource = self;
        _table.delegate = self;
        _table.backgroundColor = [UIColor clearColor];
    }
    return _table;
}

-(NSMutableArray *)listData{
    if (!_listData) {
        _listData = [[NSMutableArray alloc]init];
    }
    return _listData;
}

- (UITextField *)tradeMoneyTF{
    if (!_tradeMoneyTF) {
        _tradeMoneyTF = [[UITextField alloc]init];
        _tradeMoneyTF.text = @"";
        _tradeMoneyTF.textColor = WhiteColor;
        _tradeMoneyTF.font = kFont(30);
//        _tradeMoneyTF.placeholder
        _tradeMoneyTF.keyboardType = UIKeyboardTypeDecimalPad;
        _tradeMoneyTF.textAlignment = NSTextAlignmentCenter;
        
        NSRange strRange = NSMakeRange(1, 4);
        NSAttributedString *attrStr = [[NSAttributedString alloc]initWithString:@"￥0.00" attributes:                                              @{NSForegroundColorAttributeName:WhiteColor,                                                       NSFontAttributeName:[UIFont systemFontOfSize:18]}];
        NSMutableAttributedString *attrStr1 = [[NSMutableAttributedString alloc]initWithAttributedString:attrStr];
        [attrStr1 addAttribute:NSForegroundColorAttributeName value:WhiteColor range:strRange];
        [attrStr1 addAttribute:NSFontAttributeName value:kFont(30) range:strRange];
        _tradeMoneyTF.attributedPlaceholder = attrStr1;
        _tradeMoneyTF.tintColor = WhiteColor;
    }
    return _tradeMoneyTF;
}

- (UIView *)tableheadView{
    if (!_tableheadView) {
        _tableheadView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 148 + 64 + SafeAreaTopHeight)];
        _tableheadView.backgroundColor = HEXACOLOR(0x36b4fc);
        UILabel *label = [AppUIKit labelWithTitle:@"请输入本次交易金额"titleFontSize:12 textColor:WhiteColor backgroundColor:nil alignment:NSTextAlignmentCenter];
        [_tableheadView addSubview:label];
        label.sd_layout.topSpaceToView(_tableheadView, 32+ 64 + SafeAreaTopHeight).leftSpaceToView(_tableheadView, 12).rightSpaceToView(_tableheadView, 12).heightIs(12);
        [_tableheadView addSubview:self.tradeMoneyTF];
        self.tradeMoneyTF.sd_layout.topSpaceToView(label, 32).leftSpaceToView(_tableheadView, 12).rightSpaceToView(_tableheadView, 12).heightIs(24);
        
        UIView *lineV = [[UIView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH - 150) / 2, 112 + 64 + SafeAreaTopHeight, 150, 1)];
        lineV.backgroundColor = HEXACOLOR(0x36b4fc);
        [_tableheadView addSubview:lineV];
        [AppCommon drawDashLine:lineV lineLength:4 lineSpacing:2 lineColor:WhiteColor];
//        lineV.sd_layout.topSpaceToView(self.tradeMoneyTF, 14).centerXEqualToView(_tableheadView).heightIs(2).widthIs(180);
        
    }
    return _tableheadView;
}
- (UIView *)tableheadViewEmpty{
    if (!_tableheadViewEmpty) {
        _tableheadViewEmpty = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,64 + SafeAreaTopHeight)];
        _tableheadViewEmpty.backgroundColor = HEXACOLOR(0x36b4fc);
    }
    return _tableheadViewEmpty;
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}






@end
