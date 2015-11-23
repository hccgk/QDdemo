//
//  QDFunction.m
//  QingDao
//
//  Created by 何川 on 15/11/23.
//  Copyright © 2015年 hechuan. All rights reserved.
//

#import "QDFunction.h"

@implementation QDFunction

+(void)saveValue:(BOOL)vale forKey:(NSString *)key
{
    [[NSUserDefaults standardUserDefaults] setBool:vale forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

@end
