//
//  xhq_header.h
//  Lazy
//
//  Created by 帝云科技 on 2018/3/9.
//  Copyright © 2018年 diyunkeji. All rights reserved.
//

#ifndef xhq_header_h
#define xhq_header_h

static NSString *const baseUrl = @"http://115.28.80.96:8093/api.php";


#pragma mark - ***章丘圈***

//章丘圈头部
static NSString *const zqCycle = @"?mod=forum&action=zqcircle";

//章丘圈动态
static NSString *const zqqFourm = @"?mod=forum&action=zqq_page";

//章丘圈圈友
static NSString *const zqqQuanYou = @"?mod=forum&action=qy_page";

//帖子详情
static NSString *const zqFourmDeail = @"?mod=forum&action=viewthread";

//日志详情
static NSString *const zqFourmBlogDeail = @"?mod=forum&action=blog_detail";

//日志表态
static NSString *const zqFourmBlogClick = @"?mod=forum&action=blog_click";

//帖子评论提交
static NSString *const zqFourmAddComment = @"?mod=forum&action=comment_add";

//日志帖子评论提交http://115.28.80.96:8093/api.php?mod=user&action=add_blog_comment
static NSString *const zqFourmAddBlogComment = @"?mod=user&action=add_blog_comment";

//帖子评论回复
static NSString *const zqFourmReplyComment = @"?mod=forum&action=comment_reply";

//帖子详情收藏
static NSString *const zqFourmDeailFav = @"?mod=forum&action=favtimes";

//帖子详情转发
static NSString *const zqFourmDeailZhuanfa = @"?mod=forum&action=feed";

//帖子详情分享
static NSString *const zqFourmDeailShare = @"?mod=forum&action=share";

//帖子详情支持
static NSString *const zqFourmDeailSupport = @"?mod=forum&action=recommend_add";

//帖子详情反对
static NSString *const zqFourmDeailAgainst = @"?mod=forum&action=recommend_sub";

// 举报
static NSString *const zqFourmReport = @"?mod=forum&action=report_add";

// 关注
static NSString *const zqFourmAddAttention = @"?mod=forum&action=follow";

// 取消关注
static NSString *const zqFourmCancleAttention = @"?mod=forum&action=nofollow";

//只看该作者
static NSString *const zqFourmOnlySeeAuthor = @"?mod=forum&action=authorself";

// 今日推荐
static NSString *const zqFourmRecommendDay = @"?mod=forum&action=recommend_day";

// 本周推荐
static NSString *const zqFourmRecommendWeek = @"?mod=forum&action=recommend_week";

// 本月推荐
static NSString *const zqFourmRecommendMonth = @"?mod=forum&action=recommend_month";

// 全部推荐
static NSString *const zqFourmRecommendAll = @"?mod=forum&action=recommend_all";

// 论坛全部板块
static NSString *const zqFourmAllPlate = @"?mod=forum&action=all_plate";

// 论坛模块-收藏
static NSString *const zqFourmPlateCollect = @"?mod=forum&action=plate_collect";

// 栏目板块下帖子
static NSString *const zqFourmPlate_List = @"?mod=forum&action=plate_list";

// 模块-最新发布
static NSString *const zqFourmPlateNewthread = @"?mod=forum&action=newthread";

// 模块-最新回复
static NSString *const zqFourmPlateNewreply = @"?mod=forum&action=newreply";

// 模块-精华热帖
static NSString *const zqFourmPlateHeatthread = @"?mod=forum&action=heatthread";

// 版规列表
static NSString *const zqFourmCopyList = @"?mod=forum&action=threadset";

// 版规列表详情
static NSString *const zqFourmCopyListDetail = @"?mod=forum&action=threadset_detail";

// 搜索
static NSString *const zqFourmSearch = @"?mod=forum&action=search";

// 邀请好友
static NSString *const zqFourmInviteFriend = @"?mod=user&action=invite_friend";





#endif /* xhq_header_h */
