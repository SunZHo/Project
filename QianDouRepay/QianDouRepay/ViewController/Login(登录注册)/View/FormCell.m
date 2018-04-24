//
//  FormCell.m
//  QianDouRepay
//
//  Created by <15>帝云科技 on 2018/4/9.
//  Copyright © 2018年 帝云科技<15>. All rights reserved.
//

#import "FormCell.h"
#import "OYCountDownManager.h"

@interface FormCell()<UITextFieldDelegate>

// ui
@property (strong , nonatomic) UIImageView *img;
@property (strong , nonatomic) UILabel *titleLabel;
@property (strong , nonatomic) UITextField *field;
@property (nonatomic , strong) UIView *lineV;
@property (nonatomic , strong) UIButton *countDownBtn;
@property (nonatomic , assign) BOOL hasCountDown;


@end


@implementation FormCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _field = [[UITextField alloc] init];
        _field.font = kFont(14);
        _field.delegate = self;
        [self.contentView addSubview:_field];
        _lineV = [[UIView alloc]init];
        _lineV.backgroundColor = HEXACOLOR(0xdddddd);
        [self.contentView addSubview:_lineV];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldChanged:) name:UITextFieldTextDidChangeNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(countDownNoti) name:OYCountDownNotification object:nil];
    }
    return self;
}

- (void)setFormcellModel:(FormCellModel *)formcellModel{
    _formcellModel = formcellModel;
    _field.secureTextEntry = formcellModel.isSecureText;
    _field.text = formcellModel.text;
    _field.keyboardType = formcellModel.boardType;
    NSAttributedString *attrStr = [[NSAttributedString alloc]initWithString:formcellModel.placeHolder attributes:                                              @{NSForegroundColorAttributeName:HEXACOLOR(0x999999),                                                       NSFontAttributeName:[UIFont systemFontOfSize:11]
        }];
    _field.attributedPlaceholder = attrStr;
    _field.userInteractionEnabled = formcellModel.canEdit;
    _field.clearButtonMode = UITextFieldViewModeWhileEditing;
    for (UIView *view in self.contentView.subviews) {
        if (![view isKindOfClass:[UITextField class]]) {
            [view removeFromSuperview];
        }
    }
    if (formcellModel.cellType == cellTypeTitle_FieldType) {
        UILabel *titleLabel = [AppUIKit labelWithTitle:formcellModel.title titleFontSize:15 textColor:defaultTextColor backgroundColor:nil alignment:0];
        [self.contentView addSubview:titleLabel];
        titleLabel.sd_layout.leftSpaceToView(self.contentView, 12).widthIs(80).heightIs(40).centerYEqualToView(self.contentView);
        
        _field.sd_layout.leftSpaceToView(titleLabel, 20).rightSpaceToView(self.contentView, 10).heightIs(40).centerYEqualToView(self.contentView);
        _lineV.sd_layout.leftEqualToView(titleLabel)
        .rightEqualToView(self.contentView)
        .bottomEqualToView(self.contentView)
        .heightIs(1);
        
    }else if (formcellModel.cellType == cellTypeIcon_FieldType){
        UIImageView *iconImg = [[UIImageView alloc]initWithImage:IMG(formcellModel.imageName)];
//        iconImg.backgroundColor = HEXACOLOR(0xf34311);
        iconImg.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:iconImg];
        iconImg.sd_layout.leftSpaceToView(self.contentView, 6).widthIs(17).heightIs(17).centerYEqualToView(self.contentView);
        _field.sd_layout.leftSpaceToView(iconImg, 20).rightSpaceToView(self.contentView, 10).heightIs(40).centerYEqualToView(self.contentView);
        _lineV.sd_layout.leftEqualToView(iconImg)
        .rightEqualToView(self.contentView)
        .bottomEqualToView(self.contentView)
        .heightIs(1);
    }else if (formcellModel.cellType == cellTypeIcon_FieldVeirfyCodeType){
        UIImageView *iconImg = [[UIImageView alloc]initWithImage:IMG(formcellModel.imageName)];
        [self.contentView addSubview:iconImg];
        
        UIView *linev = [[UIView alloc]init];
        linev.backgroundColor = HEXACOLOR(0x5cb7ff);
        [self.contentView addSubview:linev];
        
        self.countDownBtn = [AppUIKit createBtnWithType:UIButtonTypeCustom backgroundColor:nil action:@selector(countDownClick) target:self title:@"获取验证码" image:nil font:12 textColor:HEXACOLOR(0x5cb7ff)];
        [self.contentView addSubview:self.countDownBtn];
        
        iconImg.sd_layout.leftSpaceToView(self.contentView, 6).widthIs(17).heightIs(17).centerYEqualToView(self.contentView);
        _field.sd_layout.leftSpaceToView(iconImg, 20).rightSpaceToView(self.contentView, 80).heightIs(40).centerYEqualToView(self.contentView);
        
        linev.sd_layout.leftSpaceToView(_field, 0).centerYEqualToView(_field).heightIs(10).widthIs(1);
        self.countDownBtn.sd_layout.rightSpaceToView(self.contentView, 0).heightIs(13).centerYEqualToView(_field).leftSpaceToView(linev, 14);
        
        _lineV.sd_layout.leftEqualToView(iconImg)
        .rightEqualToView(self.contentView)
        .bottomEqualToView(self.contentView)
        .heightIs(1);
        
    }else if (formcellModel.cellType == cellTypeTitle_FieldSelection){
        UILabel *titleLabel = [AppUIKit labelWithTitle:formcellModel.title titleFontSize:15 textColor:defaultTextColor backgroundColor:nil alignment:0];
        [self.contentView addSubview:titleLabel];
        titleLabel.sd_layout.leftSpaceToView(self.contentView, 12).widthIs(80).heightIs(40).centerYEqualToView(self.contentView);
        
        _field.sd_layout.leftSpaceToView(titleLabel, 20).rightSpaceToView(self.contentView, 10).heightIs(40).centerYEqualToView(self.contentView);
        _lineV.sd_layout.leftEqualToView(titleLabel)
        .rightEqualToView(self.contentView)
        .bottomEqualToView(self.contentView)
        .heightIs(1);
        UIImageView *iv = [[UIImageView alloc]initWithImage:IMG(@"hjtou_Down")];
        [self.contentView addSubview:iv];
        iv.sd_layout.rightSpaceToView(self.contentView, 13).centerYEqualToView(self.contentView).widthIs(9).heightIs(5);
        
    }else if (formcellModel.cellType == cellTypeTitle_FieldVeirfyCodeType){
        
        UILabel *titleLabel = [AppUIKit labelWithTitle:formcellModel.title titleFontSize:15 textColor:defaultTextColor backgroundColor:nil alignment:0];
        [self.contentView addSubview:titleLabel];
        titleLabel.sd_layout.leftSpaceToView(self.contentView, 12).widthIs(80).heightIs(40).centerYEqualToView(self.contentView);
        
        self.countDownBtn = [AppUIKit createBtnWithType:UIButtonTypeCustom backgroundColor:nil action:@selector(countDownClick) target:self title:@"获取验证码" image:nil font:11 textColor:HEXACOLOR(0xe60012)];
        self.countDownBtn.layer.borderWidth = 0.5;
        self.countDownBtn.layer.borderColor = HEXACOLOR(0xe60012).CGColor;
        self.countDownBtn.layer.cornerRadius = 5;
        
        [self.contentView addSubview:self.countDownBtn];
        
        _field.sd_layout.leftSpaceToView(titleLabel, 20).rightSpaceToView(self.contentView, 100).heightIs(40).centerYEqualToView(self.contentView);
        
        self.countDownBtn.sd_layout.rightSpaceToView(self.contentView, 12).heightIs(24).centerYEqualToView(_field).widthIs(75);
        
        _lineV.sd_layout.leftEqualToView(titleLabel)
        .rightEqualToView(self.contentView)
        .bottomEqualToView(self.contentView)
        .heightIs(1);
        
        [self countDownNoti];
    }else if (formcellModel.cellType == cellTypeSectionHeaderType){
        UILabel *titleLabel = [AppUIKit labelWithTitle:[NSString stringWithFormat:@"   %@",formcellModel.title] titleFontSize:15 textColor:defaultTextColor backgroundColor:Default_BackgroundGray alignment:0];
        [self.contentView addSubview:titleLabel];
        titleLabel.sd_layout.leftSpaceToView(self.contentView, 0).widthIs(SCREEN_WIDTH).heightRatioToView(self.contentView, 1).centerYEqualToView(self.contentView);
        
    }
    [self.contentView layoutSubviews];
}

- (void)countDownClick{
    kCountDownManager.timeInterval = 60;
    [kCountDownManager start];
    self.hasCountDown = YES;
    
//    [AppUIKit countingDownWithButton:self.countDownBtn];
    
}


#pragma mark UITextFieldDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField{
    [textField resignFirstResponder];
    if (textField.text.length) {
        !self.cellTextFieldBlock ?: self.cellTextFieldBlock(textField.text);
    }
}

#pragma mark - Notification
- (void)textFieldChanged:(NSNotification *)noti{
    !self.cellTextFieldBlock ?: self.cellTextFieldBlock(_field.text);
}

- (void)countDownNoti{
    /// 计算倒计时
    if (!self.hasCountDown) {
        return;
    }
    NSInteger timeInterval;
//    if (model.countDownSource) {
//        timeInterval = [kCountDownManager timeIntervalWithIdentifier:model.countDownSource];
//    }else {
//
//    }
    timeInterval = kCountDownManager.timeInterval;
    NSInteger countDown = 120 - timeInterval;
    /// 当倒计时到了进行回调
    if (countDown <= 0) {
//        self.detailTextLabel.text = @"活动开始";
        [self.countDownBtn setTitle:@"重新发送" forState:UIControlStateNormal];
        self.countDownBtn.userInteractionEnabled = YES;
//        // 回调给控制器
//        if (self.countDownZero) {
//            self.countDownZero(model);
//        }
        return;
    }
    [self.countDownBtn setTitle:[NSString stringWithFormat:@"%.2ld秒",countDown%60] forState:UIControlStateNormal];
    self.countDownBtn.userInteractionEnabled = NO;
    
}

- (void)dealloc{
    // 废除定时器
    [kCountDownManager invalidate];
    // 清空时间差
    [kCountDownManager reload];
}




@end
