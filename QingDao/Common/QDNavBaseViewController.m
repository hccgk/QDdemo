//
//  QDNavBaseViewController.m
//  QingDao
//
//  Created by 何川 on 15/11/21.
//  Copyright © 2015年 hechuan. All rights reserved.
//

#import "QDNavBaseViewController.h"
#import "QDUserInfo.h"
#import "QDLoginViewController.h"
#import "QDUserCenterViewController.h"
#define kNavButtonWidth 44
@interface QDNavBaseViewController ()

@end

@implementation QDNavBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _navView = [[UIView alloc ] initWithFrame:CGRectMake(0, 0, kUIScreenWidth, kUINavHeight)];
    _navView.backgroundColor  = [UIColor redColor];
    [self.view addSubview:_navView];
    //左边按钮
    _leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _leftButton.frame = CGRectMake(0, kUIStatusBarHeight, kNavButtonWidth, kNavButtonWidth);
    [_leftButton setBackgroundImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
    [_leftButton addTarget:self action:@selector(backMethod) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:_leftButton];
    //标题
    _titleLabel = [[UILabel alloc] initWithFrame: CGRectMake(kNavButtonWidth, kUIStatusBarHeight, kUIScreenWidth - 2*kNavButtonWidth,
                                                             kNavButtonWidth)];
    _titleLabel.text = @"首页";
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.font = [UIFont systemFontOfSize:19];
    [_navView addSubview:_titleLabel];
    //右边按钮
    _rightButton = [    UIButton buttonWithType:UIButtonTypeCustom];
    [_rightButton addTarget:self action:@selector(loginMethod) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:_rightButton];
    
    //判别右边按钮的样式
    if (![QDUserInfo shareInstance].isLogin) {
        _rightButton.frame = CGRectMake(kUIScreenWidth - kNavButtonWidth, kUIStatusBarHeight, kNavButtonWidth, kNavButtonWidth);
        [_rightButton setBackgroundImage:[UIImage imageNamed:@"nav_user"] forState:UIControlStateNormal];
        
    }else
    {
        [_rightButton setTitle:@"登录/注册" forState:UIControlStateNormal];
        _rightButton.frame = CGRectMake(kUIScreenWidth - 2*kNavButtonWidth, kUIStatusBarHeight, 2*kNavButtonWidth, kNavButtonWidth);
    }
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

-(void)backMethod
{
    [self.navigationController popViewControllerAnimated:YES];
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    [app.tab showOrHiddenTabbarView:NO];
}

-(void)loginMethod   //选择进入哪一个
{
    DSLog(@"登陆");
    //shareInstance
    if (![QDUserInfo shareInstance].isLogin) {
        
        UIStoryboard *stroy = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        
        QDUserCenterViewController *center = [stroy instantiateViewControllerWithIdentifier:@"QDUserCenterViewController"];
        
        [self.navigationController pushViewController:center animated:NO];
        
        
        //CABasicAnimation  动画
        /*
         CABasicAnimation *expandAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
         expandAnimation.duration = 1.5f;
         expandAnimation.fromValue = [NSNumber numberWithFloat:0.5];
         expandAnimation.toValue = [NSNumber numberWithFloat:1.0f];
         expandAnimation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
         [center.view.layer addAnimation:expandAnimation forKey:@"abc"];
         
         */
        
        //CATransition动画
        CATransition *transition = [CATransition animation];
        transition.type = kCATransitionMoveIn;//@"moveIn";
        transition.subtype = kCATransitionFromTop;//@"fromLeft";
        [center.view.layer addAnimation:transition forKey:@""];
        
        AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
        
        [app.tab showOrHiddenTabbarView:YES];
        
    }else{
        
        QDLoginViewController *login = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"QDLoginViewController"];
        [self.navigationController pushViewController:login animated:YES];
        AppDelegate *app = (AppDelegate*) [UIApplication sharedApplication].delegate;
        [app.tab showOrHiddenTabbarView:YES];

    }

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
