//
//  QDGroup.h
//  QingDao
//
//  Created by 何川 on 15/11/25.
//  Copyright © 2015年 hechuan. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface QDGroup : JSONModel

@property(nonatomic,copy)NSString * title;
@property(nonatomic,assign)int  id;

@property(nonatomic,copy)NSString * cover;

@end
