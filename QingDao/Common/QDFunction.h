//
//  QDFunction.h
//  QingDao
//
//  Created by 何川 on 15/11/23.
//  Copyright © 2015年 hechuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QDFunction : NSObject

+(void)saveValue:(BOOL)vale forKey:(NSString *)key;

//返回一个时间戳
+ (NSString *)getTime;

+ (NSString *)signMD5String:(NSArray *)array;

+ (BOOL)getBooleaValueFromKey:(NSString *)key;
+ (id)getObjectValueFromKey:(NSString *)key;

+ (void)saveObjectValue:(id)object withKey:(NSString *)key;
+ (void)saveUserInfo:(NSDictionary *)dic;
+ (void)saveBooleanValue:(BOOL)boolean withKey:(NSString *)key;
@end
