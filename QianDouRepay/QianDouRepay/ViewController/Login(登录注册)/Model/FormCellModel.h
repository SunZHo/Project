//
//  FormCellModel.h
//  QianDouRepay
//
//  Created by <15>帝云科技 on 2018/4/9.
//  Copyright © 2018年 帝云科技<15>. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger,CellType) {
    cellTypeIcon_FieldType = 0,//img-field
    cellTypeTitle_FieldType = 1,//title-field
    cellTypeIcon_FieldVeirfyCodeType = 2,//icon-field-验证码
    cellTypeTitle_FieldSelection = 3,//title-field-选择
    cellTypeTitle_FieldVeirfyCodeType = 4,//title-field-验证码
    cellTypeSectionHeaderType = 5, // section头
};

@interface FormCellModel : NSObject

/** 是否是明文 */
@property (nonatomic , assign) BOOL isSecureText ;
/** 是否可编辑 */
@property (nonatomic , assign) BOOL canEdit ;
/** 类型 */
@property (nonatomic , assign) CellType cellType;
/** 左边文字 */
@property (nonatomic , copy) NSString *title;
/** 图片名字 */
@property (nonatomic , copy) NSString *imageName;
/** Textfield 内容 */
@property (nonatomic , copy) NSString *text;
/** 占位符 */
@property (nonatomic , copy) NSString *placeHolder;
/** 键盘类型 */
@property (nonatomic , assign) UIKeyboardType boardType;
/** 数据请求的key值 */
@property (nonatomic , copy) NSString *reqKey;


@end
