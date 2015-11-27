//
//  QDFunction.m
//  QingDao
//
//  Created by 何川 on 15/11/23.
//  Copyright © 2015年 hechuan. All rights reserved.
//

#import "QDFunction.h"
#import "MD5.h"

@implementation QDFunction

+(void)saveValue:(BOOL)vale forKey:(NSString *)key
{
    [[NSUserDefaults standardUserDefaults] setBool:vale forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

+ (NSString *)getTime
{
 
    return  [NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSince1970]];
    
}

+ (NSString *)signMD5String:(NSArray *)array
{
    NSMutableString *signStr = [NSMutableString string];
    [array enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL * _Nonnull stop) {

        [signStr appendString:obj];
    
    }];
    
    return  [MD5 MD5Encrypt:signStr];
    
}


+ (BOOL)getBooleaValueFromKey:(NSString *)key{
    if (key != nil) {
        return [[NSUserDefaults standardUserDefaults]boolForKey:key];
        
    }
    else
        return NULL;
    
}

+ (id)getObjectValueFromKey:(NSString *)key{
 
    if (key != nil) {
        return [[NSUserDefaults standardUserDefaults]objectForKey:key];
    }
    else
        return NULL;
}


+ (void)saveObjectValue:(id)object withKey:(NSString *)key{
    
    if (key != nil) {
        [[NSUserDefaults standardUserDefaults] setObject:object forKey:key];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
    }
    
}

+ (void)saveUserInfo:(NSDictionary *)dic{
    
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"user.info"];
    
    [dic writeToFile:path atomically:YES];
    
}
+ (void)saveBooleanValue:(BOOL)boolean withKey:(NSString *)key{
    
    if (key != nil) {
        [[NSUserDefaults standardUserDefaults] setBool:boolean forKey:key];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
    }
    
}
@end











