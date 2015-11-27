//
//  QDUserInfo.h
//  QingDao
//
//  Created by 何川 on 15/11/27.
//  Copyright © 2015年 hechuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QDUserInfo : NSObject

/*用户id*/
@property (nonatomic, copy) NSString *user_id;
/*性别*/
@property (nonatomic, copy) NSString *gender;
/*电话*/
@property (nonatomic, copy) NSString *mobile;
/*姓名*/
@property (nonatomic, copy) NSString *user_name;
/*昵称*/
@property (nonatomic, copy) NSString *nick_name;
/*小头像*/
@property (nonatomic, copy) NSString *small_avatar;
/*中头像*/
@property (nonatomic, copy) NSString *middle_avatar;
/*cookie字段*/
@property (nonatomic, copy) NSString *remember_me;
/*info*/
@property (nonatomic, copy) NSString *info;

/*加一个字段，用于记录是否登陆成功*/
@property (nonatomic, assign) BOOL isLogin;



+(instancetype)shareInstance;
-(void)instanceWithDict:(NSDictionary *)dict;
@end
