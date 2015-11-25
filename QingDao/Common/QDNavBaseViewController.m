//
//  QDNavBaseViewController.m
//  QingDao
//
//  Created by 何川 on 15/11/21.
//  Copyright © 2015年 hechuan. All rights reserved.
//

#import "QDNavBaseViewController.h"

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
    
    if (/* DISABLES CODE */ (NO)) {
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
    
}

-(void)loginMethod
{
    
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
