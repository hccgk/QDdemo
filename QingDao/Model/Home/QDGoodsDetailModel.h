//
//  QDGoodsDetailModel.h
//  QingDao
//
//  Created by 何川 on 15/11/25.
//  Copyright © 2015年 hechuan. All rights reserved.
//

#import <JSONModel/JSONModel.h>
@protocol QDGoodsDetailModel;

@interface QDGoodsDetailListModel : JSONModel
//地址
@property(nonatomic , copy) NSString *address;
//内容
@property(nonatomic , copy) NSString *content;

//goods_snapshot_id

@property(nonatomic,assign) int goods_snapshot_id;

//id
@property(nonatomic,assign) int id;;
//纬度
@property(nonatomic , copy) NSString *lat;
//经度
@property(nonatomic , copy) NSString *lon;
//phone
@property(nonatomic , copy) NSString *phone;
//price
@property(nonatomic , copy) NSString *price;
//商家id
@property(nonatomic,assign) int shop_id;
//商家名称
@property(nonatomic , copy) NSString *shop_name;
//分类
@property(nonatomic , copy) NSString *title;
//推荐
@property (nonatomic, strong) NSArray <QDGoodsDetailModel> *goods_list;

@end


@interface QDGoodsDetailModel : JSONModel
//id
@property(nonatomic,assign) int id;
//名字
@property(nonatomic , copy) NSString *name;
//封面
@property(nonatomic , copy) NSString *cover;
//商家名字
@property(nonatomic , copy) NSString *shop_name;
//得分
@property(nonatomic,assign) int score;
//距离
@property(nonatomic,assign) int distance;


@end








