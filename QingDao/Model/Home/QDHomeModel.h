//
//  QDHomeModel.h
//  QingDao
//
//  Created by 何川 on 15/11/25.
//  Copyright © 2015年 hechuan. All rights reserved.
//

#import <JSONModel/JSONModel.h>
@class QDFamousList;
@class QDFocusList;
@class QDGroupList;
@class QDGuessList;

@protocol QDFamousModel ;
@protocol QDFocusModel ;
@protocol QDGroupModel ;
@protocol QDGuessModel ;

#pragma 首页


@interface QDHomeModel : JSONModel

@property (nonatomic ,strong) QDFocusList *focus;
@property (nonatomic ,strong) QDGroupList *group;
@property (nonatomic, strong) QDFamousList *famous;
@property (nonatomic, strong) QDGuessList *guess;

@end

#pragma 名店推荐

@interface QDFamousList : JSONModel
@property(nonatomic , copy) NSArray <QDFamousModel> *list;


@end

@interface QDFamousModel : JSONModel
//id
//@property(nonatomic,assign) int id;
//封面字段
@property(nonatomic , copy) NSString *cover;
//距离字段
//@property(nonatomic,assign) int distance;
//简介
@property(nonatomic , copy) NSString *intro;
//名称
@property(nonatomic , copy) NSString *name;
//评分
@property(nonatomic,assign) int score;


@end

#pragma 分类
@interface QDGroupList:JSONModel
@property(nonatomic , copy) NSArray <QDGroupModel> *list;


@end

@interface QDGroupModel : JSONModel
//封面
@property(nonatomic , copy) NSString *cover;
//id
@property(nonatomic,assign) int id;
//标题
@property(nonatomic , copy) NSString *title;

@end


#pragma 广告Ads
@interface QDFocusList :JSONModel
@property(nonatomic , copy) NSArray <QDFocusModel> *list;

@end

@interface QDFocusModel : JSONModel
//封面
@property(nonatomic , copy) NSString *cover;
//id
@property(nonatomic,assign) int id;
//网页链接
@property(nonatomic , copy) NSString *link;
//资源id
@property(nonatomic , copy) NSString *res_id;
//资源名字
@property(nonatomic , copy) NSString *res_name;
//标题
@property(nonatomic , copy) NSString *title;

@end

#pragma 踩你喜欢
@interface QDGuessList :JSONModel
@property(nonatomic , copy) NSArray <QDGuessModel>  *list;
@end

@interface QDGuessModel : JSONModel
@property(nonatomic , copy) NSString *intro;
@property(nonatomic ,copy) NSString *title;
@property(nonatomic,assign) int orginalprice;
@property(nonatomic,assign) int price;
@property(nonatomic,assign) int score;
@property(nonatomic , copy) NSString *cover;
@property(nonatomic , copy) NSString *name;






//封面
//@property(nonatomic , copy) NSString *cover;
//@property(nonatomic,assign) int id;
////简介
//@property(nonatomic , copy) NSString *intro;
//@property(nonatomic , copy) NSString *price;
//@property(nonatomic , copy) NSString *title;


@end