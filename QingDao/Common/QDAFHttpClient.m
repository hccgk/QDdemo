//
//  QDAFHttpClient.m
//  QingDao
//
//  Created by 何川 on 15/11/24.
//  Copyright © 2015年 hechuan. All rights reserved.
//

#import "QDAFHttpClient.h"
#import "QDHomeModel.h"

@interface QDAFHttpClient()
@property (nonatomic, strong) QDHomeModel *homeModel;

@end
@implementation QDAFHttpClient

//2.
+(id)shareInstance
{
    static QDAFHttpClient *client = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        client = [[QDAFHttpClient alloc]initWithBaseURL:[NSURL URLWithString:kBaseURL]];
        client.responseSerializer = [AFHTTPResponseSerializer serializer];
    });
    return client;
}

//4.
-(void)getURL:(NSString*)url
   withParams:(NSDictionary*)param
withSuccessBlock:(successLoadData)success
withFailBlock:(failLoadData)failed
{
    [self GET:url parameters:param success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        success(responseObject);
       // NSLog(@"responseObjectresponseObjectresponseObject:%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failed(error);
    }];
}

+(void)getURL:(NSString*)url
   withParams:(NSDictionary*)param
withSuccessBlock:(successLoadData)success
withFailBlock:(failLoadData)failed
{
    [[self shareInstance]getURL:url withParams:param withSuccessBlock:success withFailBlock:failed];
}

+(void)postURL:(NSString*)url
    withParams:(NSDictionary*)param
withSuccessBlock:(successLoadData)success
 withFailBlock:(failLoadData)failed
{
    
}
-(void)postURL:(NSString*)url
    withParams:(NSDictionary*)param
withSuccessBlock:(successLoadData)success
 withFailBlock:(failLoadData)failed
{
    
}

//1.
+(void)getHomewithParams:(NSDictionary*)param
        withSuccessBlock:(successLoadData)success
           withFailBlock:(failLoadData)failed
{
    [[self shareInstance]getHomewithParams:param withSuccessBlock:success
                             withFailBlock:failed];
}
//3.
-(void)getHomewithParams:(NSDictionary*)param
         withSuccessBlock:(successLoadData)success
            withFailBlock:(failLoadData)failed
{
    [self getURL:@"?anu=api/1/index/get_index_info" withParams:param withSuccessBlock:^(id data) {
        NSString *path =[[NSBundle mainBundle]pathForResource:@"home" ofType:@"plist"];
        NSDictionary *dic = [[NSDictionary alloc]initWithContentsOfFile:path];
        _homeModel = [[QDHomeModel alloc]initWithDictionary:dic error:nil];
        success(_homeModel);
    } withFailBlock:failed];
}

#pragma mark---
-(void)getURL:(NSString*)url
withParams:(NSDictionary *)param
withClassName:(NSString*)name
withSuccessBlock:(successLoadData)success
withFailBlock:(failLoadData)failed
{
    [self GET:url parameters:param success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        Class cl = NSClassFromString(name);
        success([[cl alloc]initWithDictionary:responseObject]);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failed(error);
    }];
}



@end
