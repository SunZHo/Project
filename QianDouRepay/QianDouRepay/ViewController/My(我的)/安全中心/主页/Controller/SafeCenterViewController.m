//
//  SafeCenterViewController.m
//  QianDouRepay
//
//  Created by <15>帝云科技 on 2018/4/16.
//  Copyright © 2018年 帝云科技<15>. All rights reserved.
//

#import "SafeCenterViewController.h"

// viewcontroller
#import "CertifyNameVC.h"
#import "ChangeOldPhoneVC.h"
#import "ChangePassWordVC.h"
#import "BankCardViewController.h"

@interface SafeCenterViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic , strong) BaseTableView *table;

@property (nonatomic , copy) NSArray *nameArray;

@property (nonatomic , copy) NSArray *iconArray;

/** 是否绑定手机 */
@property (nonatomic , assign) BOOL hasBingPhone;
/** 是否实名认证 */
@property (nonatomic , assign) BOOL hasCertifiedName;
/** 是否绑定银行卡 */
@property (nonatomic , assign) BOOL hasBingBankCard;

@end

@implementation SafeCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"安全中心";
    [self.view addSubview:self.table];
    self.nameArray = @[@"实名认证",@"更改手机号",@"密码修改",@"银行卡"];
    self.iconArray = @[@"smrz",@"sjh",@"mmxg",@"yhk"];
    
    self.hasBingPhone = YES;
    self.hasBingBankCard = NO;
    self.hasCertifiedName = NO;
}


#pragma mark - table
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.nameArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}



- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifiyImg = @"safeCenterCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifiyImg];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifiyImg];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    UIImageView *img = [[UIImageView alloc]init];
    img.image = IMG(self.iconArray[indexPath.row]);
    [cell.contentView addSubview:img];
    
    UILabel *textLabel = [AppUIKit labelWithTitle:self.nameArray[indexPath.row] titleFontSize:15 textColor:defaultTextColor backgroundColor:nil alignment:NSTextAlignmentLeft];
    [cell.contentView addSubview:textLabel];
    textLabel.sd_layout.leftSpaceToView(cell.contentView, 45).widthIs(100).heightIs(16).centerYEqualToView(cell.contentView);
    
    UIImageView *rowimg = [[UIImageView alloc]init];
    rowimg.image = [UIImage imageNamed:@"zsjt"];
    [cell.contentView addSubview:rowimg];
    rowimg.sd_layout.rightSpaceToView(cell.contentView, 13).widthIs(5).heightIs(9).centerYEqualToView(cell.contentView);
    
    UILabel *rightTextLabel = [AppUIKit labelWithTitle:@"" titleFontSize:12 textColor:defaultTextColor backgroundColor:nil alignment:NSTextAlignmentRight];
    [cell.contentView addSubview:rightTextLabel];
    rightTextLabel.sd_layout.rightSpaceToView(cell.contentView, 28).widthIs(100).heightIs(13).centerYEqualToView(cell.contentView);
    
    
    if (indexPath.row == 0) {
        img.sd_layout.leftSpaceToView(cell.contentView, 12).widthIs(18).heightIs(15).centerYEqualToView(cell.contentView);
        if (!self.hasCertifiedName) {
            rightTextLabel.text = @"未认证";
            rightTextLabel.textColor = HEXACOLOR(0xf68029);
        }else{
            rightTextLabel.text = @"已认证";
            rightTextLabel.textColor = defaultTextColor;
        }
        
    }else if (indexPath.row == 1){
        img.sd_layout.leftSpaceToView(cell.contentView, 16).widthIs(11).heightIs(17).centerYEqualToView(cell.contentView);
        if (!self.hasBingPhone) {
            rightTextLabel.text = @"";
            rightTextLabel.textColor = HEXACOLOR(0xf68029);
        }else{
            rightTextLabel.text = @"155****2211";
            rightTextLabel.textColor = defaultTextColor;
        }
    }else if (indexPath.row == 2){
        img.sd_layout.leftSpaceToView(cell.contentView, 15).widthIs(13).heightIs(16).centerYEqualToView(cell.contentView);
    }else if (indexPath.row == 3){
        img.sd_layout.leftSpaceToView(cell.contentView, 13).widthIs(16).heightIs(13).centerYEqualToView(cell.contentView);
        if (!self.hasBingBankCard) {
            rightTextLabel.text = @"未绑定";
            rightTextLabel.textColor = HEXACOLOR(0xf68029);
        }else{
            rightTextLabel.text = @"已绑定";
            rightTextLabel.textColor = defaultTextColor;
        }
    }
    
    return cell;
    
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        CertifyNameVC *certiVC = [[CertifyNameVC alloc]init];
        PUSHVC(certiVC);
    }else if (indexPath.row == 1){
        ChangeOldPhoneVC *changePhoneVC = [[ChangeOldPhoneVC alloc]init];
        PUSHVC(changePhoneVC);
    }else if (indexPath.row == 2){
        ChangePassWordVC *changePwdVC = [[ChangePassWordVC alloc]init];
        PUSHVC(changePwdVC);
    }else if (indexPath.row == 3){
        BankCardViewController *bankCardVC = [[BankCardViewController alloc]init];
        PUSHVC(bankCardVC);
    }
}



#pragma mark - LazyLoad

- (BaseTableView *)table{
    if (!_table) {
        _table = [[BaseTableView alloc]initWithFrame:CGRectMake(0, 64 + SafeAreaTopHeight, SCREEN_WIDTH, SCREEN_HEIGHT - (64 + SafeAreaTopHeight))];
        _table.dataSource = self;
        _table.delegate = self;
        _table.backgroundColor = WhiteColor;
        _table.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    }
    return _table;
}

-(NSArray *)nameArray{
    if (!_nameArray) {
        _nameArray = [[NSArray alloc]init];
    }
    return _nameArray;
}


@end
