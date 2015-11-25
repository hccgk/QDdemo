//
//  QDGroupList.h
//  QingDao
//
//  Created by 何川 on 15/11/25.
//  Copyright © 2015年 hechuan. All rights reserved.
//

#import <JSONModel/JSONModel.h>
@protocol QDGroup
@end

@interface QDGroupList : JSONModel

@property (nonatomic, strong) NSArray <QDGroup> *list;
@end
