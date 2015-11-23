//
//  QDFactory.h
//  QingDao
//
//  Created by 何川 on 15/11/21.
//  Copyright © 2015年 hechuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface QDFactory : NSObject
+(UIButton*)type:(int)type
       withFrame:(CGRect)frame
       withTitle:(NSString*)title
      withTarget:(id)target
      withAction:(SEL)action;
@end
