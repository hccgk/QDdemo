//
//  QDfocusList.h
//  QingDao
//
//  Created by 何川 on 15/11/24.
//  Copyright © 2015年 hechuan. All rights reserved.
//

#import <JSONModel/JSONModel.h>
@protocol QDFocus
@end

@interface QDfocusList : JSONModel

@property(nonatomic ,strong)NSArray <QDFocus> *list;
@end
