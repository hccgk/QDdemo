//
//  Constant.h
//  QingDao
//
//  Created by 何川 on 15/11/21.
//  Copyright © 2015年 hechuan. All rights reserved.
//

#ifndef Constant_h
#define Constant_h

#ifdef DEBUG   

#define DSLog(...) NSLog(__VA_ARGS__)

#else

#define DSLog(...)

#endif

#pragma mark--系统值

#define kUIScreenWidth [UIScreen mainScreen].bounds.size.width
#define kUIScreenHeight [UIScreen mainScreen].bounds.size.height
#define kUIScreenBounds [UIScreen mainScreen].bounds
#define kUINavHeight 64
#define kUIStatusBarHeight 20
#define kUITabBarHeight 49

#pragma mark --key-value

#define kFirstLanuch @"kLFGuideVCFirstLanuch"
#define kLogin_remember @"Login_remember"
#define kLogin_userName @"Login_userName"

#pragma mark --通知

#define kNotificationGuideEnter @"kNotificationGuideEnter"


/*
 宏定义    颜色值
 */
#pragma color

#define kColor(R,G,B) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1.0]

#define kButtonColor [UIColor colorWithRed:45/255.0 green:156/255.0 blue:239/255.0 alpha:1.0]

#define Login_Deep_Color    kColor(60, 168, 245)
#define Login_Light_Color   kColor(103, 196, 255)

#pragma mark -- 接口调试

#define APP_ID  @"1001"
#define APP_IDENTIFER  @"5bV9JhaMn2GJ5MZe"

#define kBaseURL        @"http://www.qd-life.com/"
#endif /* Constant_h */
