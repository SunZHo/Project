//
//  NoticeDetailVC.m
//  QianDouRepay
//
//  Created by <15>帝云科技 on 2018/4/18.
//  Copyright © 2018年 帝云科技<15>. All rights reserved.
//

#import "NoticeDetailVC.h"

@interface NoticeDetailVC ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scroollView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UILabel *companyLabel;
@property (nonatomic, strong) UILabel *timeLabel;


@end

@implementation NoticeDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"公告详情";
    
    [self makeUI];
    
    [self loadData];
    
    
}


- (void)makeUI{
    [self.scroollView sd_addSubviews:@[self.titleLabel, self.contentLabel, self.companyLabel, self.timeLabel]];
    
    [self.scroollView setupAutoContentSizeWithBottomView:self.timeLabel bottomMargin:50];
    
    self.titleLabel.sd_layout.topSpaceToView(self.scroollView, 26).leftEqualToView(self.scroollView).rightEqualToView(self.scroollView).heightIs(15);
    
    self.contentLabel.sd_layout.topSpaceToView(self.titleLabel, 27).leftSpaceToView(self.scroollView, 12).rightSpaceToView(self.scroollView, 12).autoHeightRatio(0);
    self.contentLabel.isAttributedContent = YES;
    
    self.companyLabel.sd_layout.topSpaceToView(self.contentLabel, 40).leftEqualToView(self.contentLabel).rightEqualToView(self.contentLabel).heightIs(12);
    
    self.timeLabel.sd_layout.topSpaceToView(self.companyLabel, 12).leftEqualToView(self.contentLabel).rightEqualToView(self.contentLabel).heightIs(12);
    
    
}


- (void)loadData{
    self.titleLabel.text = @"公告标题";
    self.contentLabel.text = @"    闲暇时，放一只藤椅在花间，闻着花香，晒着太阳，看白云漫卷，听飞鸟和鸣；晨昏忧乐时，手捧一卷书，让眼前直下三千字，让胸次全无一点尘；灵感来袭时，手触键盘，让飞扬的情思，在噼里啪啦的敲打中，释放干净。闲暇时，放一只藤椅在花间，闻着花香，晒着太阳，看白云漫卷，听飞鸟和鸣；晨昏忧乐时，手捧一卷书，让眼前直下三千字，让胸次全无一点尘；灵感来袭时，手触键盘，让飞扬的情思，在噼里啪啦的敲打中，释放干净。闲暇时，放一只藤椅在花间，闻着花香，晒着太阳，看白云漫卷，听飞鸟和鸣；晨昏忧乐时，手捧一卷书，让眼前直下三千字，让胸次全无一点尘；灵感来袭时，手触键盘，让飞扬的情思，在噼里啪啦的敲打中，释放干净。";
    NSMutableAttributedString * attributedString = [[NSMutableAttributedString alloc] initWithString:self.contentLabel.text attributes:nil];
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:5];//行间距
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [self.contentLabel.text length])];
    [self.contentLabel setAttributedText:attributedString];
    
    self.companyLabel.text = @"钱兜代你还";
    self.timeLabel.text = @"2018-03-20  14:32";
    
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



- (UIScrollView *)scroollView
{
    if (!_scroollView) {
        _scroollView = [UIScrollView new];
        _scroollView.delegate = self;
        _scroollView.backgroundColor = WhiteColor;
        [self.view addSubview:_scroollView];
        
        _scroollView.sd_layout.spaceToSuperView(UIEdgeInsetsZero);
    }
    return _scroollView;
}


- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [AppUIKit labelWithTitle:@"" titleFontSize:15 textColor:defaultTextColor backgroundColor:nil alignment:NSTextAlignmentCenter];
    }
    return _titleLabel;
}

- (UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel = [AppUIKit labelWithTitle:@"" titleFontSize:12 textColor:HEXACOLOR(0x666666) backgroundColor:nil alignment:0];
    }
    return _contentLabel;
}

- (UILabel *)companyLabel{
    if (!_companyLabel) {
        _companyLabel = [AppUIKit labelWithTitle:@"" titleFontSize:12 textColor:defaultTextColor backgroundColor:nil alignment:NSTextAlignmentRight];
    }
    return _companyLabel;
}

- (UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel = [AppUIKit labelWithTitle:@"" titleFontSize:12 textColor:defaultTextColor backgroundColor:nil alignment:NSTextAlignmentRight];
    }
    return _timeLabel;
}




@end
