//
//  AuthorizedView.m
//  QianDouRepay
//
//  Created by <15>帝云科技 on 2018/5/17.
//  Copyright © 2018年 帝云科技<15>. All rights reserved.
//

#import "AuthorizedView.h"

@interface AuthorizedView ()<UITextFieldDelegate>

@property (nonatomic , strong) UIView *backView;
@property (nonatomic , strong) UITextField *codeTF;
@property (nonatomic , strong) UIButton *countBtn;
@property (nonatomic , strong) CreditCardModel *creditModel;
/** 绑卡申请流水号 */
@property (nonatomic , copy) NSString *bind_apply_code;

@end

@implementation AuthorizedView

- (instancetype)initWithFrame:(CGRect)frame andModel:(CreditCardModel *)creModel;
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = [UIScreen mainScreen].bounds;
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.3f];
        self.creditModel = creModel;
        [self makeUI];
        
        
    }
    
    return self;
}


- (void)makeUI{
    self.backView = [[UIView alloc]init];
    self.backView.backgroundColor = [UIColor whiteColor];
    self.backView.layer.cornerRadius = 5;
    self.backView.clipsToBounds = YES;
    [self addSubview:self.backView];
    self.backView.sd_layout.centerXEqualToView(self)
    .centerYEqualToView(self).widthIs(240).heightIs(300);
    
    UILabel *titleL = [AppUIKit labelWithTitle:@"短信授权" titleFontSize:16 textColor:defaultTextColor backgroundColor:nil alignment:NSTextAlignmentCenter];
    
    UIView *lineV = [[UIView alloc]init];
    lineV.backgroundColor = Default_BackgroundGray;
    
    UILabel *descL = [AppUIKit labelWithTitle:@"授权之后方可使用，如不授权则无法进行下一步操作" titleFontSize:14 textColor:HEXACOLOR(0x666666) backgroundColor:nil alignment:0];
    descL.numberOfLines = 0;
    
    UILabel *phoneL = [AppUIKit labelWithTitle:self.creditModel.phone titleFontSize:14 textColor:defaultTextColor backgroundColor:nil alignment:0];
    
    UIView *phonelineV = [[UIView alloc]init];
    phonelineV.backgroundColor = Default_BackgroundGray;
    
    UIView *jianGV = [[UIView alloc]init];
    jianGV.backgroundColor = HEXACOLOR(0x5cb7ff);
    
    self.countBtn = [AppUIKit createBtnWithType:UIButtonTypeCustom backgroundColor:nil action:@selector(countDownClick) target:self title:@"获取验证码" image:nil font:12 textColor:HEXACOLOR(0x5cb7ff)];
    
    UIView *codeLineV = [[UIView alloc]init];
    codeLineV.backgroundColor = Default_BackgroundGray;
    
    UIButton *cancleBtn = [AppUIKit createBtnWithType:UIButtonTypeCustom backgroundColor:nil action:@selector(dismissSelf) target:self title:@"取消" image:nil font:13 textColor:HEXACOLOR(0x666666)];
    cancleBtn.layer.borderWidth = 0.5;
    cancleBtn.layer.borderColor = HEXACOLOR(0x666666).CGColor;
    cancleBtn.layer.cornerRadius = 5;
    
    UIButton *sureBtn = [AppUIKit createBtnWithType:UIButtonTypeCustom backgroundColor:nil action:@selector(sureClick) target:self title:@"确定" image:nil font:13 textColor:HEXACOLOR(0x5cb7ff)];
    sureBtn.layer.borderWidth = 0.5;
    sureBtn.layer.borderColor = HEXACOLOR(0x5cb7ff).CGColor;
    sureBtn.layer.cornerRadius = 5;
    
    [self.backView sd_addSubviews:@[titleL,
                                    lineV,
                                    descL,
                                    phoneL,phonelineV,self.codeTF,jianGV,self.countBtn,codeLineV,cancleBtn,sureBtn]];
    
    titleL.sd_layout.topSpaceToView(self.backView, 30).leftEqualToView(self.backView).rightEqualToView(self.backView).heightIs(18);
    
    lineV.sd_layout.topSpaceToView(titleL, 10).leftEqualToView(self.backView).rightEqualToView(self.backView).heightIs(1);
    
    descL.sd_layout.topSpaceToView(lineV, 10).leftSpaceToView(self.backView, 10).rightSpaceToView(self.backView, 10).heightIs(50);
    
    phoneL.sd_layout.topSpaceToView(descL, 20).leftSpaceToView(self.backView, 10).rightSpaceToView(self.backView, 10).heightIs(20);
    
    phonelineV.sd_layout.topSpaceToView(phoneL, 10).leftEqualToView(phoneL).rightEqualToView(phoneL).heightIs(1);
    
    self.codeTF.sd_layout.topSpaceToView(phonelineV, 20).leftEqualToView(phoneL).rightSpaceToView(self.backView, 80).heightIs(20);
    
    jianGV.sd_layout.centerYEqualToView(self.codeTF).leftSpaceToView(self.codeTF, 1).heightIs(18).widthIs(1);
    
    self.countBtn.sd_layout.centerYEqualToView(self.codeTF).rightSpaceToView(self.backView, 0).heightIs(18).leftSpaceToView(jianGV, 0);
    
    codeLineV.sd_layout.topSpaceToView(self.codeTF, 10).leftEqualToView(phoneL).rightEqualToView(phoneL).heightIs(1);
    
    cancleBtn.sd_layout.topSpaceToView(codeLineV, 20).leftSpaceToView(self.backView,15).widthIs(80).heightIs(40);
    sureBtn.sd_layout.topSpaceToView(codeLineV, 20).rightSpaceToView(self.backView,15).widthIs(80).heightIs(40);
}




- (void)sureClick{
    if ([self.codeTF.text isEqualToString:@""]) {
        [self showErrorText:@"请输入验证码"];
        return;
    }
    NSDictionary *dic = @{@"userid":UserID,
                          @"cardid":self.creditModel.ID,
                          @"bind_apply_code":self.bind_apply_code,
                          @"sms_code":self.codeTF.text
                          };
    MJWeakSelf;
    [self showText:@"正在授权"];
    [AppNetworking requestWithType:HttpRequestTypePost withUrlString:creditcard_BindCommit withParaments:dic withSuccessBlock:^(id json) {
        [weakSelf showSuccessText:@"授权成功"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (weakSelf.AuthorizedBlock) {
                weakSelf.AuthorizedBlock();
            }
            [weakSelf dismissSelf];
        });
        
    } withFailureBlock:^(NSString *errorMessage, int code) {
        
    }];
}



- (void)countDownClick{
    NSDictionary *dic = @{@"userid":UserID,
                          @"cardid":self.creditModel.ID
                          };
    MJWeakSelf;
    [self showLoading];
    [AppNetworking requestWithType:HttpRequestTypePost withUrlString:creditcard_BindSMS withParaments:dic withSuccessBlock:^(id json) {
        [weakSelf dismissLoading];
        NSDictionary *infoDic = [json objectForKey:@"info"];
        weakSelf.bind_apply_code = [infoDic objectForKey:@"bind_apply_code"];
        [weakSelf startCountDown];
    } withFailureBlock:^(NSString *errorMessage, int code) {
        
    }];
}


- (void)startCountDown
{
    __block int timeout=59;
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(timer, ^{
        if (timeout <= 0)
        {
            dispatch_source_cancel(timer);
            self.countBtn.enabled = YES;
            [self.countBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
            timeout = 59;
        }
        else
        {
            timeout -- ;
            self.countBtn.enabled = NO;
            NSString * str = [NSString stringWithFormat:@"%d秒重新获取",timeout + 1];
            [self.countBtn setTitle:str forState:UIControlStateNormal];
        }
    });
    dispatch_resume(timer);
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    [UIView animateWithDuration:0.3 animations:^{
        self.backView.sd_layout.centerXEqualToView(self)
        .topSpaceToView(self, (SCREEN_HEIGHT - 300)/2 - 40).widthIs(240).heightIs(300);
        [self.backView layoutSubviews];
        [self layoutSubviews];
    }];
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    [UIView animateWithDuration:0.3 animations:^{
        self.backView.sd_layout.centerXEqualToView(self)
        .topSpaceToView(self, (SCREEN_HEIGHT - 300)/2).widthIs(240).heightIs(300);
        [self.backView layoutSubviews];
        [self layoutSubviews];
    }];
}


- (void)show {
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:self];
    self.backView.transform = CGAffineTransformMakeScale(1.21f, 1.21f);
    self.backView.alpha = 0;
    [UIView animateWithDuration:.7f delay:0.f usingSpringWithDamping:.7f initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.backView.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
        self.backView.alpha = 1.0;
    } completion:nil];
}

- (void)dismissSelf{
    [UIView animateWithDuration:0.3f animations:^{
        self.backView.alpha = 0;
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        [[NSNotificationCenter defaultCenter]removeObserver:self];
    }];
}




- (UITextField *)codeTF{
    if (!_codeTF) {
        _codeTF = [[UITextField alloc]init];
        _codeTF.textColor = HEXACOLOR(0x333333);
        _codeTF.placeholder = @"请输入验证码";
        _codeTF.font = kFont(14);
        _codeTF.delegate = self;
        _codeTF.keyboardType = UIKeyboardTypeNumberPad;
    }
    
    return _codeTF;
}

@end
