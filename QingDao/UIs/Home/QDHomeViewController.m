//
//  QDHomeViewController.m
//  QingDao
//
//  Created by 何川 on 15/11/22.
//  Copyright © 2015年 hechuan. All rights reserved.
//

#import "QDHomeViewController.h"

@interface QDHomeViewController ()

@end

@implementation QDHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self showLoadView];
    [self performSelector:@selector(dismissLoadView) withObject:nil afterDelay:2.0];
    [self showToast:@"testme"];
    self.leftButton.hidden = YES;
    
    NSLog(@"abc");
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
