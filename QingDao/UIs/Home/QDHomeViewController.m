//
//  QDHomeViewController.m
//  QingDao
//
//  Created by 何川 on 15/11/22.
//  Copyright © 2015年 hechuan. All rights reserved.
//

#import "QDHomeViewController.h"
#import "QDLoginViewController.h"
#import "QDLocaltionManager.h"
#import <CoreLocation/CoreLocation.h>
#import "QDHomeModel.h"
#import "QDAdsTableViewCell.h"
#import "QDGroupTableViewCell.h"
@interface QDHomeViewController ()<CLLocationManagerDelegate,UITableViewDelegate,UITableViewDataSource,QDGroupTableViewCellDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) QDAdsTableViewCell *header;
@property (nonatomic, strong) QDGroupTableViewCell *gCell;
@property (nonatomic,strong) QDHomeModel *homeModel;
@end

@implementation QDHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self showLoadView];
    [self performSelector:@selector(dismissLoadView) withObject:nil afterDelay:2.0];
    [self showToast:@"testme"];//为什么没有显示
    self.leftButton.hidden = YES;
  //  self.tableView.delegate = self;
  //  self.tableView.dataSource = self;
    [self loadData];
    //定位
    [QDLocaltionManager localSuccess:^(CLLocationCoordinate2D coordinate2D) {
        DSLog(@"Localtion:%f",coordinate2D.latitude);
    } withError:^(NSError *error) {
        DSLog(@"Localtion Error:%@",error);
    }];
     //注册cell
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    //给table设置header
    _header = [[[NSBundle mainBundle]loadNibNamed:@"QDAdsTableViewCell" owner:nil options:nil] objectAtIndex:0];
    self.tableView.tableHeaderView = _header;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
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
//    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL
//                                                                                   URLWithString:@"http://www.qd-life.com/?anu=api/1/index/get_index_info"]];
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //拼接参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:@"120.38" forKey:@"lon"];
    [params setValue:@"36.06" forKey:@"lat"];
    
   // NSString *time = [NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSince1970]];
    [params setValue:[QDFunction getTime] forKey:@"time"];
    //NSString *signStr = [NSString stringWithFormat:@"%@%@%@%@%@",
//                         APP_ID,params[@"lon"],params[@"lat"],params[@"time"],
//                         APP_IDENTIFER];
     //NSString *md5String = [MD5 MD5Encrypt:signStr];
    NSArray *temp  = @[APP_ID,params[@"lon"],params[@"lat"],params[@"time"],APP_IDENTIFER];
    
    [params setValue:[QDFunction signMD5String:temp] forKey:@"sign"];
    [params setValue:APP_ID forKey:@"app_id"];
    //打印参数
    DSLog(@"params:%@",params);
    //请求
//    [manager GET:@"" parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
//        DSLog(@"responseObject:%@",responseObject);
//        NSString *str = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
//        DSLog(@"UTF8responseObject:%@",str);
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        DSLog(@"NSError:%@",error);
//    }];
    [QDAFHttpClient getHomewithParams:params withSuccessBlock:^(QDHomeModel *data) {
       // DSLog(@"QDHomeModel:%@",data);//QDFocusModel
        _homeModel = data;
        QDFocusList *f = data.focus;
        _header.list = f;

    } withFailBlock:^(NSError *error) {
        DSLog(@"%@",error);
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
#pragma UITableViewDatasource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0 || section == 1) {
        return 1;
    }else if (section == 2){
        return _homeModel.guess.list.count;
    }else
        return 0;}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    static NSString *resuse = @"cell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:resuse forIndexPath:indexPath];
//    return cell;
    if (indexPath.section == 0) {
        //
        static NSString *identifer = @"QDGroupTableViewCell";
        
        QDGroupTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
        
        if ( cell == nil) {
            cell = [[[UINib nibWithNibName:identifer bundle:nil]instantiateWithOwner:self options:nil]objectAtIndex:0];
        }
        
        if (_homeModel != nil) {
            
            cell.list = _homeModel.group;
            cell.delegate = self;
            
        }
        return cell;


    }
//    else
//        if (indexPath.section == 1) {
//            //
//            static NSString *identifer = @"QDGroupTableViewCell";
//            
//            QDGroupTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
//            
//            if ( cell == nil) {
//                cell = [[[UINib nibWithNibName:identifer bundle:nil]instantiateWithOwner:self options:nil]objectAtIndex:0];
//            }
//            
//            if (_homeModel != nil) {
//                
//                cell.list = _homeModel.group;
//                cell.delegate = self;
//                
//            }
//            return cell;
//
//        }
//    else
//        if (indexPath.section ==2) {
//            //
//            return cell;
//
//        }
    else
        return NULL;
   
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section ==0) {
        return 200;
    }else if (indexPath.section == 1)
    {
        return 200;
    }else
        return 105;
}

#pragma 分组代理方法
- (void)didItemSelected:(NSInteger)index{
    
    NSLog(@"我点击了第%ld个",index);
    
}

@end










