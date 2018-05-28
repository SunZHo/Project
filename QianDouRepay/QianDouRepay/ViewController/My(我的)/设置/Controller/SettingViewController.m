//
//  SettingViewController.m
//  QianDouRepay
//
//  Created by <15>帝云科技 on 2018/4/10.
//  Copyright © 2018年 帝云科技<15>. All rights reserved.
//

#import "SettingViewController.h"
#import "SettingCell.h"
#import "SetNickNameVC.h"

@interface SettingViewController ()<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate>

@property (nonatomic , copy) NSArray *cellLabelArray;
@property (nonatomic , strong) BaseTableView *table;
@property (nonatomic , strong) UIImageView *headImage; // 头像
@property (nonatomic , copy) NSString *nickName; // 昵称
@property (nonatomic , copy) NSString *sex; // 性别

@end

@implementation SettingViewController

- (void)viewWillAppear:(BOOL)animated{
    if ([[UserInfoDic objectForKey:@"sex"] integerValue] == 0 ) {
        self.sex = @"保密";
    }else if ([[UserInfoDic objectForKey:@"sex"] integerValue] == 1 ){
        self.sex = @"男";
    }else if ([[UserInfoDic objectForKey:@"sex"] integerValue] == 2 ){
        self.sex = @"女";
    }
    self.nickName = [UserInfoDic objectForKey:@"nickname"];
    [self.table reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";
    [self wr_setNavBarShadowImageHidden:YES];
    self.cellLabelArray = @[@[@"头像",@"真实姓名",@"身份证号",@"手机号码"],
                            @[@"昵称",@"性别"]];
    
    [self.view addSubview:self.table];
    
    
}

#pragma mark UITableViewDataSource && UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.cellLabelArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *arr = self.cellLabelArray[section];
    return arr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 && indexPath.row == 0) {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.text = [[self.cellLabelArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
        cell.textLabel.textColor = defaultTextColor;
        cell.textLabel.font = kFont(15);
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.contentView addSubview:self.headImage];
        [self.headImage sd_setImageWithURL:[NSURL URLWithString:[UserInfoDic objectForKey:@"avatar"]]
                          placeholderImage:IMG(@"tx")];
        self.headImage.sd_layout.centerYEqualToView(cell.contentView).rightSpaceToView(cell.contentView, 15).heightIs(36).widthIs(36);
        self.headImage.sd_cornerRadiusFromWidthRatio = @(0.5);
        
        return cell;
    }
    SettingCell *cell = [[SettingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.textLabel.text = [[self.cellLabelArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    if (indexPath.section == 0 && indexPath.row == 1){
        cell.rightLabel.text  = [UserInfoDic objectForKey:@"realname"];
        cell.cellType = cellTypeNormal;
    }else if (indexPath.section == 0 && indexPath.row == 2) {
        NSString *phoneNum = [UserInfoDic objectForKey:@"idcard"];
        if (phoneNum.length == 18) {
            cell.rightLabel.text = [phoneNum stringByReplacingCharactersInRange:NSMakeRange(6, 8) withString:@"********"];
        }else{
            cell.rightLabel.text = @"";
        }
        cell.cellType = cellTypeNormal;
    }else if (indexPath.section == 0 && indexPath.row == 3) {
        NSString *phoneNum = [UserInfoDic objectForKey:@"phone"];
        if (phoneNum.length == 11) {
            cell.rightLabel.text = [phoneNum stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
        }else{
            cell.rightLabel.text = @"";
        }
        cell.cellType = cellTypeNormal;
    }else if (indexPath.section == 1 && indexPath.row == 0){
        cell.rightLabel.text = self.nickName;
        cell.cellType = cellTypeHasRightRow;
    }else if (indexPath.section == 1 && indexPath.row == 1){
        cell.rightLabel.text = self.sex;
        cell.cellType = cellTypeHasRightRow;
    }
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 && indexPath.row == 0) {
        [BDImagePicker showImagePickerFromViewController:self allowsEditing:YES finishAction:^(UIImage *image) {
            if (image) {
                [self uploadImage:image];
            }
        }];
        
        
    }else if (indexPath.section == 1 && indexPath.row == 0){
        SetNickNameVC *nickVC = [[SetNickNameVC alloc]init];
        nickVC.nickNameBlock = ^(NSString *name) {
            self.nickName = name;
            NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:1];
            [self.table reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
        };
        PUSHVC(nickVC);
        
    }else if (indexPath.section == 1 && indexPath.row == 1){
        UIActionSheet *action = [[UIActionSheet alloc]initWithTitle:nil
                                                           delegate:self
                                                  cancelButtonTitle:@"取消"
                                             destructiveButtonTitle:nil
                                                  otherButtonTitles:@"男",@"女",@"保密", nil];
        [action showInView:self.view];
    }
    
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kScaleWidth(60);
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10.f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}


- (void)uploadImage:(UIImage *)image{
    __weak typeof(self)weakSelf=self;
    NSDictionary *dic=@{@"userid":UserID};
    [self showLoading];
    [AppNetworking uploadImageWithOperations:dic withImageArray:@[image] withUrlString:my_setHeadPic withFileParameter:@"avatar" withSuccessBlock:^(id json) {
        weakSelf.headImage.image = image;
        NSString *pic = [[json objectForKey:@"info"] objectForKey:@"avatar"];
        [UserInfoDic setObject:pic forKey:@"avatar"];
        [UserInfoCache archiveUserInfo:UserInfoDic keyedArchiveName:USER_INFO_CACHE];
        [self showSuccessText:@"设置头像成功"];
    } withFailureBlock:^(NSError *error) {
        [weakSelf showErrorText:@"设置失败"];
    } withUploadProgress:^(float progress) {
        
    }];
}
#pragma mark - actionSheet
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSString *type = @"";
    switch (buttonIndex){
        case 0:  //男
            type = @"1";
            break;
        case 1:  //女
            type = @"2";
            break;
        case 2:  //保密
            type = @"0";
            break;
    }
    NSDictionary *dic=@{@"userid":UserID,
                        @"sex" : type
                        };
    [self showLoading];
    [AppNetworking requestWithType:HttpRequestTypePost withUrlString:my_setSex withParaments:dic withSuccessBlock:^(id json) {
        [self showSuccessText:@"设置成功"];
        self.sex = [actionSheet buttonTitleAtIndex:buttonIndex];
        NSIndexPath *indexPath=[NSIndexPath indexPathForRow:1 inSection:1];
        [self.table reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
    } withFailureBlock:^(NSString *errorMessage, int code) {
        
    }];
    
    
}



#pragma mark - LazyLoad

- (BaseTableView *)table{
    if (!_table) {
        _table = [[BaseTableView alloc] initWithFrame:self.view.frame];
        _table.delegate = self;
        _table.dataSource = self;
//        _table.scrollEnabled= NO;
        _table.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    }
    return _table;
}


- (UIImageView *)headImage{
    if (!_headImage) {
        _headImage = [[UIImageView alloc]init];
//        _headImage.backgroundColor = [UIColor brownColor];
    }
    return _headImage;
}






@end
