//
//  SetNickNameVC.m
//  QianDouRepay
//
//  Created by <15>帝云科技 on 2018/4/10.
//  Copyright © 2018年 帝云科技<15>. All rights reserved.
//

#import "SetNickNameVC.h"

@interface SetNickNameVC ()

@property (nonatomic , strong) UILabel *namelabel;
@property (nonatomic , strong) UITextField *nameTF;
@property (nonatomic , strong) UIView *lineV;
@property (nonatomic , strong) UIButton *sureBtn;

@end

@implementation SetNickNameVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"昵称";
    self.view.backgroundColor = HEXACOLOR(0xffffff);
    [self.view addSubview:self.namelabel];
    [self.view addSubview:self.nameTF];
    [self.view addSubview:self.lineV];
    [self.view addSubview:self.sureBtn];
    
    self.namelabel.sd_layout.topSpaceToView(self.view, 64 + SafeAreaTopHeight).leftSpaceToView(self.view, 13).widthIs(40).heightIs(50);
    self.nameTF.sd_layout.topEqualToView(self.namelabel).leftSpaceToView(self.namelabel, 44).rightSpaceToView(self.view, 16).heightIs(50);
    self.lineV.sd_layout.topSpaceToView(self.nameTF, 1).leftEqualToView(self.namelabel).rightEqualToView(self.nameTF).heightIs(1);
    
    self.sureBtn.sd_layout.topSpaceToView(self.lineV,kScaleWidth(100)).leftSpaceToView(self.view, 12).rightSpaceToView(self.view, 12).heightIs(44);
    self.sureBtn.sd_cornerRadius = @5;
}

- (void)sureClick{
    if ([self.nameTF.text isEqualToString:@""]) {
        [self showErrorText:@"请输入姓名"];
        return;
    }
    NSDictionary *dic = @{@"userid" : UserID,
                          @"nickname" : self.nameTF.text
                          };
    [AppNetworking requestWithType:HttpRequestTypePost withUrlString:my_setNickname withParaments:dic withSuccessBlock:^(id json) {
        [self showSuccessText:@"设置昵称成功"];
        [UserInfoDic setObject:self.nameTF.text forKey:@"nickname"];
        [UserInfoCache archiveUserInfo:UserInfoDic keyedArchiveName:USER_INFO_CACHE];
        if (self.nickNameBlock) {
            self.nickNameBlock(self.nameTF.text);
        }
        POPVC;
    } withFailureBlock:^(NSString *errorMessage, int code) {
        
    }];
    
}


- (UILabel *)namelabel{
    if (!_namelabel) {
        _namelabel = [[UILabel alloc]init];
        _namelabel.font = [UIFont systemFontOfSize:15];
        _namelabel.textColor = defaultTextColor;
        _namelabel.text = @"昵称";
    }
    return _namelabel;
}

- (UITextField *)nameTF{
    if (!_nameTF) {
        _nameTF = [[UITextField alloc]init];
        _nameTF.textColor = HEXACOLOR(0x33435c);
        _nameTF.font = kFont(15);
        _nameTF.placeholder = @"请输入您的昵称";
        _nameTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    }
    return _nameTF;
}

- (UIView *)lineV{
    if (!_lineV) {
        _lineV = [[UIView alloc]init];
        _lineV.backgroundColor = HEXACOLOR(0xdddddd);
    }
    return _lineV;
}

- (UIButton *)sureBtn{
    if (!_sureBtn) {
        _sureBtn = [AppUIKit createBtnWithType:UIButtonTypeCustom
                               backgroundColor:APPMainColor
                                        action:@selector(sureClick)
                                        target:self
                                         title:@"确定"
                                         image:nil
                                          font:14
                                     textColor:HEXACOLOR(0xffffff)];
    }
    return _sureBtn;
}

@end
