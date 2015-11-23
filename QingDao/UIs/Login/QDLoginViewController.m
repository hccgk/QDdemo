//
//  QDLoginViewController.m
//  QingDao
//
//  Created by 何川 on 15/11/23.
//  Copyright © 2015年 hechuan. All rights reserved.
//

#import "QDLoginViewController.h"

@interface QDLoginViewController ()

@end

@implementation QDLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titleLabel.text = @"登录";
    self.rightButton.hidden = YES;
}
-(void)backMethod
{
    [self.navigationController popViewControllerAnimated:YES];
    
    AppDelegate *app = [UIApplication sharedApplication].delegate;
    [app.tab showOrHiddenTabbarView:NO];
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
