//
//  QRCodeViewController.m
//  QianDouRepay
//
//  Created by <15>帝云科技 on 2018/4/25.
//  Copyright © 2018年 帝云科技<15>. All rights reserved.
//

#import "QRCodeViewController.h"

@interface QRCodeViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scroollView;
@property (nonatomic, strong) UILabel *moneyLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UILabel *moneySubLabel;
@property (nonatomic, strong) UIImageView *QRCodeImage;
@property (nonatomic, strong) UIButton *saveBtn;
@property (nonatomic , copy) NSString *qrCode;

@end

@implementation QRCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = [NSString stringWithFormat:@"%@支付",self.payWay];
    
    [self makeUI];
    
    [self loadData];
    
}



- (void)makeUI{
    [self.scroollView sd_addSubviews:@[self.moneyLabel,self.moneySubLabel,self.QRCodeImage, self.contentLabel, self.saveBtn]];
    
    [self.scroollView setupAutoContentSizeWithBottomView:self.saveBtn bottomMargin:50];
    
    self.moneyLabel.sd_layout.topSpaceToView(self.scroollView, 36).leftEqualToView(self.scroollView).rightEqualToView(self.scroollView).heightIs(25);
    self.moneySubLabel.sd_layout.topSpaceToView(self.moneyLabel, 16).leftEqualToView(self.scroollView).rightEqualToView(self.scroollView).heightIs(12);
    
    self.QRCodeImage.sd_layout.topSpaceToView(self.moneySubLabel, 34).centerXEqualToView(self.scroollView).heightIs(112).widthIs(112);
    
    self.contentLabel.sd_layout.topSpaceToView(self.QRCodeImage, 60).leftSpaceToView(self.scroollView, 12).rightSpaceToView(self.scroollView, 12).autoHeightRatio(0);
    
    self.contentLabel.isAttributedContent = YES;
    
    self.saveBtn.sd_layout.topSpaceToView(self.contentLabel, 40).leftSpaceToView(self.scroollView, 12).rightSpaceToView(self.scroollView, 12).heightIs(44);
    
    
}


- (void)loadData{
    self.moneyLabel.text = self.money;
    self.moneyLabel.attributedText = [AppCommon getRange:NSMakeRange(@"￥".length, self.money.length) labelStr:[NSString stringWithFormat:@"￥%@",self.money] Font:kFont(30) Color:HEXACOLOR(0xff5c5c)];
    self.contentLabel.text = [NSString stringWithFormat:@"支付二维码已生成。有效期为十分钟，请自行保存相册。\n支付成功后大概有一分钟的延迟，请耐心等待。\n请用手机打开“%@”的扫一扫功能，然后点击相册选择二维码支付。",self.payWay];
    NSMutableAttributedString * attributedString = [[NSMutableAttributedString alloc] initWithString:self.contentLabel.text attributes:nil];
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:5];//行间距
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [self.contentLabel.text length])];
    [self.contentLabel setAttributedText:attributedString];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if ([self.payWay isEqualToString:@"支付宝"]) {
        [dic setValue:@"0401" forKey:@"type"];
    }else{
        [dic setValue:@"0402" forKey:@"type"];
    }
    [dic setValue:UserID forKey:@"userid"];
    [self showLoading];
    [AppNetworking requestWithType:HttpRequestTypePost withUrlString:home_VipQRcodeUrl withParaments:dic withSuccessBlock:^(id json) {
        NSDictionary *infoDic = [json objectForKey:@"info"];
        self.qrCode = [infoDic objectForKey:@"qrCode"];
        [self.QRCodeImage sd_setImageWithURL:[NSURL URLWithString:self.qrCode]];
        
    } withFailureBlock:^(NSString *errorMessage, int code) {
//        self.qrCode = @"http://47.93.176.32:8234/Uploads/banner/5adde33922742.jpg";
//        [self.QRCodeImage sd_setImageWithURL:[NSURL URLWithString:self.qrCode]];
    }];
    
}





- (void)saveCommit{
    [self saveImage];
}

- (void)saveImage
{
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.qrCode]]];
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
    [self showText:@"正在保存"];
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo;
{
    if (error) {
        [self showErrorText:@"保存失败"];
    }else {
        [self showSuccessText:@"保存成功"];
    }
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    // 由于scrollview在滚动时会不断调用layoutSubvies方法，这就会不断触发自动布局计算，而很多时候这种计算是不必要的，所以可以通过控制“sd_closeAutoLayout”属性来设置要不要触发自动布局计算
    self.scroollView.sd_closeAutoLayout = YES;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    // 由于scrollview在滚动时会不断调用layoutSubvies方法，这就会不断触发自动布局计算，而很多时候这种计算是不必要的，所以可以通过控制“sd_closeAutoLayout”属性来设置要不要触发自动布局计算
    self.scroollView.sd_closeAutoLayout = NO;
}

#pragma mark - lazyLoad

- (UIScrollView *)scroollView
{
    if (!_scroollView) {
        _scroollView = [UIScrollView new];
        _scroollView.delegate = self;
        _scroollView.backgroundColor = WhiteColor;
        [self.view addSubview:_scroollView];
        
        _scroollView.sd_layout.topSpaceToView(self.view, 64+SafeAreaTopHeight).leftEqualToView(self.view).rightEqualToView(self.view).bottomEqualToView(self.view);
    }
    return _scroollView;
}


- (UILabel *)moneyLabel{
    if (!_moneyLabel) {
        _moneyLabel = [AppUIKit labelWithTitle:@"￥198" titleFontSize:15 textColor:HEXACOLOR(0xff5c5c) backgroundColor:nil alignment:NSTextAlignmentCenter];
    }
    return _moneyLabel;
}

- (UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel = [AppUIKit labelWithTitle:@"" titleFontSize:12 textColor:defaultTextColor backgroundColor:nil alignment:0];
    }
    return _contentLabel;
}

- (UILabel *)moneySubLabel{
    if (!_moneySubLabel) {
        _moneySubLabel = [AppUIKit labelWithTitle:@"升级VIP支付金额" titleFontSize:12 textColor:HEXACOLOR(0x666666) backgroundColor:nil alignment:NSTextAlignmentCenter];
    }
    return _moneySubLabel;
}

- (UIImageView *)QRCodeImage{
    if (!_QRCodeImage) {
        _QRCodeImage = [[UIImageView alloc]init];
//        _QRCodeImage.image = IMG(@"wx");
    }
    return _QRCodeImage;
}

- (UIButton *)saveBtn{
    if (!_saveBtn) {
        _saveBtn = [AppUIKit createBtnWithType:UIButtonTypeCustom backgroundColor:APPMainColor action:@selector(saveCommit) target:self title:@"保存到相册" image:nil font:15 textColor:HEXACOLOR(0x1e2674)];
        _saveBtn.layer.cornerRadius = 5;
    }
    return _saveBtn;
}










@end
