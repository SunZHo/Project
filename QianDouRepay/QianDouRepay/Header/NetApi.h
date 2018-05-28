//
//  NetApi.h
//  QianDouRepay
//
//  Created by <15>帝云科技 on 2018/4/9.
//  Copyright © 2018年 帝云科技<15>. All rights reserved.
//

#ifndef NetApi_h
#define NetApi_h

#define baseUrl @"http://qiandou.diyunkeji.com"

#pragma mark - 登录注册
/** 登录 */
#define loginUrl @"/index.php/Api/Login/dologin.html"
/** 注册 */
#define regUrl @"/index.php/Api/Register/doreg.html"
/** 注册获取验证码 */
#define regSmsUrl @"/index.php/Api/Register/sms.html"
/** 忘记密码 */
#define forgetPwd @"/index.php/Api/Password/back.html"
/** 忘记密码获取验证码 */
#define forgetPwdSms @"/index.php/Api/Password/sms.html"
/** 注册协议 */
#define regAgreement @"/index.php/Api/Register/agreement.html"

#pragma mark - 首页
/** 公告 */
#define home_reportUrl @"/index.php/Api/Index/news.html"
/** banner */
#define home_bannerUrl @"/index.php/Api/Index/banner.html"
/** newsCount */
#define home_newscountUrl @"/index.php/Api/Index/message.html"
/** VIP付费状态 */
#define home_VipPayStatusUrl @"/index.php/Api/Realname/pay_vip.html"
/** VIP付费信息 */
#define home_VipPayInfoUrl @"/index.php/Api/Realname/payinfo_vip.html"
/** VIP付费二维码 */
#define home_VipQRcodeUrl @"/index.php/Api/Realname/sdpay_vip.html"
/** 我的费率—代还 */
#define home_MyFeeRepay @"/index.php/Api/Account/rate.html"
/** 我的费率—收款 */
#define home_MyFeeReceive @"/index.php/Api/Account/backrate.html"
/** 我的分润 */
#define home_MyBackMoney @"/index.php/Api/backmoney/info.html"
/** 分润记录 */
#define home_MyBackMoneyRecord @"/index.php/Api/backmoney/index.html"

#pragma mark - 信用卡代还
/** 信用卡列表 */
#define creditcard_list @"/index.php/Api/CreditCard/index.html"
/** 信用卡—添加 */
#define creditcard_addCard @"/index.php/Api/CreditCard/add.html"
/** 信用卡—短信 */
#define creditcard_addCardSMS @"/index.php/Api/CreditCard/sms.html"
/** 信用卡—删除 */
#define creditcard_delCard @"/index.php/Api/CreditCard/dodel.html"
/** 信用卡—修改 */
#define creditcard_changeCard @"/index.php/Api/CreditCard/doedit.html"
/** 信用卡—还款计划列表 */
#define creditcard_RepayPlanList @"/index.php/Api/Repayment/plan.html"
/** 信用卡—还款计划detail */
#define creditcard_RepayPlan @"/index.php/Api/Repayment/plan.html"
/** 信用卡—还款计划已完detail */
#define creditcard_RepayPlanDone @"/index.php/Api/Repayment/done.html"
/** 信用卡-授权短信 */
#define creditcard_BindSMS @"/index.php/Api/CreditCard/bind_sms.html"
/** 信用卡-授权提交 */
#define creditcard_BindCommit @"/index.php/Api/CreditCard/bind_sub.html"

/** 信用卡—新增还款计划 */
#define creditcard_AddPlan @"/index.php/Api/Repayment/add.html"
/** 信用卡—还款计划预览 */
#define creditcard_PlanPreview @"/index.php/Api/Repayment/preview.html"
/** 信用卡—还款计划提交 */
#define creditcard_PlanSubmit @"/index.php/Api/Repayment/dosubmit.html"
/** 信用卡—还款计划预览清空 */
#define creditcard_PlanClear @"/index.php/Api/Repayment/clear_preview.html"

/** 账单—列表 */
#define creditcard_OrderList @"/index.php/Api/Order/index.html"
/** 账单详情 */
#define creditcard_OrderDetail @"/index.php/Api/Order/info.html"
/** 还款计划解冻 */
#define creditcard_planUnfreeze @"/index.php/Api/Repayment/unfreeze.html"

#pragma mark - 快捷收款
/** 快捷收款通道选择首页 */
#define receipt_PathList @"/index.php/Api/QuickPay/index.html"
/** 快捷收款—收款记录 */
#define receipt_Record @"/index.php/Api/QuickPay/log_list.html"
/** 快捷收款—信用卡列表 */
#define receipt_CreditCardList @"/Api/QuickPay/credite.html"
/** 快捷收款--添加信用卡 */
#define receipt_addCreditCard @"/index.php/Api/QuickPay/credite_bind.html"
/** 快捷收款—解绑信用卡 */
#define receipt_unBindCreditCard @"/index.php/Api/QuickPay/credite_del.html"
/** 快捷收款—储蓄卡列表 */
#define receipt_bankCardList @"/index.php/Api/QuickPay/debit.html"
/** 快捷收款—解绑储蓄卡 */
#define receipt_unBindCard @"/index.php/Api/QuickPay/debit_del.html"
/** 快捷收款—添加储蓄卡 */
#define receipt_AddBankCard @"/index.php/Api/QuickPay/debit_bind.html"
/** 快捷收款—银行预留手机号验证码（储蓄卡、信用卡）*/
#define receipt_BankSMS @"/index.php/Api/QuickPay/sms_bind.html"
/** 快捷收款—提交*/
#define receipt_Pay @"/index.php/Api/QuickPay/pay.html"


#pragma mark - 我的
/** 我的信息 */
#define my_accountInfo @"/index.php/Api/Account/index.html"
/** 设置头像 */
#define my_setHeadPic @"/index.php/Api/Account/avatar.html"
/** 设置昵称 */
#define my_setNickname @"/index.php/Api/Account/nickname.html"
/** 设置性别 */
#define my_setSex @"/index.php/Api/Account/sex.html"
/** 修改密码 */
#define my_changePwd @"/index.php/Api/Password/modify.html"

/** 修改手机号短信-原手机短信验证 */
#define my_changePhoneOldSMS @"/index.php/Api/Setting/yz_sms.html"
/** 修改手机号短信-新手机短信验证 */
#define my_changePhoneNewSMS @"/index.php/Api/Setting/sms.html"
/** 修改手机号提交 */
#define my_changePhoneUrl @"/index.php/Api/Setting/mod_phone.html"


/** 实名认证-图片上传 */
#define my_realNameUpload @"/index.php/Api/Realname/image.html"
/** 实名认证-图片获取 */
#define my_getRealNamePic @"/index.php/Api/Realname/member_image.html"
/** 实名认证-地区选择 */
#define my_getAreaData @"/index.php/Api/Realname/area.html"
/** 实名认证-提交 */
#define my_RealName @"/index.php/Api/Realname/submit.html"
/** 实名认证-短信 */
#define my_realNameSMS @"/index.php/Api/Realname/sms.html"


/** 绑定银行卡 */
#define add_CashCard @"/index.php/Api/Cash/bind.html"
/** 提现卡信息（储蓄卡） */
#define CashCardInfo @"/index.php/Api/Cash/bank.html"
/** 绑定银行卡短信 */
#define add_cashCardSMS @"/index.php/Api/Cash/sms.html"

/** 提现信息 */
#define takeOutCashInfo @"/index.php/Api/Cash/info.html"
/** 提现申请-余额 */
#define takeOutCashApply @"/index.php/Api/Cash/apply.html"
/** 提现-记录 */
#define takeOutCashRecord @"/index.php/Api/Cash/log.html"



/** 资金流水-列表 */
#define my_moneyFlowList @"/index.php/Api/Money/index.html"
/** 资金流水-详情 */
#define my_moneyFlowDetail @"/index.php/Api/Money/info.html"

/** 我的上级 */
#define my_topFriend @"/index.php/Api/Spread/topfriend.html"
/** 我的会员 */
#define my_VIPFriend @"/index.php/Api/Spread/myfriend.html"
/** 我的会员列表 */
#define my_VIPFriendList @"/index.php/Api/Spread/myfriends.html"
/** 我的消息 */
#define my_MessageInfo @"/index.php/Api/Message/index.html"
/** 我的消息详情 */
#define my_MessageDetail @"/index.php/Api/Message/info.html"
/** 消息全部已读 */
#define my_MessageAllread @"/index.php/Api/Message/allread.html"
/** 公告通知 */
#define my_newsInfo @"/index.php/Api/News/index.html"
/** 公告通知详情 */
#define my_newsDetailInfo @"/index.php/Api/News/info.html"
/** 关于我们 */
#define my_aboutUS @"/index.php/Api/About/info.html"



/** 邀请 */
#define shareInfoUrl @"/index.php/Api/Spread/info.html"
/** 邀请推广记录 */
#define shareRecordUrl @"/index.php/Api/Spread/allrecord.html"

/** 获取银行数据 */
#define getBankData @"/index.php/Api/Realname/bank.html"

#endif /* NetApi_h */













