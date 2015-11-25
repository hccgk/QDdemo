//
//  QDLocaltionManager.m
//  QingDao
//
//  Created by 何川 on 15/11/24.
//  Copyright © 2015年 hechuan. All rights reserved.
//

#import "QDLocaltionManager.h"
#import <CoreLocation/CoreLocation.h>

@interface QDLocaltionManager ()<CLLocationManagerDelegate>
@property (nonatomic ,strong)CLLocationManager *manager;

@property(nonatomic ,copy)successLocal sLocal;
@property(nonatomic,copy)errorLocal eLocal;

//添加一个标志位--用于记录回调
@property(nonatomic,assign)BOOL local;
@end

@implementation QDLocaltionManager

-(id)init
{
    if (self = [super init]) {
        _manager = [[CLLocationManager alloc]init];
        
        if ([_manager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
            [_manager requestAlwaysAuthorization];
        }
        
        _manager.delegate = self;
    }
    return self;
}

+(id)shareInstance{
    static id manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc]init];
    });
    return manager;
}

+(void)localSuccess:(successLocal)success
          withError:(errorLocal)error
{
    [[self shareInstance] localSuccess:success withError:error];
}

-(void)localSuccess:(successLocal)success
          withError:(errorLocal)error
{
    [_manager startUpdatingLocation];
    _local = NO;
    _sLocal = success;
}


#pragma mark --CLLocationManagerDelegate

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    [_manager stopUpdatingLocation];
    self.eLocal(error);
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
   // DSLog(@"%@",locations.lastObject);
    [_manager stopUpdatingLocation];
    if (locations.count>0) {
        CLLocation *location = locations.lastObject;
        
        if (!_local) {
            self.sLocal(location.coordinate);
            _local = YES;
        }
    }
}

-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    if (status == kCLAuthorizationStatusDenied) {
        [_manager stopUpdatingLocation];
    }
}


@end






