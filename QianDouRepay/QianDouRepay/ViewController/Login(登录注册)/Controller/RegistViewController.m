//
//  RegistViewController.m
//  QianDouRepay
//
//  Created by <15>帝云科技 on 2018/4/9.
//  Copyright © 2018年 帝云科技<15>. All rights reserved.
//

#import "RegistViewController.h"
#import "FormCell.h"
#import "FormCellModel.h"
#import "LoginHeadView.h"
#import "AgreementViewController.h"

@interface RegistViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic , strong) BaseTableView *table;
@property (nonatomic , strong) NSMutableArray *formData;
@property (nonatomic , strong) UIImageView *topImage;
@property (nonatomic , strong) LoginHeadView *headView;
@property (nonatomic , strong) UIButton *sureBtn;  // 注册
@property (nonatomic , strong) UIButton *xieyiBtn; // 协议
@property (nonatomic , strong) UIButton *loginBtn; // 已有账号，立即登录
@property (nonatomic , copy) NSString *verifyCode;

@end

@implementation RegistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [super setNavAlphaZero];
    self.title = @"注册";
    self.view.backgroundColor = [UIColor whiteColor];
    [self wr_setNavBarTitleColor:HEXACOLOR(0xffffff)];
    [self setupLeftBarButtonItem];
    [self.view addSubview:self.headView];
    [self.headView addSubview:self.topImage];
    
    self.topImage.sd_layout.centerXEqualToView(self.headView).bottomSpaceToView(self.headView, 24).heightIs(76).widthIs(76);
    self.topImage.sd_cornerRadiusFromWidthRatio = @(0.5);
    
//    [self.view addSubview:self.topImage];
//    self.topImage.sd_layout.topSpaceToView(self.view, 0).leftEqualToView(self.view).rightEqualToView(self.view).heightIs(200);
    
    [self loadFormData];
    [self.view addSubview:self.table];
    [self.view addSubview:self.xieyiBtn];
    [self.view addSubview:self.sureBtn];
    [self.view addSubview:self.loginBtn];
    
    self.xieyiBtn.sd_layout.leftEqualToView(self.table).topSpaceToView(self.table, kScaleWidth(15)).rightEqualToView(self.table).heightIs(12);
    
    self.sureBtn.sd_layout.leftEqualToView(self.table).topSpaceToView(self.xieyiBtn, kScaleWidth(30)).rightEqualToView(self.table).heightIs(44);
    self.sureBtn.sd_cornerRadius = @5;
    
    self.loginBtn.sd_layout.leftEqualToView(self.table).bottomSpaceToView(self.view, kScaleWidth(25)).rightEqualToView(self.table).heightIs(13);
    
    
    
}

#pragma mark - 导航按钮
- (void)setupLeftBarButtonItem
{
    self.navigationItem.leftBarButtonItem =({
        [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"bjtou"]
                                        style:UIBarButtonItemStylePlain
                                       target:self
                                       action:@selector(leftBarButtonItemClicked)];
        
    });
}

- (void)leftBarButtonItemClicked{
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.formData.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kScaleWidth(50);
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    FormCellModel *model = [self.formData objectAtIndex:indexPath.row];
    static NSString *identifier1 = @"formCell";
    FormCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier1];
    if (!cell) {
        cell = [[FormCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier1];
    }
    cell.cellTextFieldBlock = ^(NSString *text) {
        [self notiTextField:text andIndex:indexPath];
    };
    cell.getVerifyCodeBlock = ^{
        [self getVerifyCode];
    };
    
    [cell setFormcellModel:model];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"didse");
}


- (void)notiTextField:(NSString *)text andIndex:(NSIndexPath *)indexPath{
    FormCellModel *model = [self.formData objectAtIndex:indexPath.row];
    model.text = text;
}

- (void)loadFormData{
    FormCellModel *model1 = [[FormCellModel alloc]init];
    model1.cellType = cellTypeIcon_FieldType;
    model1.text = @"";
    model1.imageName = @"shouj";
    model1.canEdit = YES;
    model1.boardType = UIKeyboardTypeNumberPad;
    model1.placeHolder = @"请输入您的手机号";
    model1.reqKey = @"phone";
    
    FormCellModel *model2 = [[FormCellModel alloc]init];
    model2.cellType = cellTypeIcon_FieldVeirfyCodeType;
    model2.text = @"";
    model2.imageName = @"dx";
    model2.canEdit = YES;
    model2.boardType = UIKeyboardTypeNumberPad;
    model2.placeHolder = @"请输入短信验证码";
    model2.reqKey = @"smscode";
    
    FormCellModel *model3 = [[FormCellModel alloc]init];
    model3.cellType = cellTypeIcon_FieldType;
    model3.text = @"";
    model3.imageName = @"mima";
    model3.canEdit = YES;
    model3.isSecureText = YES;
    model3.boardType = UIKeyboardTypeDefault;
    model3.placeHolder = @"请输入密码";
    model3.reqKey = @"pass";
    
    FormCellModel *model4 = [[FormCellModel alloc]init];
    model4.cellType = cellTypeIcon_FieldType;
    model4.text = @"";
    model4.imageName = @"zc";
    model4.canEdit = YES;
    model4.isSecureText = YES;
    model4.boardType = UIKeyboardTypeDefault;
    model4.placeHolder = @"请再次输入密码";
    model4.reqKey = @"repass";
    
    FormCellModel *model5 = [[FormCellModel alloc]init];
    model5.cellType = cellTypeIcon_FieldType;
    model5.text = @"";
    model5.imageName = @"yaoq";
    model5.canEdit = YES;
    model5.boardType = UIKeyboardTypeDefault;
    model5.placeHolder = @"请输入邀请码(选填)";
    model5.reqKey = @"code";
    
    [self.formData addObjectsFromArray:@[model1,model2,model3,model4,model5]];
}

#pragma mark - 按钮点击

- (void)sureClick{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    FormCellModel *model0 = self.formData[0];
    FormCellModel *model1 = self.formData[1];
    FormCellModel *model2 = self.formData[2];
    FormCellModel *model3 = self.formData[3];
    FormCellModel *model4 = self.formData[4];
    if ([model0.text isEqualToString:@""]) {
        [self showErrorText:@"请填写手机号"];
        return;
    }
    if ([model1.text isEqualToString:@""]) {
        [self showErrorText:@"请输入短信验证码"];
        return;
    }
    if (![model1.text isEqualToString:self.verifyCode]) {
        [self showErrorText:@"验证码错误"];
        return;
    }
    if ([model2.text isEqualToString:@""]) {
        [self showErrorText:@"请填写密码"];
        return;
    }
    if (![model2.text isEqualToString:model3.text]) {
        [self showErrorText:@"两次输入密码不一致"];
        return;
    }
    [dic setValue:model0.text forKey:@"phone"];
    [dic setValue:model2.text forKey:@"pass"];
    [dic setValue:model4.text forKey:@"code"];
    [AppNetworking requestWithType:HttpRequestTypePost withUrlString:regUrl withParaments:dic withSuccessBlock:^(id json) {
        NSDictionary *infoDic = [json objectForKey:@"info"];
        NSString *phone = [infoDic objectForKey:@"phone"];
        NSString *uid = [infoDic objectForKey:@"id"];
        NSString *nickName = [infoDic objectForKey:@"nick_name"];
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setValue:uid forKey:@"uid"];
        [dic setValue:@"1" forKey:@"loginStatus"];
        [dic setValue:phone forKey:@"phone"];
        [dic setValue:nickName forKey:@"nickname"];
        [dic setValue:@"" forKey:@"avatar"];
        ApplicationDelegate.userInfoManager.userInfo = dic;
        ApplicationDelegate.userInfoManager.userId = uid;
        ApplicationDelegate.userInfoManager.loginStatus = @"1";
        [UserInfoCache archiveUserInfo:dic keyedArchiveName:USER_INFO_CACHE];
        [self showSuccessText:@"注册成功"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController dismissViewControllerAnimated:YES completion:nil];
        });
        
    } withFailureBlock:^(NSString *errorMessage, int code) {
        
    }];
    
    
}

- (void)xieyiClick{
    AgreementViewController *agreevc = [[AgreementViewController alloc]init];
    PUSHVC(agreevc);
}

- (void)loginClick{
    POPVC;
}

- (void)getVerifyCode{
    NSString *phone = @"";
    FormCellModel *model = self.formData[0];
    phone = model.text;
    
    if (![phone isEqualToString:@""]) {
        NSDictionary *dic = @{@"phone" : phone};
        [self showLoading];
        [AppNetworking requestWithType:HttpRequestTypePost withUrlString:regSmsUrl withParaments:dic withSuccessBlock:^(id json){
            [self dismissLoading];
            NSDictionary *infoDic = [json objectForKey:@"info"];
            self.verifyCode = [NSString stringWithFormat:@"%ld",[[infoDic objectForKey:@"code"] integerValue]];
            [[NSNotificationCenter defaultCenter]postNotificationName:CountingDownNotiName object:nil];
        } withFailureBlock:^(NSString *errorMessage, int code) {
            
        }];
    }else{
        [self showErrorText:@"请填写手机号"];
    }
}

#pragma mark - LazyLoad

- (BaseTableView *)table{
    if (!_table) {
        _table = [[BaseTableView alloc]initWithFrame:CGRectMake(50, 200, SCREEN_WIDTH - 100, kScaleWidth(250))];
        _table.dataSource = self;
        _table.delegate = self;
        _table.scrollEnabled = NO;
        _table.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    }
    return _table;
}

- (NSMutableArray *)formData{
    if (!_formData) {
        _formData = [[NSMutableArray alloc]init];
    }
    return _formData;
}

- (LoginHeadView *)headView{
    if (!_headView) {
        _headView = [[LoginHeadView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
    }
    return _headView;
}

- (UIImageView *)topImage{
    if (!_topImage) {
        _topImage = [[UIImageView alloc]init];
        _topImage.image = IMG(@"loginLogo");
        _topImage.layer.borderColor = [UIColor whiteColor].CGColor;
        _topImage.layer.borderWidth = 5;
    }
    return _topImage;
}

- (UIButton *)sureBtn{
    if (!_sureBtn) {
        _sureBtn = [AppUIKit createBtnWithType:UIButtonTypeCustom
                               backgroundColor:APPMainColor
                                        action:@selector(sureClick)
                                        target:self
                                         title:@"确认"
                                         image:nil
                                          font:14
                                     textColor:HEXACOLOR(0xffffff)];
    }
    return _sureBtn;
}

- (UIButton *)xieyiBtn{
    if (!_xieyiBtn) {
        _xieyiBtn = [AppUIKit createBtnWithType:UIButtonTypeCustom
                               backgroundColor:nil
                                        action:@selector(xieyiClick)
                                        target:self
                                         title:@"点击注册即代表同意《平台注册协议》"
                                         image:nil
                                          font:11
                                     textColor:HEXACOLOR(0x999999)];
       NSAttributedString *str = [AppCommon getRange:NSMakeRange(@"点击注册即代表同意".length, @"《平台注册协议》".length) labelStr:@"点击注册即代表同意《平台注册协议》" Font:kFont(11) Color:HEXACOLOR(0xf68029)];
        [_xieyiBtn setAttributedTitle:str forState:UIControlStateNormal];
        _xieyiBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    }
    return _xieyiBtn;
}

- (UIButton *)loginBtn{
    if (!_loginBtn) {
        _loginBtn = [AppUIKit createBtnWithType:UIButtonTypeCustom
                               backgroundColor:nil
                                        action:@selector(loginClick)
                                        target:self
                                         title:@"已有账号，立即登录"
                                         image:nil
                                          font:12
                                     textColor:defaultTextColor];
    }
    return _loginBtn;
}

@end
