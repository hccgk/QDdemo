//
//  QDFactory.m
//  QingDao
//
//  Created by 何川 on 15/11/21.
//  Copyright © 2015年 hechuan. All rights reserved.
//

#import "QDFactory.h"
@implementation QDFactory

+(UIButton*)type:(int)type
       withFrame:(CGRect)frame
       withTitle:(NSString*)title
      withTarget:(id)target
      withAction:(SEL)action
{
    UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
    bt.frame = frame;
    [bt setTitle:title forState:UIControlStateNormal];
    [bt addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return bt;
}

@end
