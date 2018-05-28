//
//  XBTextLoopView.m
//  文字轮播
//
//  Created by 周旭斌 on 2017/4/9.
//  Copyright © 2017年 周旭斌. All rights reserved.
//

#import "XBTextLoopView.h"

@interface XBTextLoopView () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, assign) NSTimeInterval interval;
@property (nonatomic, strong) NSTimer *myTimer;
@property (nonatomic, assign) NSInteger currentRowIndex;
@property (nonatomic, copy) selectTextBlock selectBlock;

@end

@implementation XBTextLoopView

#pragma mark - 初始化方法
+ (instancetype)textLoopViewinitWithFrame:(CGRect)frame selectBlock:(selectTextBlock)selectBlock{
    XBTextLoopView *loopView = [[XBTextLoopView alloc] initWithFrame:frame];
    loopView.selectBlock = selectBlock;
//    if (dataSource.count > 1) {
//        loopView.interval = timeInterval ? timeInterval : 1.0;
//    }
    return loopView;
}

#pragma mark - tableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.text = _dataSource[indexPath.row];
    cell.textLabel.font = kFont(12);
    cell.textLabel.textColor = defaultTextColor;
    return cell;
}

#pragma mark - tableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (_selectBlock) {
        self.selectBlock(_dataSource[indexPath.row], indexPath.row);
    }
}

#pragma mark - scrollViewDelegate
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    // 以无动画的形式跳到第1组的第0行
    if (_currentRowIndex == _dataSource.count) {
        _currentRowIndex = 0;
        [_tableView setContentOffset:CGPointZero];
    }
}

#pragma mark - priviate method
- (void)setInterval:(NSTimeInterval)interval {
    _interval = interval;
    [_myTimer invalidate];
    _myTimer = nil;
    // 定时器
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:interval target:self selector:@selector(timer) userInfo:nil repeats:YES];
    _myTimer = timer;
//    XTimer *timer = [XTimer scheduledTimerWithTimeInterval:interval target:self selector:@selector(timer) userInfo:nil repeats:YES];
//    _myTimer = timer;
}

- (void)setDataSource:(NSArray *)dataSource{
    _dataSource = dataSource;
    [self.tableView reloadData];
    if (dataSource.count > 1) {
        self.interval = 5;
    }else{
        [_myTimer invalidate];
        _myTimer = nil;
    }
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        // tableView
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _tableView = tableView;
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.rowHeight = frame.size.height;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.scrollEnabled = NO;
        [self addSubview:tableView];
    }
    return self;
}

- (void)timer {
    self.currentRowIndex++;
//    NSLog(@"%ld", _currentRowIndex);
    [self.tableView setContentOffset:CGPointMake(0, _currentRowIndex * _tableView.rowHeight) animated:YES];
}


//-(void)stopTimer{
//    [_myTimer stop];
//    [_myTimer invalidate];
//}
//
//-(void)startTimer{
//    [_myTimer reStart];
//}


@end
