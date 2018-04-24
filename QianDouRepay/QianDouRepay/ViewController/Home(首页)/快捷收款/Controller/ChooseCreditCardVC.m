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
#import "AddCreditCardViewController.h"

@interface ChooseCreditCardVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic , strong) BaseTableView *table;

@property (nonatomic , strong) NSMutableArray *listData;

@end

@implementation ChooseCreditCardVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"选择信用卡";
    
    for (int i = 0; i < 5; i++) {
        ChooseCreditCardModel *model = [[ChooseCreditCardModel alloc]init];
        model.bankName = @"中国建设银行";
        model.cardNum = @"6214  ****  ****  ****  123";
        
        [self.listData addObject:model];
    }
    
    [self.view addSubview:self.table];
    
    [self setNavRightBarItem];
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
    AddCreditCardViewController *addCreditVc = [[AddCreditCardViewController alloc]init];
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


#pragma mark - LazyLoad

- (BaseTableView *)table{
    if (!_table) {
        _table = [[BaseTableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
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
