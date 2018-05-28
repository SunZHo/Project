//
//  ChooseBankCardVC.m
//  QianDouRepay
//
//  Created by <15>帝云科技 on 2018/4/13.
//  Copyright © 2018年 帝云科技<15>. All rights reserved.
//

#import "ChooseBankCardVC.h"
#import "ChooseCreditCardVC.h"
// view
#import "BankCardCell.h"

// model
#import "BankCardModel.h"
#import "AddReceiptBankCardVC.h"


@interface ChooseBankCardVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic , strong) BaseTableView *table;

@property (nonatomic , strong) NSMutableArray *listData;

@end

@implementation ChooseBankCardVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self loadData];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"选择储蓄卡";
    NSLog(@"收款钱数==%@ ",self.receiptMoney);
    [self makeUI];
    
    [self setNavRightBarItem];
}

- (void)makeUI{
    [self.view addSubview:self.table];
    
}


- (void)setNavRightBarItem{
    UIButton *plusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [plusBtn addTarget:self action:@selector(plusClick) forControlEvents:UIControlEventTouchUpInside];
    [plusBtn setImage:[UIImage imageNamed:@"tj"] forState:UIControlStateNormal];
    [plusBtn sizeToFit];
    UIBarButtonItem *plusItem = [[UIBarButtonItem alloc] initWithCustomView:plusBtn];
    self.navigationItem.rightBarButtonItems  = @[plusItem];
}

#pragma mark - 添加储蓄卡
- (void)plusClick{
    AddReceiptBankCardVC *addCreditVc = [[AddReceiptBankCardVC alloc]init];
    PUSHVC(addCreditVc);
}

- (void)loadData{
    [self.listData removeAllObjects];
    NSDictionary *dic = @{@"userid":UserID};
    [AppNetworking requestWithType:HttpRequestTypePost withUrlString:receipt_bankCardList withParaments:dic withSuccessBlock:^(id json) {
        NSDictionary *infoDic = [json objectForKey:@"info"];
        NSArray *arr = [infoDic objectForKey:@"list"];
        for (NSDictionary *bankDic in arr) {
            BankCardModel *model = [BankCardModel mj_objectWithKeyValues:bankDic];
            model.name = [UserInfoDic objectForKey:@"realname"];
            model.isUnbind = YES;
            [self.listData addObject:model];
        }
        [self.table reloadData];
    } withFailureBlock:^(NSString *errorMessage, int code) {
        [self.table reloadData];
    }];
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
        return 180;
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
        cell.unBindBlock = ^{
            NSDictionary *dic = @{@"debitid":model.ID,
                                  @"userid":UserID
                                  };
            [self showLoading];
            [AppNetworking requestWithType:HttpRequestTypePost withUrlString:receipt_unBindCard withParaments:dic withSuccessBlock:^(id json) {
                [self showSuccessText:@"解绑成功"];
                [self loadData];
            } withFailureBlock:^(NSString *errorMessage, int code) {
                
            }];
        };
        
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
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"didse");
    if (self.listData.count > 0) {
        BankCardModel *model = [self.listData objectAtIndex:indexPath.row];
        ChooseCreditCardVC *creditVc = [[ChooseCreditCardVC alloc]init];
        creditVc.receiptBankCardID = model.ID;
        creditVc.receiptMoney = self.receiptMoney;
        PUSHVC(creditVc);
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



@end
