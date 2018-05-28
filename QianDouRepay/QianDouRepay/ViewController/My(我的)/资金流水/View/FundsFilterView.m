//
//  FundsFilterView.m
//  QianDouRepay
//
//  Created by <15>帝云科技 on 2018/4/17.
//  Copyright © 2018年 帝云科技<15>. All rights reserved.
//

#import "FundsFilterView.h"
#import "FilterCell.h"
#import "FilterModel.h"

@interface FundsFilterView()<UICollectionViewDelegate,UICollectionViewDataSource,STPickerDateDelegate>{
    UIView *backImg;
    UICollectionView *collectView;
    NSString *startTime;
    NSString *endTime;
    NSString *type;
    NSString *typeStr;
}

@property (nonatomic , strong) NSMutableArray *textArray;

@end

@implementation FundsFilterView

-(instancetype)init{
    if (self == [super init]) {
        self.frame = [UIScreen mainScreen].bounds;
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.3f];
//        self.userInteractionEnabled = YES;
//        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissSelf)];
//        [self addGestureRecognizer:tapGes];
        [self layoutSubview];
    }
    return self;
}

-(void)layoutSubview{
    startTime = @"";
    endTime = @"";
    type = @"";
    typeStr = @"全部";
    NSArray *arr = @[@"全部",@"提现审核中",@"提现成功",@"提现失败",@"分润流水",@"推广奖励"];
    NSArray *typeA = @[@"",@"3",@"4",@"5",@"2",@"1"];
    for (int i = 0; i < arr.count; i++) {
        FilterModel *model = [[FilterModel alloc]init];
        model.text = arr[i];
        model.type = typeA[i];
        if (i == 0) {
            model.isChoose = YES;
        }else{
            model.isChoose = NO;
        }
        [self.textArray addObject:model];
    }
    backImg = [[UIView alloc]init];
    backImg.backgroundColor = HEXACOLOR(0xffffff);
    [self addSubview:backImg];
    backImg.sd_layout.leftEqualToView(self).rightEqualToView(self).topSpaceToView(self, -325).heightIs(325);
    
    UILabel *chooseLabel = [AppUIKit labelWithTitle:@"选择类型" titleFontSize:15 textColor:defaultTextColor backgroundColor:nil alignment:0];
    [backImg addSubview:chooseLabel];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    collectView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    [collectView registerClass:[FilterCell class] forCellWithReuseIdentifier:@"FilterCell"];
    collectView.delegate = self;
    collectView.dataSource = self;
    collectView.backgroundColor = WhiteColor;
    [backImg addSubview:collectView];
    
    chooseLabel.sd_layout.topSpaceToView(backImg, 25).leftSpaceToView(backImg, 13).widthIs(70).heightIs(15);
    
    collectView.sd_layout.topSpaceToView(chooseLabel, 25).centerXEqualToView(backImg).widthIs(290).heightIs(110);
    
    
    UILabel *chooseDateLabel = [AppUIKit labelWithTitle:@"日期选择" titleFontSize:15 textColor:defaultTextColor backgroundColor:nil alignment:0];
    [backImg addSubview:chooseDateLabel];
    chooseDateLabel.sd_layout.topSpaceToView(collectView, 0).leftSpaceToView(backImg, 13).widthIs(70).heightIs(15);
    
    UIImageView *dateImg = [[UIImageView alloc]initWithImage:IMG(@"rili")];
    UIButton *begin = [AppUIKit createBtnWithType:UIButtonTypeCustom backgroundColor:nil action:@selector(chooseDate:) target:self title:@"开始时间" image:nil font:12 textColor:HEXACOLOR(0xc3c3c3)];
    begin.tag = 1;
    UIView *lineV = [[UIView alloc]init];
    lineV.backgroundColor = HEXACOLOR(0xdddddd);
    
    UIView *midV = [[UIView alloc]init];
    midV.backgroundColor = HEXACOLOR(0xdddddd);

    UIImageView *dateImg1 = [[UIImageView alloc]initWithImage:IMG(@"rili")];
    UIButton *end = [AppUIKit createBtnWithType:UIButtonTypeCustom backgroundColor:nil action:@selector(chooseDate:) target:self title:@"结束时间" image:nil font:12 textColor:HEXACOLOR(0xc3c3c3)];
    end.tag = 2;
    UIView *lineV1 = [[UIView alloc]init];
    lineV1.backgroundColor = HEXACOLOR(0xdddddd);
    
    [backImg sd_addSubviews:@[dateImg,begin,lineV,midV,dateImg1,end,lineV1]];
    dateImg.sd_layout.topSpaceToView(chooseDateLabel, 29).leftSpaceToView(backImg, 13).heightIs(15).widthIs(14);
    begin.sd_layout.topEqualToView(dateImg).leftSpaceToView(dateImg, 10).heightRatioToView(dateImg, 1).widthIs(80);
    lineV.sd_layout.topSpaceToView(dateImg, 13).leftEqualToView(dateImg).heightIs(0.5).widthIs(120);
    
    midV.sd_layout.topSpaceToView(chooseDateLabel, 37).centerXEqualToView(backImg).heightIs(2).widthIs(8);
    
    dateImg1.sd_layout.topEqualToView(dateImg).leftSpaceToView(midV, 25).heightIs(15).widthIs(14);
    end.sd_layout.topEqualToView(dateImg).leftSpaceToView(dateImg1, 10).heightRatioToView(dateImg, 1).widthIs(80);
    lineV1.sd_layout.topEqualToView(lineV).leftEqualToView(dateImg1).heightIs(0.5).widthIs(120);
    
    
    
    UIButton *cancleBtn = [AppUIKit createBtnWithType:UIButtonTypeCustom backgroundColor:HEXACOLOR(0xdddddd) action:@selector(dismissSelf) target:self title:@"取消" image:nil font:15 textColor:defaultTextColor];
    
    UIButton *sureBtn = [AppUIKit createBtnWithType:UIButtonTypeCustom backgroundColor:APPMainColor action:@selector(sureClick) target:self title:@"确定" image:nil font:15 textColor:HEXACOLOR(0x1e2674)];
    
    [backImg addSubview:cancleBtn];
    [backImg addSubview:sureBtn];
    
    cancleBtn.sd_layout.leftEqualToView(backImg).bottomEqualToView(backImg).heightIs(44).widthRatioToView(backImg, 0.5);
    sureBtn.sd_layout.rightEqualToView(backImg).bottomEqualToView(backImg).heightIs(44).widthRatioToView(backImg, 0.5);
    
}



- (void)chooseDate:(UIButton *)sender{
    STPickerDate *datePicker = [[STPickerDate alloc]init];
    datePicker.tag = sender.tag + 10;
    datePicker.delegate = self;
    [datePicker setYearLeast:2000];
    [datePicker setYearSum:100];
    [datePicker show];
}


- (void)sureClick{
    if (self.filterBlock) {
        self.filterBlock(YES,startTime,endTime,type,typeStr);
    }
    [UIView animateWithDuration:0.3f animations:^{
        backImg.sd_layout.leftEqualToView(self).rightEqualToView(self).topSpaceToView(self, -325).heightIs(325);
        [backImg updateLayout];
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}




-(void)dismissSelf{
    if (self.filterBlock) {
        self.filterBlock(NO,startTime,endTime,type,typeStr);
    }
    [UIView animateWithDuration:0.3f animations:^{
        backImg.sd_layout.leftEqualToView(self).rightEqualToView(self).topSpaceToView(self, -325).heightIs(325);
        [backImg updateLayout];
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}







- (void)showInView:(UIView *)view{
//    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [view addSubview:self];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:.3 animations:^{
            backImg.sd_layout.leftEqualToView(self).rightEqualToView(self).topSpaceToView(self, 64 + SafeAreaTopHeight).heightIs(325);
            [backImg updateLayout];
        }];
    });
}

-(void)show{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:self];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:.3 animations:^{
            backImg.sd_layout.leftEqualToView(self).rightEqualToView(self).topSpaceToView(self, 0).heightIs(325);
            [backImg updateLayout];
        }];
    });
    
    
}

- (void)pickerDate:(STPickerDate *)pickerDate year:(NSInteger)year month:(NSInteger)month day:(NSInteger)day{
    NSString *text = [NSString stringWithFormat:@"%ld-%02ld-%02ld",(long) year,(long) month,(long) day];
    UIButton *btn = [self viewWithTag:pickerDate.tag - 10];
    [btn setTitle:text forState:UIControlStateNormal];
    [btn setTitleColor:defaultTextColor forState:UIControlStateNormal];
    if (pickerDate.tag - 10 == 1) {
        startTime = [NSDate timeStringFromTimestamp:[NSDate timestampFromDate:[NSDate date:text WithFormat:@"yyyy-MM-dd"]] formatter:@"yyyy-MM-dd HH:mm:ss"];
    }else if(pickerDate.tag - 10 == 2){
        endTime = [NSDate timeStringFromTimestamp:[NSDate timestampFromDate:[NSDate date:text WithFormat:@"yyyy-MM-dd"]] formatter:@"yyyy-MM-dd HH:mm:ss"];
    }
    //NSCalendarUnitDay
}


// MARK: - CollectionViewDelegate
- (NSInteger ) numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger ) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.textArray.count;
}

- (UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    FilterModel *model = [self.textArray objectAtIndex:indexPath.row];
    FilterCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FilterCell" forIndexPath:indexPath];
    [cell setFilterModel:model];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    FilterModel *model = [self.textArray objectAtIndex:indexPath.row];
    for (FilterModel *filtermodel in self.textArray) {
        if ([filtermodel.text isEqualToString:model.text]) {
            filtermodel.isChoose = YES;
        }else{
            filtermodel.isChoose = NO;
        }
    }
    type = model.type;
    typeStr = model.text;
    [collectView reloadData];
}


// collectionviewcell  的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(80, 28);
}


// 定义collectionView距离屏幕 上，左，下，右 的间距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

// 定义每个collectionViewcell 的左右最小间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0.5;
}


// 定义每个collectionViewcell 的上下最小间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 20;
}





- (NSMutableArray *)textArray{
    if (!_textArray) {
        _textArray = [[NSMutableArray alloc]init];
    }
    return _textArray;
}


@end
