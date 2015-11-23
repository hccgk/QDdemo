//
//  QDBaseViewController.m
//  QingDao
//
//  Created by 何川 on 15/11/21.
//  Copyright © 2015年 hechuan. All rights reserved.
//

#import "QDBaseViewController.h"
#import "MBProgressHUD.h"
#import "UIView+Toast.h"
@interface QDBaseViewController ()
{
    MBProgressHUD *HUD;
}
@end

@implementation QDBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor colorWithRed:rand()%255/255.0 green:rand()%255/255.0 blue:rand()%255/255.0 alpha:1.0];
    }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)showLoadView
{
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [HUD show:YES];
    [self.view addSubview:HUD];
}

-(void)dismissLoadView
{
    if (HUD) {
        [HUD removeFromSuperview];
        [HUD hide:YES];
        HUD = nil;
    }
}

-(void)showToast:(NSString *)message
{
    [self.view makeToast:message];
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
