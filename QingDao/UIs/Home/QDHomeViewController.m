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
#import "QDFamousTableViewCell.h"
#import "QDGuessTableViewCell.h"
@interface QDHomeViewController ()<CLLocationManagerDelegate,UITableViewDelegate,UITableViewDataSource,QDGroupTableViewCellDelegate,QDFamousTableViewCellDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) QDAdsTableViewCell *header;
@property (nonatomic, strong) QDGroupTableViewCell *gCell;
@property (nonatomic, strong) QDFamousTableViewCell *fCell;
@property (nonatomic,strong) QDHomeModel *homeModel;
@end

@implementation QDHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];

    [self showLoadView];
    [self performSelector:@selector(dismissLoadView) withObject:nil afterDelay:1.0];
    [self showToast:@"testme"];//为什么没有显示
    self.leftButton.hidden = YES;
  //  self.tableView.delegate = self;
  //  self.tableView.dataSource = self;
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


//-(void)loginMethod
//{    
//}

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
        _fCell.list = data.famous;
        [_tableView reloadData];

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
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0 || section == 1) {
        return 1;
    }else if (section == 2){
        return _homeModel.guess.list.count;
    }else
        return 0;
   // return 1;
}
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
    else
        if (indexPath.section == 1) {
            //
            static NSString *identifer = @"QDFamousTableViewCell";
            
            QDFamousTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
            
            if ( cell == nil) {
                cell = [[[UINib nibWithNibName:identifer bundle:nil]instantiateWithOwner:self options:nil]objectAtIndex:0];
            }
            
            if (_homeModel != nil) {
                
                cell.list = _homeModel.famous;
                cell.delegate = self;
                
            }
            return cell;

        }
    else
        if (indexPath.section ==2) {
            //
            static NSString *identifer = @"QDGuessTableViewCell";
            
            QDGuessTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
            
            if ( cell == nil) {
                cell = [[[UINib nibWithNibName:identifer bundle:nil]instantiateWithOwner:self options:nil]objectAtIndex:0];
            }
            
            if (_homeModel != nil) {
                
                cell.model = _homeModel.guess.list[0];
               // cell.delegate = self;
                
            }
            return cell;

        }
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

#pragma UITableViewDelegate

#define kUITableViewHeightForHeader 78/2.0

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0 ) {
        return 0;
    }
    else
        return kUITableViewHeightForHeader;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kUIScreenWidth, kUITableViewHeightForHeader)];
    //view.backgroundColor = [UIColor blackColor];
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kUIScreenWidth, 6)];
    line.backgroundColor = [UIColor lightGrayColor];
    [view addSubview:line];
    
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 100, 30)];
    
    title.textColor = [UIColor colorWithRed:233/255.0 green:76/255.0 blue:80/255.0 alpha:1.0];
    
    [view addSubview:title];
    
    UIView *sep = [[UIView alloc]initWithFrame:CGRectMake(0, kUITableViewHeightForHeader - 0.5, kUIScreenWidth, 0.5)];
    sep.backgroundColor = [UIColor lightGrayColor];
    [view addSubview:sep];
    
    if (section == 1) {
        title.text = @"名店推荐";
    }else if (section == 2){
        title.text = @"猜你喜欢";
    }
    
    return view;
}

#pragma 分组代理方法
- (void)didItemSelected:(NSInteger)index{
    
    NSLog(@"我点击了第%ld个",index);
    
}
- (void)didFamousItemClick:(NSInteger)index
{
    NSLog(@"我点击了名店的第%ld个",index);

}
@end










