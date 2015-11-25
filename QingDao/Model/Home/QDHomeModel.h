//
//  QDHomeModel.h
//  QingDao
//
//  Created by 何川 on 15/11/25.
//  Copyright © 2015年 hechuan. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "QDfocusList.h"
@interface QDHomeModel : JSONModel

@property (nonatomic ,strong) QDfocusList *focus;
@end
