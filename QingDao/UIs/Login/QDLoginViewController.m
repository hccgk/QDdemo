//
//  QDLoginViewController.m
//  QingDao
//
//  Created by 何川 on 15/11/23.
//  Copyright © 2015年 hechuan. All rights reserved.
//

#import "QDLoginViewController.h"
#import "AppDelegate.h"
#import "QDHTTPClient.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
#import "QDFunction.h"
#import "SSKeychain.h"
#import "QDUserInfo.h"
#import "QDThirdCollectionViewCell.h"

static NSString *identier = @"QDThirdCollectionViewCell";

@interface QDLoginViewController ()
@property (weak, nonatomic) IBOutlet UIView *userView;
@property (weak, nonatomic) IBOutlet UIImageView *userLoginImageView;
@property (weak, nonatomic) IBOutlet UITextField *userLoginTextField;

@property (weak, nonatomic) IBOutlet UIView *passwordView;
@property (weak, nonatomic) IBOutlet UIImageView *passwordImageView;
@property (weak, nonatomic) IBOutlet UITextField *passwrodTextField;

@property (weak, nonatomic) IBOutlet UIButton *remButton;
@property (weak, nonatomic) IBOutlet UIButton *forgetButton;
@property (weak, nonatomic) IBOutlet UIButton *loginInButton;
@property (weak, nonatomic) IBOutlet UIButton *asignButton;
@property (weak, nonatomic) IBOutlet UIButton *remembButton;

@property (weak, nonatomic) IBOutlet UILabel *thirdLabel;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flowLayout;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

- (IBAction)remAction:(UIButton *)sender;
- (IBAction)loginAction:(UIButton *)sender;
- (IBAction)remembAction:(id)sender;

- (IBAction)forgetAction:(id)sender;


@property (nonatomic, strong) NSMutableArray *shareArray;

@end

@implementation QDLoginViewController


//初始化,sb启动时候执行
-(void)awakeFromNib
{
    _shareArray = [NSMutableArray array];
    
    [_shareArray addObject:@{@"name":@"新浪",@"icon":@"login_wb"}];
    [_shareArray addObject:@{@"name":@"QQ",@"icon":@"login_qq"}];
    [_shareArray addObject:@{@"name":@"微信",@"icon":@"login_wx"}];
    [_shareArray addObject:@{@"name":@"豆瓣",@"icon":@"login_db"}];
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    
   // [_collectionView registerClass:[_collectionView class] forCellReuseIdentifier:identier];
    
//    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:identier];
    
    self.titleLabel.text = @"登录";
    self.rightButton.hidden = YES;
    
    _userView.backgroundColor = Login_Light_Color;
    _userView.layer.cornerRadius = 5;
    _userView.clipsToBounds = YES;
    _userLoginImageView.backgroundColor = Login_Deep_Color;
    _userLoginTextField.clipsToBounds = YES;
    _userLoginTextField.backgroundColor = Login_Light_Color;
    
    _passwordView.backgroundColor = Login_Light_Color;
    _passwordView.layer.cornerRadius = 5;
    _passwordView.clipsToBounds = YES;
    _passwordImageView.backgroundColor = Login_Deep_Color;
    _passwrodTextField.backgroundColor = Login_Light_Color;
    
    [_remButton setTitleColor:Login_Light_Color forState:UIControlStateNormal];
    [_forgetButton setTitleColor:Login_Light_Color forState:UIControlStateNormal];
    [_remembButton setTitleColor:Login_Light_Color forState:UIControlStateNormal];
    //下划线
    NSMutableAttributedString *str =[[NSMutableAttributedString alloc]initWithString:@"忘记密码"];
    NSRange strRange = {0,str.length};
    [str addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:1] range:strRange];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:0.131 green:0.183 blue:0.942 alpha:1.000] range:strRange];
    NSMutableAttributedString *str1 =[[NSMutableAttributedString alloc]initWithString:@"记住密码"];
    NSRange strRange1 = {0,str1.length};
    [str1 addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:1] range:strRange1];
    [str1 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:0.131 green:0.183 blue:0.942 alpha:1.000] range:strRange1];

    
    [_forgetButton setAttributedTitle:str forState:UIControlStateNormal];
    [_remembButton setAttributedTitle:str1 forState:UIControlStateNormal];
    
    _loginInButton.backgroundColor = Login_Deep_Color;
    _loginInButton.layer.cornerRadius = 5;
    _loginInButton.clipsToBounds = YES;
    _loginInButton.enabled = NO;
    
    [_asignButton setTitleColor:[UIColor cyanColor] forState:UIControlStateNormal];
    _collectionView.backgroundColor = [UIColor whiteColor];
//    NSLog(@"_collectionView:%ld",_collectionView.frame.size.width / 4);
//    _flowLayout.itemSize = CGSizeMake(self.collectionView.frame.size.width/4.0, _collectionView.frame.size.height);
// //   _flowLayout.itemSize = CGSizeMake(_collectionView.frame.size.width / 4, _collectionView.frame.size.height);

    
    
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    _flowLayout.itemSize = CGSizeMake(self.collectionView.frame.size.width/5, _collectionView.frame.size.height);
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
  
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeLoginButtonStatus) name:UITextFieldTextDidChangeNotification object:nil];
    //读取帐号
    
    BOOL remember = [QDFunction getBooleaValueFromKey:kLogin_remember];
    
    if (remember) {
        [_remButton setBackgroundImage:[UIImage imageNamed:@"btn_selected"] forState:UIControlStateNormal];
        _remButton.selected = YES;
        NSString *userName = [QDFunction getObjectValueFromKey:kLogin_userName];
        
        if (userName != nil) {
            _userLoginTextField.text =userName;
            _passwrodTextField.text = [SSKeychain passwordForService: [NSBundle mainBundle].bundleIdentifier account:userName];
            _loginInButton.enabled  = YES;
        }
    }else
    {
        [_remButton setBackgroundImage:[UIImage imageNamed:@"btn_normal"] forState:UIControlStateNormal];
        _remButton.selected = NO;
    }
    
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
    
}

-(void)changeLoginButtonStatus
{
    if (_userLoginTextField.text.length>0 && _passwrodTextField.text.length>0) {
        _loginInButton.enabled = YES;
        
    }else
    {
        _loginInButton.enabled = NO;
        
    }
}

-(void)backMethod
{
    [self.navigationController popViewControllerAnimated:YES];
    
    AppDelegate *app = (AppDelegate*)[UIApplication sharedApplication].delegate;
    [app.tab showOrHiddenTabbarView:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark -- 键盘消失
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [_userLoginTextField resignFirstResponder];
    [_passwrodTextField resignFirstResponder];
    
    
}

#pragma UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    NSLog(@"%ld",_shareArray.count);
    return  _shareArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    QDThirdCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identier forIndexPath:indexPath];

    cell.data = _shareArray[indexPath.row];
    
    return cell;
    
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
   
    
    if (indexPath.row == 1) {
            //例如QQ的登录
    [ShareSDK getUserInfo:SSDKPlatformTypeQQ
           onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error)
     {
         if (state == SSDKResponseStateSuccess)
         {
             
             NSLog(@"uid=%@",user.uid);
             NSLog(@"%@",user.credential);
             NSLog(@"token=%@",user.credential.token);
             NSLog(@"nickname=%@",user.nickname);
         }
         
         else
         {
             NSLog(@"%@",error);
         }
         
     }];
        
    } else if(indexPath.row == 0)
    {
        [ShareSDK getUserInfo:SSDKPlatformTypeSinaWeibo
               onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error)
         {
             if (state == SSDKResponseStateSuccess)
             {
                 
                 NSLog(@"uid=%@",user.uid);
                 NSLog(@"%@",user.credential);
                 NSLog(@"token=%@",user.credential.token);
                 NSLog(@"nickname=%@",user.nickname);
             }
             
             else
             {
                 NSLog(@"%@",error);
             }
             
         }];
    }else if(indexPath.row == 2)
    {
        [ShareSDK getUserInfo:SSDKPlatformTypeWechat
               onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error)
         {
             if (state == SSDKResponseStateSuccess)
             {
                 
                 NSLog(@"uid=%@",user.uid);
                 NSLog(@"%@",user.credential);
                 NSLog(@"token=%@",user.credential.token);
                 NSLog(@"nickname=%@",user.nickname);
             }
             
             else
             {
                 NSLog(@"%@",error);
             }
             
         }];
    }

}







- (IBAction)remAction:(UIButton *)sender {
    _remButton.selected = !_remButton.selected;
    
    if (_remButton.selected) {
        //
        [_remButton setBackgroundImage:[UIImage imageNamed:@"btn_selected"] forState:UIControlStateNormal];
        _remButton.selected = YES;
    }else
    {
        [_remButton setBackgroundImage:[UIImage imageNamed:@"btn_normal"] forState:UIControlStateNormal];
        _remButton.selected = NO;
    }
    
    [QDFunction saveBooleanValue:_remButton.selected withKey:kLogin_remember];
    

}

- (IBAction)loginAction:(UIButton *)sender {
    [self showLoadView];
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setObject:_userLoginTextField.text forKey:@"curr_account"];
    [param setObject:_passwrodTextField.text  forKey:@"password"];
    [param setObject:[QDFunction getTime] forKey:@"time"];
    NSArray *signArray = @[APP_ID,param[@"password"],param[@"time"],APP_IDENTIFER];
    [param setObject: [QDFunction signMD5String:signArray] forKey:@"sign"];
    [param setObject:APP_ID forKey:@"app_id"];
    
    
    [QDAFHttpClient postUrlString:@"/index.php?anu=api/1/user/dispose_login"  withParam:param withSuccessBlock:^(id QDHomeModel) {
        [self dismissLoadView];
        [QDFunction saveObjectValue:_userLoginTextField.text withKey:kLogin_userName];
        [SSKeychain setPassword:_passwrodTextField.text forService:[NSBundle mainBundle].bundleIdentifier account:_userLoginTextField.text];
        [[QDUserInfo shareInstance]instanceWithDict:QDHomeModel];
        [QDFunction saveUserInfo:QDHomeModel];
        
        [self backMethod];
        
        NSLog(@"%@",QDHomeModel);
    } withFailedBlock:^(NSError *error) {
        NSLog(@"failed");
        [self dismissLoadView];
    } withErrorBlock:^(NSString *message) {
        NSLog(@"Error");
        [self showToast:message];
    }];

}

- (IBAction)remembAction:(id)sender {
    
    _remButton.selected = !_remButton.selected;
    
    if (_remButton.selected) {
        //
        [_remButton setBackgroundImage:[UIImage imageNamed:@"btn_selected"] forState:UIControlStateNormal];
        _remButton.selected = YES;
    }else
    {
        [_remButton setBackgroundImage:[UIImage imageNamed:@"btn_normal"] forState:UIControlStateNormal];
        _remButton.selected = NO;
    }
    
    [QDFunction saveBooleanValue:_remButton.selected withKey:kLogin_remember];
}

- (IBAction)forgetAction:(id)sender {
    [_remButton setBackgroundImage:[UIImage imageNamed:@"btn_normal"] forState:UIControlStateNormal];
    _remButton.selected = NO;
    
}
@end
