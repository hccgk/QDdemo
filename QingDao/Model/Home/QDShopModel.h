//
//  QDShopModel.h
//  QingDao
//
//  Created by 何川 on 15/11/25.
//  Copyright © 2015年 hechuan. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol QDCommentModel;
@protocol QDGoodsModel;

@interface QDShopModel : JSONModel

//评论列表
@property(nonatomic , copy) NSArray <QDCommentModel> *comment_list;

//商品列表
@property(nonatomic , copy) NSArray <QDGoodsModel> *goods;

//地址
@property(nonatomic , copy) NSString *address;

//评论总数
@property(nonatomic,assign) int comment_totalPage;
//封面
@property(nonatomic , copy) NSString *cover;
//id
@property(nonatomic,assign) int id;
//简介
@property(nonatomic , copy) NSString *intro;
//纬度
@property(nonatomic , copy) NSString *lat;
//经度
@property(nonatomic , copy) NSString *lon;
//名字
@property(nonatomic , copy) NSString *name;
//电话
@property(nonatomic , copy) NSString *phone;
//评分
@property(nonatomic,assign) int score;
//服务类型
@property(nonatomic , copy) NSString *server;
//总页数
@property(nonatomic,assign) int totalPage;

@end

@interface QDcommetModel : JSONModel

//头像
@property(nonatomic , copy) NSString *avatar;
//内容
@property(nonatomic , copy) NSString *content;
//时间
@property(nonatomic , copy) NSString *date;
//id
@property(nonatomic,assign) int id;
//名字
@property(nonatomic , copy) NSString *name;
//得分
@property(nonatomic,assign) int score;
//用户id
@property(nonatomic,assign) int user_id;

@end

@interface QDGoodsModel : JSONModel

//id
@property(nonatomic,assign) int id;
//标题
@property(nonatomic , copy) NSString *title;
//价格
@property(nonatomic , copy) NSString *price;
//简介
@property(nonatomic , copy) NSString *intro;


@end
