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
//@property (nonatomic, strong) UILabel *companyLabel;
@property (nonatomic, strong) UILabel *timeLabel;


@end

@implementation NoticeDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.isNoti) {
        self.title = @"公告详情";
    }else{
        self.title = @"消息详情";
    }
    
    [self makeUI];
    
    [self loadData];
    
    
}


- (void)makeUI{
//    [self.scroollView sd_addSubviews:@[self.titleLabel, self.contentLabel, self.companyLabel, self.timeLabel]];
    [self.scroollView sd_addSubviews:@[self.titleLabel, self.timeLabel, self.contentLabel]];
    
    [self.scroollView setupAutoContentSizeWithBottomView:self.contentLabel bottomMargin:50];
    
    self.titleLabel.sd_layout.topSpaceToView(self.scroollView, 26).leftEqualToView(self.scroollView).rightEqualToView(self.scroollView).heightIs(15);
    
    self.timeLabel.sd_layout.topSpaceToView(self.titleLabel, 12).leftEqualToView(self.titleLabel).rightSpaceToView(self.scroollView, 12).heightIs(12);
    
    self.contentLabel.sd_layout.topSpaceToView(self.timeLabel, 27).leftSpaceToView(self.scroollView, 12).rightSpaceToView(self.scroollView, 12).autoHeightRatio(0);
    self.contentLabel.isAttributedContent = YES;
    
//    self.companyLabel.sd_layout.topSpaceToView(self.contentLabel, 40).leftEqualToView(self.contentLabel).rightSpaceToView(self.scroollView, 12).heightIs(12);
    
    
    
    
}


- (void)loadData{    
    NSDictionary *dic = @{@"id" : self.notiID};
    NSString *url = @"";
    if (self.isNoti) {
        url = my_newsDetailInfo;
    }else{
        url = my_MessageDetail;
    }
    [AppNetworking requestWithType:HttpRequestTypePost withUrlString:url withParaments:dic withSuccessBlock:^(id json) {
        NSDictionary *infoDic = [json objectForKey:@"info"];
        self.titleLabel.text = [infoDic objectForKey:@"title"];
        self.contentLabel.text = [NSString stringWithFormat:@"    %@",[AppCommon flattenHTML:[infoDic objectForKey:@"content"] trimWhiteSpace:YES]];
        NSMutableAttributedString * attributedString = [[NSMutableAttributedString alloc] initWithString:self.contentLabel.text attributes:nil];
        NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:5];//行间距
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [self.contentLabel.text length])];
        [self.contentLabel setAttributedText:attributedString];
        
        self.timeLabel.text = [NSDate timeStringFromTimestamp:[[infoDic objectForKey:@"time"] integerValue]formatter:@"yyyy-MM-dd HH:mm"];
        
    } withFailureBlock:^(NSString *errorMessage, int code) {
        
    }];

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
        
        _scroollView.sd_layout.topSpaceToView(self.view, 64+SafeAreaTopHeight).leftEqualToView(self.view).rightEqualToView(self.view).bottomEqualToView(self.view);
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

- (UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel = [AppUIKit labelWithTitle:@"" titleFontSize:12 textColor:defaultTextColor backgroundColor:nil alignment:NSTextAlignmentRight];
    }
    return _timeLabel;
}




@end
