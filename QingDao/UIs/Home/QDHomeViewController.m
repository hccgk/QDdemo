//
//  QDHomeViewController.m
//  QingDao
//
//  Created by 何川 on 15/11/22.
//  Copyright © 2015年 hechuan. All rights reserved.
//

#import "QDHomeViewController.h"
#import "QDLoginViewController.h"
#import "MD5.h"
@interface QDHomeViewController ()

@end

@implementation QDHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self showLoadView];
    [self performSelector:@selector(dismissLoadView) withObject:nil afterDelay:2.0];
    [self showToast:@"testme"];//为什么没有显示
    self.leftButton.hidden = YES;
    
    [self loadData];
}


-(void)loginMethod
{
    QDLoginViewController *login = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"QDLoginViewController"];
    AppDelegate *app = [UIApplication sharedApplication].delegate;
    [app.tab showOrHiddenTabbarView:YES];
    [self.navigationController pushViewController:login animated:YES];
}

-(void)loadData
{
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL
                                                                                   URLWithString:@"http://www.qd-life.com/?anu=api/1/index/get_index_info"]];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //拼接参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:@"120.38" forKey:@"lon"];
    [params setValue:@"36.06" forKey:@"lat"];
    NSString *time = [NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSince1970]];
    [params setValue:time forKey:@"time"];
    NSString *signStr = [NSString stringWithFormat:@"%@%@%@%@%@",
                         APP_ID,params[@"lon"],params[@"lat"],params[@"time"],
                         APP_IDENTIFER];
    
    NSString *md5String = [MD5 MD5Encrypt:signStr];
    [params setValue:md5String forKey:@"sign"];
    [params setValue:APP_ID forKey:@"app_id"];
    //打印参数
    DSLog(@"params:%@",params);
    //请求
    [manager GET:@"" parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        DSLog(@"responseObject:%@",responseObject);
        NSString *str = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        DSLog(@"UTF8responseObject:%@",str);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        DSLog(@"NSError:%@",error);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
