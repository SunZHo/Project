//
//  UploadPicViewController.m
//  QianDouRepay
//
//  Created by <15>帝云科技 on 2018/4/18.
//  Copyright © 2018年 帝云科技<15>. All rights reserved.
//

#import "UploadPicViewController.h"

@interface UploadPicViewController ()

@property (nonatomic , strong) UIScrollView *backGroundScrollV;
@property (nonatomic , strong) UILabel *titleLabel;
@property (nonatomic , strong) UIButton *nextBtn;

@end

@implementation UploadPicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"实名认证";
    self.view.backgroundColor = Default_BackgroundGray;
    
    [self makeUI];
}


- (void)makeUI{
    [self.view addSubview:self.backGroundScrollV];
    [self.backGroundScrollV addSubview:self.titleLabel];
    self.titleLabel.sd_layout.topSpaceToView(self.backGroundScrollV, 22).leftSpaceToView(self.backGroundScrollV, 13).widthIs(120)
    .heightIs(15);
    
    NSArray *titleArr = @[@"身份证证件（正面）",@"身份证证件（反面）",@"手持身份证（正面）",@"信用卡照片（正面）"];
    
    NSInteger columnNum = 2;
    
    CGFloat btnW = SCREEN_WIDTH / 2;
    CGFloat btnH = 157;
    CGFloat margin = (SCREEN_WIDTH - columnNum * btnW) / (columnNum + 1);
    
    for (int i = 0; i < titleArr.count; i ++) {
        int row = i/columnNum;//行号
        //     1/3=0,  2/3=0,  3/3=1;
        int loc = i%columnNum;//列号
        CGFloat btnX = margin + (margin + btnW) * loc;
        CGFloat btnY = margin + (margin + btnH) * row + 50;
        UIButton *bottomView = [[UIButton alloc]initWithFrame:CGRectMake(btnX, btnY, btnW, btnH)];
        bottomView.tag = 10 + i;
        [bottomView addTarget:self action:@selector(functionClick:) forControlEvents:UIControlEventTouchUpInside];
        UIImageView *iv = [[UIImageView alloc]init];
        iv.image = IMG(@"tij");
        iv.tag = 100 + i;
        [bottomView addSubview:iv];
        
        iv.sd_layout.topSpaceToView(bottomView, 20).centerXEqualToView(bottomView).widthIs(138).heightIs(98);
        
        UILabel *label = [[UILabel alloc]init];
        label.text = titleArr[i];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = HEXACOLOR(0x424242);
        label.font = kFont(12);
        [bottomView addSubview:label];
        
        label.sd_layout.topSpaceToView(iv, 13).widthIs(btnW).leftEqualToView(bottomView).heightIs(12);
        
        [self.backGroundScrollV addSubview:bottomView];
    }
    
    [self.backGroundScrollV addSubview:self.nextBtn];
    self.nextBtn.sd_layout.topSpaceToView(self.backGroundScrollV, 400).leftSpaceToView(self.backGroundScrollV, 12).rightSpaceToView(self.backGroundScrollV, 12).heightIs(44);
    UILabel *label = [AppUIKit labelWithTitle:@"注：上传的银行卡只能为信用卡，绑定后不可随意更改。" titleFontSize:12 textColor:HEXACOLOR(0xf68029) backgroundColor:nil alignment:0];
    [self.backGroundScrollV addSubview:label];
    
    label.sd_layout.topSpaceToView(self.nextBtn, 20).leftSpaceToView(self.backGroundScrollV, 12).rightSpaceToView(self.backGroundScrollV, 12).autoHeightRatio(0);
}



- (void)nextClick{
    
}


- (void)functionClick:(UIButton *)sender{
    NSInteger tag = sender.tag - 10;
    [BDImagePicker showImagePickerFromViewController:self allowsEditing:YES finishAction:^(UIImage *image) {
        if (image) {
            UIImageView *imageView = [self.view viewWithTag:tag + 100];
            imageView.image = image;
        }
    }];
}


#pragma mark - LazyLoad

- (UIScrollView *)backGroundScrollV{
    if (!_backGroundScrollV) {
        _backGroundScrollV = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64 + SafeAreaTopHeight, SCREEN_WIDTH, SCREEN_HEIGHT - (64 + SafeAreaTopHeight))];
        _backGroundScrollV.backgroundColor = WhiteColor;
        _backGroundScrollV.contentSize = CGSizeMake(SCREEN_WIDTH, 603);
        _backGroundScrollV.showsVerticalScrollIndicator = NO;
        _backGroundScrollV.showsHorizontalScrollIndicator = NO;
        
    }
    return _backGroundScrollV;
}


- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [AppUIKit labelWithTitle:@"上传证件照片" titleFontSize:15 textColor:defaultTextColor backgroundColor:nil alignment:0];
    }
    return _titleLabel;
}

- (UIButton *)nextBtn{
    if (!_nextBtn) {
        _nextBtn = [AppUIKit createBtnWithType:UIButtonTypeCustom backgroundColor:APPMainColor action:@selector(nextClick) target:self title:@"下一步" image:nil font:15 textColor:HEXACOLOR(0x1e2674)];
        _nextBtn.layer.cornerRadius = 5;
    }
    return _nextBtn;
}








@end
