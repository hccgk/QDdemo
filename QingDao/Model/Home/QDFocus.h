//
//  QDFocus.h
//  QingDao
//
//  Created by 何川 on 15/11/24.
//  Copyright © 2015年 hechuan. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface QDFocus : JSONModel
//焦点图标题
@property (nonatomic,strong)NSString *title;
//图片链接
@property (nonatomic,strong)NSString *cover;
//所要跳转的基础连接
@property (nonatomic,strong)NSString *link;
//跳转到指定的模块
@property (nonatomic,strong)NSString *res_name;
//指定模块下的详情ID
@property (nonatomic,strong)NSString *res_id;
//焦点图ID
@property (nonatomic,assign)int id;
@end
