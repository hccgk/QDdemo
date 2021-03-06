//
//  QDAFHttpClient.h
//  QingDao
//
//  Created by 何川 on 15/11/24.
//  Copyright © 2015年 hechuan. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

typedef void(^successLoadData)(id QDHomeModel);
typedef void(^failLoadData)(NSError *error);
typedef void (^errorBlock)(NSString *message);



@interface QDAFHttpClient : AFHTTPSessionManager

+(id)shareInstance;

+(void)getHomewithParams:(NSDictionary*)param
        withSuccessBlock:(successLoadData)success
           withFailBlock:(failLoadData)failed;

+(void)getURL:(NSString*)url
   withParams:(NSDictionary*)param
withSuccessBlock:(successLoadData)success
withFailBlock:(failLoadData)failed;

+(void)postURL:(NSString*)url
    withParams:(NSDictionary*)param
withSuccessBlock:(successLoadData)success
 withFailBlock:(failLoadData)failed;

+ (void)postUrlString:(NSString *)url
            withParam:(NSDictionary *)param
     withSuccessBlock:(successLoadData)success
      withFailedBlock:(failLoadData)failed
       withErrorBlock:(errorBlock)error;
@end
