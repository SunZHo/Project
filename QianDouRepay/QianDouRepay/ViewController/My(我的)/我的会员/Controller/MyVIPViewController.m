//
//  MyVIPViewController.m
//  QianDouRepay
//
//  Created by <15>帝云科技 on 2018/4/17.
//  Copyright © 2018年 帝云科技<15>. All rights reserved.
//

#import "MyVIPViewController.h"
#import "PromotionViewController.h"

@interface MyVIPViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic , strong) BaseTableView *table;

@property (nonatomic , copy) NSArray *titleArray;
@property (nonatomic , copy) NSArray *valueArray;

@property (nonatomic , strong) UIView *tableheadV;
@property (nonatomic , strong) UILabel *peopleLabel;
@property (nonatomic , strong) UILabel *moneyLabel;

@end

@implementation MyVIPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的会员";
    [super setNavAlphaZero];
    [self wr_setNavBarTitleColor:WhiteColor];
    [self loadData];
    [self makeUI];
}

- (void)loadData{
    NSString *money = @"234";
    NSString *people = @"12";
    
    self.peopleLabel.text = [NSString stringWithFormat:@"%@位",people];
    self.moneyLabel.text = [NSString stringWithFormat:@"￥%@",money];
    
    self.peopleLabel.attributedText = [AppCommon getRange:NSMakeRange(0, people.length) labelStr:[NSString stringWithFormat:@"%@位",people] Font:kFont(30) Color:WhiteColor];
    
    self.moneyLabel.attributedText = [AppCommon getRange:NSMakeRange(@"￥".length, money.length) labelStr:[NSString stringWithFormat:@"￥%@",money] Font:kFont(30) Color:WhiteColor];
    
    
    self.titleArray = @[@"直接推广",@"间接推广"];
    self.valueArray = @[@"15人",@"15人"];
    
    
}

- (void)makeUI{
    [self.view addSubview:self.table];
}



#pragma mark - table
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.titleArray.count;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifiyImg = @"VIPCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifiyImg];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifiyImg];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    UIView *linev = [[UIView alloc]init];
    linev.backgroundColor = Default_BackgroundGray;
    
    UILabel *textLabel = [AppUIKit labelWithTitle:self.titleArray[indexPath.row] titleFontSize:15 textColor:defaultTextColor backgroundColor:nil alignment:0];
    UILabel *valueLabel = [AppUIKit labelWithTitle:self.valueArray[indexPath.row] titleFontSize:15 textColor:HEXACOLOR(0x666666) backgroundColor:nil alignment:NSTextAlignmentRight];
    
    UIImageView *img = [[UIImageView alloc]initWithImage:IMG(@"zsjt")];
    
    [cell.contentView addSubview:linev];
    [cell.contentView addSubview:textLabel];
    [cell.contentView addSubview:valueLabel];
    [cell.contentView addSubview:img];
    
    linev.sd_layout
    .topEqualToView(cell.contentView).leftEqualToView(cell.contentView).rightEqualToView(cell.contentView).heightIs(10);
    
    textLabel.sd_layout.leftSpaceToView(cell.contentView, 12).widthIs(70).heightIs(50).topSpaceToView(linev, 0);
    valueLabel.sd_layout.rightSpaceToView(cell.contentView, 28).leftSpaceToView(textLabel, 10).heightIs(50).topEqualToView(textLabel);
    img.sd_layout.rightSpaceToView(cell.contentView, 12).heightIs(9).widthIs(5).centerYEqualToView(textLabel);
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    PromotionViewController *promotionVC = [[PromotionViewController alloc]init];
    promotionVC.navTitle = self.titleArray[indexPath.row];
    PUSHVC(promotionVC);
}


#pragma mark - LazyLoad

- (BaseTableView *)table{
    if (!_table) {
        _table = [[BaseTableView alloc]initWithFrame:CGRectMake(0, -(64 + SafeAreaTopHeight), SCREEN_WIDTH, SCREEN_HEIGHT + 64 + SafeAreaTopHeight)];
        _table.dataSource = self;
        _table.delegate = self;
        _table.tableHeaderView = self.tableheadV;
    }
    return _table;
}


- (UIView *)tableheadV{
    if (!_tableheadV) {
        _tableheadV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
        _tableheadV.backgroundColor = HEXACOLOR(0x36b4fc);
        UIView *linev = [[UIView alloc]init];
        linev.backgroundColor = WhiteColor;
        
        UILabel *totalPeople = [AppUIKit labelWithTitle:@"累计注册用户" titleFontSize:12 textColor:WhiteColor backgroundColor:nil alignment:NSTextAlignmentCenter];
        
        UILabel *totalMoney = [AppUIKit labelWithTitle:@"累计获得奖励" titleFontSize:12 textColor:WhiteColor backgroundColor:nil alignment:NSTextAlignmentCenter];
        
        [_tableheadV sd_addSubviews:@[totalPeople,totalMoney, self.peopleLabel,self.moneyLabel,linev]];
        
        totalPeople.sd_layout.topSpaceToView(_tableheadV, 105).leftEqualToView(_tableheadV).widthRatioToView(_tableheadV, 0.5).heightIs(12);
        
        totalMoney.sd_layout.topEqualToView(totalPeople).rightEqualToView(_tableheadV).widthRatioToView(_tableheadV, 0.5).heightIs(12);
        
        self.peopleLabel.sd_layout.topSpaceToView(totalPeople, 18).leftEqualToView(totalPeople).rightEqualToView(totalPeople).heightIs(23);
        self.moneyLabel.sd_layout
        .topEqualToView(self.peopleLabel).leftEqualToView(totalMoney).rightEqualToView(totalMoney).heightIs(23);
        
        linev.sd_layout.topSpaceToView(_tableheadV, 119).centerXEqualToView(_tableheadV).widthIs(1).heightIs(25);
    }
    return _tableheadV;
}

- (UILabel *)peopleLabel{
    if (!_peopleLabel) {
        _peopleLabel = [AppUIKit labelWithTitle:@"" titleFontSize:12 textColor:WhiteColor backgroundColor:nil alignment:NSTextAlignmentCenter];
    }
    return _peopleLabel;
}

- (UILabel *)moneyLabel{
    if (!_moneyLabel) {
        _moneyLabel = [AppUIKit labelWithTitle:@"" titleFontSize:12 textColor:WhiteColor backgroundColor:nil alignment:NSTextAlignmentCenter];
    }
    return _moneyLabel;
}






@end
