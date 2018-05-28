//
//  LoginViewController.m
//  QianDouRepay
//
//  Created by <15>帝云科技 on 2018/4/9.
//  Copyright © 2018年 帝云科技<15>. All rights reserved.
//

#import "LoginViewController.h"
#import "RegistViewController.h"
#import "ForgetPwdVC.h"
#import "LoginHeadView.h"
#define regTag       1
#define forgetTag    2

@interface LoginViewController ()

@property (nonatomic , strong) LoginHeadView *headView;
@property (nonatomic , strong) UIImageView *topImage;
@property (nonatomic , strong) BaseTableView *table;
@property (nonatomic , strong) UITextField *phoneTF;
@property (nonatomic , strong) UITextField *pwdTF;
@property (nonatomic , strong) UIButton *sureBtn;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"登录";
    [super setNavAlphaZero];
    [self wr_setNavBarTitleColor:[UIColor whiteColor]];
    self.view.backgroundColor = [UIColor whiteColor];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldChanged:) name:UITextFieldTextDidChangeNotification object:nil];
    [self setupSubViews];
    [self setupLeftBarButtonItem];
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
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)setupSubViews{
    
    [self.view addSubview:self.headView];
    [self.headView addSubview:self.topImage];
    
    self.topImage.sd_layout.centerXEqualToView(self.headView).bottomSpaceToView(self.headView, 24).heightIs(76).widthIs(76);
    self.topImage.sd_cornerRadiusFromWidthRatio = @(0.5);
    
    UIImageView *phoneImg = [[UIImageView alloc]initWithImage:IMG(@"shouj")];
    [self.view addSubview:phoneImg];
    [self.view addSubview:self.phoneTF];
    UIView *phoneLine = [[UIView alloc]init];
    phoneLine.backgroundColor = HEXACOLOR(0xf1f1f1);
    [self.view addSubview:phoneLine];
    
    UIImageView *pwdImg = [[UIImageView alloc]initWithImage:IMG(@"mima")];
    [self.view addSubview:pwdImg];
    
    [self.view addSubview:self.pwdTF];
    
    UIView *pwdLine = [[UIView alloc]init];
    pwdLine.backgroundColor = HEXACOLOR(0xf1f1f1);
    [self.view addSubview:pwdLine];
    
    
    
    [self.view addSubview:self.sureBtn];
    
    self.phoneTF.sd_layout.topSpaceToView(self.headView, 10).leftSpaceToView(self.view, 90).heightIs(30).rightSpaceToView(self.view, 50);
    
    phoneImg.sd_layout.centerYEqualToView(self.phoneTF).leftSpaceToView(self.view, 50).heightIs(17).widthIs(12);
    
    phoneLine.sd_layout.leftEqualToView(phoneImg).topSpaceToView(self.phoneTF, 5).rightEqualToView(self.phoneTF).heightIs(1);
    
    self.pwdTF.sd_layout.topSpaceToView(phoneLine, 30).leftSpaceToView(self.view, 90).heightRatioToView(self.phoneTF, 1).rightSpaceToView(self.view, 50);
    pwdImg.sd_layout.centerYEqualToView(self.pwdTF).leftSpaceToView(self.view, 50).heightIs(17).widthIs(12);
    
    pwdLine.sd_layout.leftEqualToView(pwdImg).topSpaceToView(self.pwdTF,5).rightEqualToView(self.phoneTF).heightIs(1);
    
    self.sureBtn.sd_layout.leftEqualToView(pwdImg).topSpaceToView(pwdLine, 40).rightEqualToView(pwdLine).heightIs(44);
    self.sureBtn.sd_cornerRadius = @5;
    
    
    UIButton *registBtn = [AppUIKit createBtnWithType:UIButtonTypeCustom backgroundColor:nil action:@selector(clickEvent:) target:self title:@"立即注册" image:nil font:12 textColor:defaultTextColor];
    registBtn.tag = regTag;
    [self.view addSubview:registBtn];
    
    UIButton *forgetPwdBtn = [AppUIKit createBtnWithType:UIButtonTypeCustom backgroundColor:nil action:@selector(clickEvent:) target:self title:@"忘记密码" image:nil font:12 textColor:defaultTextColor];
    forgetPwdBtn.tag = forgetTag;
    [self.view addSubview:forgetPwdBtn];
    
    registBtn.sd_layout.leftSpaceToView(self.view, kScaleWidth(100)).bottomSpaceToView(self.view, 32 + SafeAreaBottomHeight).widthIs(60).heightIs(20);
    
    forgetPwdBtn.sd_layout.rightSpaceToView(self.view, kScaleWidth(100)).bottomSpaceToView(self.view, 32 + SafeAreaBottomHeight).widthIs(60).heightIs(20);
    
    UIView *bottomLine = [[UIView alloc]init];
    bottomLine.backgroundColor = HEXACOLOR(0x5cb7ff);
    [self.view addSubview:bottomLine];
    
    bottomLine.sd_layout.centerXEqualToView(self.view).centerYEqualToView(registBtn).widthIs(1).heightIs(12);
}

#pragma mark Notification
- (void)textFieldChanged:(NSNotification *)noti{
    
}

- (void)sureClick{
    if ([self.phoneTF.text isEqualToString:@""]) {
        [self showErrorText:@"请填写手机号"];
        return;
    }
    if ([self.pwdTF.text isEqualToString:@""]) {
        [self showErrorText:@"请填写密码"];
        return;
    }
    NSDictionary *dic = @{
                          @"phone":self.phoneTF.text,
                          @"pass" :self.pwdTF.text
                          };
    [self showLoading];
    [AppNetworking requestWithType:HttpRequestTypePost withUrlString:loginUrl withParaments:dic withSuccessBlock:^(id json) {
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
        [self showSuccessText:@"登录成功"];
        [self loadUserInfoData];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController dismissViewControllerAnimated:YES completion:nil];
        });
    } withFailureBlock:^(NSString *errorMessage, int code) {
        
    }];
    
}

- (void)clickEvent:(UIButton *)sender{
    if (sender.tag == regTag) {
        RegistViewController *regVC = [[RegistViewController alloc]init];
        [self.navigationController pushViewController:regVC animated:YES];
    }else{
        ForgetPwdVC *forgetVC = [[ForgetPwdVC alloc]init];
        [self.navigationController pushViewController:forgetVC animated:YES];
    }
}


- (void)loadUserInfoData{
    NSDictionary *dic = @{@"userid" : UserID};
    [AppNetworking requestWithType:HttpRequestTypePost withUrlString:my_accountInfo withParaments:dic withSuccessBlock:^(id json) {
        NSDictionary *infoDic = [json objectForKey:@"info"];
        // 昵称
        [UserInfoDic setObject:[infoDic objectForKey:@"nickname"] forKey:@"nickname"];
        // 手机号
        [UserInfoDic setObject:[infoDic objectForKey:@"phone"]  forKey:@"phone"];
        // 账户余额
        [UserInfoDic setObject:[infoDic objectForKey:@"account_money"] forKey:@"account_money"];
        // 是否升级推广员 1-是，0-否
        [UserInfoDic setObject:[infoDic objectForKey:@"is_vip"] forKey:@"is_vip"];
        // 提现卡 1-已绑卡，0-未绑卡
        [UserInfoDic setObject:[infoDic objectForKey:@"cash_bank"] forKey:@"cash_bank"];
        // 还款费率
        [UserInfoDic setObject:[infoDic objectForKey:@"pay_cost"] forKey:@"pay_cost"];
        // 还款单笔固定手续费
        [UserInfoDic setObject:[infoDic objectForKey:@"cash_fee"] forKey:@"cash_fee"];
        // 收款费率
        [UserInfoDic setObject:[infoDic objectForKey:@"get_cost"] forKey:@"get_cost"];
        // 收款单笔固定手续费
        [UserInfoDic setObject:[infoDic objectForKey:@"get_fee"] forKey:@"get_fee"];
        // 系统编号：邀请码
        [UserInfoDic setObject:[infoDic objectForKey:@"sys_code"] forKey:@"sys_code"];
        // 实名状态：1-是，0-否
        [UserInfoDic setObject:[infoDic objectForKey:@"is_confirm"] forKey:@"is_confirm"];
        // 提现手续费
        [UserInfoDic setObject:[infoDic objectForKey:@"member_cash"] forKey:@"member_cash"];
        // 真实姓名
        [UserInfoDic setObject:[infoDic objectForKey:@"realname"] forKey:@"realname"];
        // 身份证号码
        [UserInfoDic setObject:[infoDic objectForKey:@"idcard"] forKey:@"idcard"];
        // 性别：0-保密，1-男，2-女
        [UserInfoDic setObject:[infoDic objectForKey:@"sex"] forKey:@"sex"];
        // 用户头像
        [UserInfoDic setObject:[infoDic objectForKey:@"avatar"] forKey:@"avatar"];
        // 用户类型：4：推广员 5：普通会员
        [UserInfoDic setObject:[infoDic objectForKey:@"user_type"] forKey:@"user_type"];
        
        [UserInfoCache archiveUserInfo:UserInfoDic keyedArchiveName:USER_INFO_CACHE];
        
    } withFailureBlock:^(NSString *errorMessage, int code) {
        
    }];
}





#pragma mark - LazyLoad
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

- (UITextField *)phoneTF{
    if (!_phoneTF) {
        _phoneTF = [[UITextField alloc]init];
        _phoneTF.textColor = HEXACOLOR(0x33435c);
        _phoneTF.font = kFont(15);
        NSAttributedString *attrStr = [[NSAttributedString alloc]initWithString:@"请输入您的手机号" attributes:                                              @{NSForegroundColorAttributeName:HEXACOLOR(0x999999),                                                       NSFontAttributeName:[UIFont systemFontOfSize:11]}];
        _phoneTF.attributedPlaceholder = attrStr;
        _phoneTF.keyboardType = UIKeyboardTypeNumberPad;
        _phoneTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    }
    return _phoneTF;
}

- (UITextField *)pwdTF{
    if (!_pwdTF) {
        _pwdTF = [[UITextField alloc]init];
        _pwdTF.textColor = HEXACOLOR(0x33435c);
        _pwdTF.font = kFont(15);
        NSAttributedString *attrStr = [[NSAttributedString alloc]initWithString:@"请输入密码" attributes:                                              @{NSForegroundColorAttributeName:HEXACOLOR(0x999999),                                                       NSFontAttributeName:[UIFont systemFontOfSize:11]}];
        _pwdTF.attributedPlaceholder = attrStr;
        _pwdTF.clearButtonMode = UITextFieldViewModeWhileEditing;
        _pwdTF.secureTextEntry = YES;
    }
    return _pwdTF;
}

- (UIButton *)sureBtn{
    if (!_sureBtn) {
        _sureBtn = [AppUIKit createBtnWithType:UIButtonTypeCustom
                               backgroundColor:APPMainColor
                                        action:@selector(sureClick)
                                        target:self
                                         title:@"登录"
                                         image:nil
                                          font:14
                                     textColor:HEXACOLOR(0xffffff)];
    }
    return _sureBtn;
}










@end
