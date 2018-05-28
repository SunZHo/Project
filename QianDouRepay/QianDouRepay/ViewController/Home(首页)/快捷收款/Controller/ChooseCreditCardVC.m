//
//  ChooseCreditCardVC.m
//  QianDouRepay
//
//  Created by <15>帝云科技 on 2018/4/13.
//  Copyright © 2018年 帝云科技<15>. All rights reserved.
//

#import "ChooseCreditCardVC.h"

// model
#import "ChooseCreditCardModel.h"

// view
#import "ChooseCreditCardCell.h"

// controller
#import "AddReceiptCreditCardVC.h"

@interface ChooseCreditCardVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic , strong) BaseTableView *table;

@property (nonatomic , strong) NSMutableArray *listData;

@end

@implementation ChooseCreditCardVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"选择信用卡";
    
//    for (int i = 0; i < 5; i++) {
//        ChooseCreditCardModel *model = [[ChooseCreditCardModel alloc]init];
//        model.bank_name = @"中国建设银行";
//        model.bank_num = @"6214221231231122123";
//
//        [self.listData addObject:model];
//    }
    
    [self.view addSubview:self.table];
    
    [self setNavRightBarItem];
}

- (void)loadData{
    [self.listData removeAllObjects];
    NSDictionary *dic = @{@"userid":UserID};
    [AppNetworking requestWithType:HttpRequestTypePost withUrlString:receipt_CreditCardList withParaments:dic withSuccessBlock:^(id json) {
        NSArray *infoA = [[json objectForKey:@"info"] objectForKey:@"list"];
        for (NSDictionary *cardDic in infoA) {
            ChooseCreditCardModel *model = [ChooseCreditCardModel mj_objectWithKeyValues:cardDic];
            
            [self.listData addObject:model];
        }
        [self.table reloadData];
        
    } withFailureBlock:^(NSString *errorMessage, int code) {
        [self.table reloadData];
    }];
}



- (void)setNavRightBarItem{
    UIButton *plusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [plusBtn addTarget:self action:@selector(plusClick) forControlEvents:UIControlEventTouchUpInside];
    [plusBtn setImage:[UIImage imageNamed:@"tj"] forState:UIControlStateNormal];
    [plusBtn sizeToFit];
    UIBarButtonItem *plusItem = [[UIBarButtonItem alloc] initWithCustomView:plusBtn];
    self.navigationItem.rightBarButtonItems  = @[plusItem];
}

#pragma mark - 添加信用卡
- (void)plusClick{
    AddReceiptCreditCardVC *addCreditVc = [[AddReceiptCreditCardVC alloc]init];
    PUSHVC(addCreditVc);
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
        return 100;
    }else{
        return 180;
    }
    
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.listData.count > 0) {
        static NSString *identifier = @"ChooseCreditCardCell";
        ChooseCreditCardModel *model = [self.listData objectAtIndex:indexPath.row];
        ChooseCreditCardCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[ChooseCreditCardCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        [cell setChooseModel:model];
        cell.unBindBlock = ^{
            NSDictionary *dic = @{@"crediteid":model.ID,
                                  @"userid":UserID
                                  };
            [self showLoading];
            [AppNetworking requestWithType:HttpRequestTypePost withUrlString:receipt_unBindCreditCard withParaments:dic withSuccessBlock:^(id json) {
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
    if (self.listData.count > 0) {
        ChooseCreditCardModel *model = [self.listData objectAtIndex:indexPath.row];
        [self receiptMoneyOption:model.ID];
    }
}

- (void)receiptMoneyOption:(NSString *)creditID{
    NSDictionary *dic = @{@"userid":UserID,
                          @"debitid":self.receiptBankCardID,
                          @"crediteid":creditID,
                          @"money":self.receiptMoney
                          };
    [self showLoading];
    [AppNetworking requestWithType:HttpRequestTypePost withUrlString:receipt_Pay withParaments:dic withSuccessBlock:^(id json) {
        [self dismissLoading];
        NSString *html = [[json objectForKey:@"info"] objectForKey:@"hx_page"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            QDWebViewController *web = [[QDWebViewController alloc]init];
            web.loadHtml = html;
            web.isReceiptPush = YES;
            [self.navigationController pushViewController:web animated:YES];
            
        });
    } withFailureBlock:^(NSString *errorMessage, int code) {
        
    }];
    
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
