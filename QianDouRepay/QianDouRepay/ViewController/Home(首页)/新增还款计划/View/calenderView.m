//
//  calenderView.m
//  Jshare
//
//  Created by <15>帝云科技 on 2018/4/8.
//  Copyright © 2018年 帝云科技<15>. All rights reserved.
//

#import "calenderView.h"
#import "CalendarCell.h"

@interface calenderView ()<FSCalendarDelegate,FSCalendarDataSource,FSCalendarDelegateAppearance>

@property (nonatomic , strong) UIView *backView;
@property (nonatomic, strong) UIButton *preBtn;
@property (nonatomic, strong) UIButton *nextBtn;
@property (nonatomic, strong) UILabel *topLabel;
@property (nonatomic, strong) UIView  *topline;
@property (nonatomic, strong) NSDateFormatter *dateFormatter;

@property (nonatomic, strong) FSCalendar *calendar;

@property (strong, nonatomic) NSCalendar *gregorian;
@property (nonatomic , copy) NSArray *dataArray;
@property (nonatomic , strong) NSMutableArray *selectDateArr;

@property (nonatomic , strong) NSString *selectDate;

@end

@implementation calenderView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        self.frame = [UIScreen mainScreen].bounds;
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.3f];
        [self layoutSubview];
        self.dataArray = @[@"2018-04-01"];
    }
    return self;
}

-(void)layoutSubview{
    
    /**  */
    self.gregorian = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    self.backView = [[UIView alloc]init];
    self.backView.backgroundColor = [UIColor whiteColor];
    self.backView.layer.cornerRadius = 5;
    self.backView.clipsToBounds = YES;
    [self addSubview:self.backView];
    
    
    self.backView.sd_layout.centerXEqualToView(self).centerYEqualToView(self).widthIs(kScaleWidth(345)).heightIs(kScaleWidth(400));
    
    _preBtn = [AppUIKit createBtnWithType:UIButtonTypeCustom backgroundColor:nil action:@selector(preAction:) target:self title:nil image:@"zuo" font:0 textColor:nil];
    [self.backView addSubview:_preBtn];
    
    _topLabel = [AppUIKit labelWithTitle:@"" titleFontSize:18 textColor:defaultTextColor backgroundColor:nil alignment:NSTextAlignmentCenter];
//                 labelWithTitleFontSize:18 textColor:KBlackColor alignment:NSTextAlignmentCenter];
    [self.backView addSubview:_topLabel];
    
    _nextBtn = [AppUIKit createBtnWithType:UIButtonTypeCustom backgroundColor:nil action:@selector(nextAction:) target:self title:nil image:@"you" font:0 textColor:nil];
    [self.backView addSubview:_nextBtn];
    
    _calendar = [[FSCalendar alloc] init];
    [self.backView addSubview:_calendar];
    _calendar.dataSource = self;
    _calendar.delegate = self;
    _calendar.clipsToBounds = YES; // 去掉上下黑线
    _calendar.headerHeight = 0;
    _calendar.allowsMultipleSelection = YES;
    _calendar.firstWeekday = 1;
    _calendar.placeholderType = FSCalendarPlaceholderTypeNone;
    
    _calendar.appearance.headerDateFormat = @"yyyy年MM月";
    _calendar.appearance.weekdayTextColor = defaultTextColor;
    _calendar.appearance.weekdayFont = kFont(14);
    _calendar.appearance.caseOptions = FSCalendarCaseOptionsWeekdayUsesSingleUpperCase;
    _calendar.appearance.titleFont = kFont(13);
    _calendar.appearance.titleSelectionColor = defaultTextColor;
    _calendar.appearance.titleDefaultColor = defaultTextColor;
    _calendar.appearance.titleTodayColor = [UIColor whiteColor];
    _calendar.appearance.selectionColor = [UIColor clearColor];
    _calendar.appearance.todayColor = HEXACOLOR(0x5cb7ff);
    [_calendar registerClass:[CalendarCell class] forCellReuseIdentifier:@"qianDao11"];
    
    self.preBtn.sd_layout.topSpaceToView(self.backView, 10).leftSpaceToView(self.backView, 10).widthIs(53).heightIs(40);
    self.nextBtn.sd_layout.topSpaceToView(self.backView, 10).rightSpaceToView(self.backView, 10).widthIs(53).heightIs(40);
    self.topLabel.sd_layout.leftSpaceToView(self.preBtn, 0).centerYEqualToView(self.preBtn).rightSpaceToView(self.nextBtn, 0).heightIs(40);
    
    self.calendar.sd_layout.topSpaceToView(self.topLabel, 10).centerXEqualToView(self.backView).widthIs(kScaleWidth(345)).heightIs(kScaleWidth(290));
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy年MM月"];
    self.topLabel.text = [formatter stringFromDate:_calendar.currentPage];
    
    UIButton *cancleBtn = [AppUIKit createBtnWithType:UIButtonTypeCustom backgroundColor:nil action:@selector(dismiss) target:self title:@"取消" image:nil font:14 textColor:HEXACOLOR(0x999999)];
    
    [self.backView addSubview:cancleBtn];
    
    UIButton *sureBtn = [AppUIKit createBtnWithType:UIButtonTypeCustom backgroundColor:nil action:@selector(sureClick) target:self title:@"确定" image:nil font:14 textColor:HEXACOLOR(0x5cb7ff)];
    [self.backView addSubview:sureBtn];
    
    UIView *lineV = [[UIView alloc]init];
    lineV.backgroundColor = HEXACOLOR(0xf0f1f2);
    [self.backView addSubview:lineV];
    
    UIView *lineV2 = [[UIView alloc]init];
    lineV2.backgroundColor = HEXACOLOR(0xf0f1f2);
    [self.backView addSubview:lineV2];
    
    cancleBtn.sd_layout.bottomEqualToView(self.backView).leftEqualToView(self.backView).widthRatioToView(self.backView, 0.5).heightIs(kScaleWidth(50));
    sureBtn.sd_layout.bottomEqualToView(self.backView).rightEqualToView(self.backView).widthRatioToView(self.backView, 0.5).heightIs(kScaleWidth(50));
    lineV.sd_layout.bottomSpaceToView(cancleBtn, 0).leftEqualToView(self.backView).widthRatioToView(self.backView, 1).heightIs(1);
    
    lineV2.sd_layout.bottomEqualToView(self.backView).centerXEqualToView(self.backView).widthIs(1).heightIs(kScaleWidth(50));
    
}




// 上个月
- (void)preAction:(UIButton *)sender{
    NSDate *currentMonth = self.calendar.currentPage;
    NSDate *previousMonth = [self.gregorian dateByAddingUnit:NSCalendarUnitMonth
                                                       value:-1 toDate:currentMonth options:0];
    [self.calendar setCurrentPage:previousMonth animated:YES];
}

// 下个月
- (void)nextAction:(UIButton *)sender{
    NSDate *currentMonth = self.calendar.currentPage;
    NSDate *nextMonth = [self.gregorian dateByAddingUnit:NSCalendarUnitMonth
                                                   value:1 toDate:currentMonth options:0];
    [self.calendar setCurrentPage:nextMonth animated:YES];
}

- (void)sureClick{
    if (self.isMutiChoose) {
        if (self.selectDateArr.count > 0) {
            if (self.selectDateBlock) {
                [self dismiss];
                NSString *str = [self.selectDateArr componentsJoinedByString:@","];
                self.selectDateBlock(str);
            }
        }else{
            [self showErrorText:@"请选择日期"];
        }
    }else{
        if (self.selectDateBlock) {
            [self dismiss];
            self.selectDateBlock(self.selectDate);
        }
    }
    
    
}


#pragma mark - FSCalendarDelegate
- (void)calendarCurrentPageDidChange:(FSCalendar *)calendar{
    NSDate *currentDate = calendar.currentPage;
    NSDateFormatter *dateFromatter = [[NSDateFormatter alloc]init];
    [dateFromatter setDateFormat:@"yyyy年MM月"];
    _topLabel.text = [dateFromatter stringFromDate:currentDate];
}

//定制cell
- (FSCalendarCell *)calendar:(FSCalendar *)calendar cellForDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition
{
    CalendarCell *cell = [calendar dequeueReusableCellWithIdentifier:@"qianDao11" forDate:date atMonthPosition:monthPosition];
    //定制图片
    return cell;
}

- (UIColor *)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance titleDefaultColorForDate:(NSDate *)date {
//    if ([self.dataArray containsObject:[self.dateFormatter stringFromDate:date]]) {
//        return [UIColor whiteColor];
//    }
    return nil;
}

- (NSDate *)maximumDateForCalendar:(FSCalendar *)calendar {
    return [NSDate backward:365 unitType:NSCalendarUnitDay];
}

- (NSDate *)minimumDateForCalendar:(FSCalendar *)calendar {
    return [NSDate forward:365 unitType:NSCalendarUnitDay];
}

- (NSString *)calendar:(FSCalendar *)calendar titleForDate:(NSDate *)date {
    if ([self.gregorian isDateInToday:date]) {
        return @"今天";
    }
    return nil;
}

-(UIColor *)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance borderDefaultColorForDate:(NSDate *)date{
    if ([self.gregorian isDateInToday:date]) {
        return HEXACOLOR(0x5cb7ff);
    }
    return nil;
}
- (UIColor *)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance borderSelectionColorForDate:(NSDate *)date{
    return HEXACOLOR(0xe60013);
}

- (BOOL)calendar:(FSCalendar *)calendar shouldSelectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition {
    return monthPosition == FSCalendarMonthPositionCurrent;
}
- (BOOL)calendar:(FSCalendar *)calendar shouldDeselectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition
{
    return monthPosition == FSCalendarMonthPositionCurrent;
}
- (void)calendar:(FSCalendar *)calendar didSelectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition{
    NSLog(@"did select date %@",[self.dateFormatter stringFromDate:date]);
    if (self.isMutiChoose) {
        [self.selectDateArr addObject:[self.dateFormatter stringFromDate:date]];
    }else{
        self.selectDate = [self.dateFormatter stringFromDate:date];
    }
}
- (void)calendar:(FSCalendar *)calendar didDeselectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition
{
    NSLog(@"did deselect date %@",[self.dateFormatter stringFromDate:date]);
    if (self.isMutiChoose) {
        [self.selectDateArr removeObject:[self.dateFormatter stringFromDate:date]];
    }
    
}

//- (UIImage *)calendar:(FSCalendar *)calendar imageForDate:(NSDate *)date{
//    if ([self.dataArray containsObject:[self.dateFormatter stringFromDate:date]]) {
//        return [UIImage imageNamed:@"xin"];
//    }else{
//        return nil;
//    }
//}




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

- (void)dismiss{
    [UIView animateWithDuration:0.3f animations:^{
        self.backView.alpha = 0;
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        [[NSNotificationCenter defaultCenter]removeObserver:self];
    }];
}

- (void)nodismiss{
    
}

- (NSDateFormatter *)dateFormatter {
    if (!_dateFormatter) {
        _dateFormatter = [[NSDateFormatter alloc]init];
        [_dateFormatter setDateFormat:@"yyyy-MM-dd"];
        [_dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
    }
    return _dateFormatter;
}


- (NSMutableArray *)selectDateArr{
    if (!_selectDateArr) {
        _selectDateArr = [[NSMutableArray alloc]init];
    }
    return _selectDateArr;
}

- (void)setIsMutiChoose:(BOOL)isMutiChoose{
    _isMutiChoose = isMutiChoose;
    if (isMutiChoose) {
        self.calendar.allowsMultipleSelection = YES;
    }else{
        self.calendar.allowsMultipleSelection = NO;
    }
}


@end
