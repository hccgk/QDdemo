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

#pragma mark --通知

#define kNotificationGuideEnter @"kNotificationGuideEnter"

#endif /* Constant_h */
