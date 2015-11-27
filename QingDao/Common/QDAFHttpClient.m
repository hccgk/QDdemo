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

+ (void)postUrlString:(NSString *)url
            withParam:(NSDictionary *)param
     withSuccessBlock:(successLoadData)success
      withFailedBlock:(failLoadData)failed
       withErrorBlock:(errorBlock)error{
    
    [[self shareInstance] POST:url parameters:param success:^(NSURLSessionDataTask *task, NSDictionary  *responseObject) {
        
        NSString *status = responseObject[@"status"];
        NSLog(@"请求成功,但是不一定正确,服务器有响应");
        if ([status isEqualToString:@"success"]) {
            success(responseObject);
            
        }else if ([status isEqualToString:@"failed"]){
            error(@"there is something wrong with the request");
        }
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        failed(error);
        
    }];
    
}

@end
