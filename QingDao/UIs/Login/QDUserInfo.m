//
//  QDUserInfo.m
//  QingDao
//
//  Created by 何川 on 15/11/27.
//  Copyright © 2015年 hechuan. All rights reserved.
//

#import "QDUserInfo.h"

@implementation QDUserInfo



+(instancetype)shareInstance
{
    static QDUserInfo *user = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        QDUserInfo *user = [[QDUserInfo alloc]init];
        user.isLogin = NO;
        
    });
    return user;
}
-(void)instanceWithDict:(NSDictionary *)dic
{
    if ([dic isKindOfClass:[NSDictionary class]]) {
        
        self.user_id = dic[@"user_id"];
        self.info = dic[@"info"];
        self.mobile = dic[@"mobile"];
        self.remember_me = dic[@"remember_me"];
        self.nick_name = dic[@"nick_name"];
        self.small_avatar = dic[@"small_avatar"];
        self.middle_avatar = dic[@"middle_avatar"];
        self.user_name = dic[@"user_name"];
        self.gender = dic[@"gender"];
        self.isLogin = YES;
    }
}
@end
