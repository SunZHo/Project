//
//  AboutUsViewController.m
//  QianDouRepay
//
//  Created by <15>帝云科技 on 2018/4/19.
//  Copyright © 2018年 帝云科技<15>. All rights reserved.
//

#import "AboutUsViewController.h"

@interface AboutUsViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic , strong) BaseTableView *table;

@property (nonatomic , copy) NSArray *titleArray;

@property (nonatomic , copy) NSArray *valueArray;

@end

@implementation AboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"关于我们";
    
    self.titleArray = @[@"版本号",@"客服电话",@"官方网址"];
    [self loadData];
    
    [self.view addSubview:self.table];
}

- (void)loadData{
    [AppNetworking requestWithType:HttpRequestTypeGet withUrlString:my_aboutUS withParaments:nil withSuccessBlock:^(id json) {
        NSString *version = [NSString stringWithFormat:@"V%@",[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]];
        NSString *phone = [[json objectForKey:@"info"] objectForKey:@"phone"];
        NSString *webUrl = [[json objectForKey:@"info"] objectForKey:@"website"];
        self.valueArray = @[version,phone,webUrl];
        [self.table reloadData];
    } withFailureBlock:^(NSString *errorMessage, int code) {
        
    }];
}


#pragma mark - table
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.titleArray.count;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifiyImg = @"aboutUscell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifiyImg];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifiyImg];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if (indexPath.row != 0) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.textLabel.text = self.titleArray[indexPath.row];
    cell.textLabel.textColor = defaultTextColor;
    cell.textLabel.font = kFont(15);
    
    UILabel *textLabel = [[UILabel alloc]init];
    textLabel.font = kFont(12);
    textLabel.textColor = defaultTextColor;
    textLabel.textAlignment = NSTextAlignmentRight;
    textLabel.text = self.valueArray[indexPath.row];
    [cell.contentView addSubview:textLabel];
    textLabel.sd_layout.centerYEqualToView(cell.contentView).widthIs(SCREEN_WIDTH/2).heightIs(16).rightSpaceToView(cell.contentView,10);
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *str = self.valueArray[indexPath.row];
    
    if (indexPath.row == 1) {
        NSString *callPhone = [NSString stringWithFormat:@"tel://%@", str];
        if (@available(iOS 10.0, *)) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callPhone] options:@{} completionHandler:nil];
        } else {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callPhone]];
        }
        
    }else if (indexPath.row == 2){
        NSString *url; // 把http://带上
        if ([str containsString:@"http"]) {
            url = str;
        }else{
            url = [NSString stringWithFormat:@"http://%@",str];
        }
        
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:url]];
        
    }
}





#pragma mark - LazyLoad

- (BaseTableView *)table{
    if (!_table) {
        _table = [[BaseTableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _table.dataSource = self;
        _table.delegate = self;
        _table.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _table.backgroundColor = WhiteColor;
    }
    return _table;
}




@end
