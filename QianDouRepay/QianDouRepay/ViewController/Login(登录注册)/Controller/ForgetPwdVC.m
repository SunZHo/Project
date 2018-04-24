//
//  ForgetPwdVC.m
//  QianDouRepay
//
//  Created by <15>帝云科技 on 2018/4/9.
//  Copyright © 2018年 帝云科技<15>. All rights reserved.
//

#import "ForgetPwdVC.h"
#import "FormCell.h"
#import "FormCellModel.h"
#import "LoginHeadView.h"

@interface ForgetPwdVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic , strong) BaseTableView *table;
@property (nonatomic , strong) NSMutableArray *formData;
@property (nonatomic , strong) UIImageView *topImage;
@property (nonatomic , strong) LoginHeadView *headView;
@property (nonatomic , strong) UIButton *sureBtn;

@end

@implementation ForgetPwdVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [super setNavAlphaZero];
    self.title = @"忘记密码";
    self.view.backgroundColor = [UIColor whiteColor];
    [self wr_setNavBarTitleColor:HEXACOLOR(0xffffff)];
    
    [self setupLeftBarButtonItem];
    
    [self.view addSubview:self.headView];
    [self.headView addSubview:self.topImage];
    
    self.topImage.sd_layout.centerXEqualToView(self.headView).bottomSpaceToView(self.headView, 24).heightIs(76).widthIs(76);
    self.topImage.sd_cornerRadiusFromWidthRatio = @(0.5);

    
    [self loadFormData];
    [self.view addSubview:self.table];
    [self.view addSubview:self.sureBtn];
    self.sureBtn.sd_layout.leftEqualToView(self.table).topSpaceToView(self.table, 30).rightEqualToView(self.table).heightIs(44);
    self.sureBtn.sd_cornerRadius = @5;
    
}


#pragma mark - 导航按钮
- (void)setupLeftBarButtonItem
{
    self.navigationItem.leftBarButtonItem =({
        [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"bjtou"]
                                        style:UIBarButtonItemStylePlain
                                       target:self
                                       action:@selector(leftBarButtonItemClicked)];
        
    });
}

- (void)leftBarButtonItemClicked{
    POPVC;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.formData.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    FormCellModel *model = [self.formData objectAtIndex:indexPath.row];
    static NSString *identifier1 = @"formCell";
    FormCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier1];
    if (!cell) {
        cell = [[FormCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier1];
    }
    cell.cellTextFieldBlock = ^(NSString *text) {
        [self notiTextField:text andIndex:indexPath];
    };
    
    [cell setFormcellModel:model];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"didse");
}


- (void)notiTextField:(NSString *)text andIndex:(NSIndexPath *)indexPath{
    FormCellModel *model = [self.formData objectAtIndex:indexPath.row];
    model.text = text;
}

- (void)loadFormData{
    FormCellModel *model1 = [[FormCellModel alloc]init];
    model1.cellType = cellTypeIcon_FieldType;
    model1.text = @"";
    model1.imageName = @"shouj";
    model1.canEdit = YES;
    model1.boardType = UIKeyboardTypeNumberPad;
    model1.placeHolder = @"请输入您的手机号";
    
    FormCellModel *model2 = [[FormCellModel alloc]init];
    model2.cellType = cellTypeIcon_FieldVeirfyCodeType;
    model2.text = @"";
    model2.imageName = @"dx";
    model2.canEdit = YES;
    model2.boardType = UIKeyboardTypeNumberPad;
    model2.placeHolder = @"请输入短信验证码";
    
    FormCellModel *model3 = [[FormCellModel alloc]init];
    model3.cellType = cellTypeIcon_FieldType;
    model3.text = @"";
    model3.imageName = @"mima";
    model3.canEdit = YES;
    model3.isSecureText = YES;
    model3.boardType = UIKeyboardTypeDefault;
    model3.placeHolder = @"请输入密码";
    
    FormCellModel *model4 = [[FormCellModel alloc]init];
    model4.cellType = cellTypeIcon_FieldType;
    model4.text = @"";
    model4.imageName = @"zc";
    model4.canEdit = YES;
    model4.isSecureText = YES;
    model4.boardType = UIKeyboardTypeDefault;
    model4.placeHolder = @"请再次输入密码";
    
    
    [self.formData addObjectsFromArray:@[model1,model2,model3,model4]];
}


- (void)sureClick{
    
}







#pragma mark - LazyLoad

- (BaseTableView *)table{
    if (!_table) {
        _table = [[BaseTableView alloc]initWithFrame:CGRectMake(40, 200, SCREEN_WIDTH - 80, 200)];
        _table.dataSource = self;
        _table.delegate = self;
        _table.scrollEnabled = NO;
        _table.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    }
    return _table;
}

- (NSMutableArray *)formData{
    if (!_formData) {
        _formData = [[NSMutableArray alloc]init];
    }
    return _formData;
}

- (LoginHeadView *)headView{
    if (!_headView) {
        _headView = [[LoginHeadView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
    }
    return _headView;
}

- (UIImageView *)topImage{
    if (!_topImage) {
        _topImage = [[UIImageView alloc]init];
        _topImage.image = IMG(@"loginLogo");
        _topImage.layer.borderColor = [UIColor whiteColor].CGColor;
        _topImage.layer.borderWidth = 5;
    }
    return _topImage;
}

- (UIButton *)sureBtn{
    if (!_sureBtn) {
        _sureBtn = [AppUIKit createBtnWithType:UIButtonTypeCustom
                               backgroundColor:APPMainColor
                                        action:@selector(sureClick)
                                        target:self
                                         title:@"确认"
                                         image:nil
                                          font:14
                                     textColor:HEXACOLOR(0xffffff)];
    }
    return _sureBtn;
}

@end
