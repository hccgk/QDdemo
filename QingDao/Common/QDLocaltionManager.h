//
//  QDLocaltionManager.h
//  QingDao
//
//  Created by 何川 on 15/11/24.
//  Copyright © 2015年 hechuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

typedef void(^successLocal)(CLLocationCoordinate2D coordinate2D);
typedef void(^errorLocal)(NSError *error);

@interface QDLocaltionManager : NSObject

+(id)shareInstance;

+(void)localSuccess:(successLocal)success
          withError:(errorLocal)error;

@end
