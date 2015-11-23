//
//  QDGuideViewController.m
//  QingDao
//
//  Created by 何川 on 15/11/22.
//  Copyright © 2015年 hechuan. All rights reserved.
//

#import "QDGuideViewController.h"
#import "AppDelegate.h"
#import "QDFunction.h"
@interface QDGuideViewController ()

@end

@implementation QDGuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:kUIScreenBounds];
    
    scrollView.contentSize = CGSizeMake(3*kUIScreenWidth, 0);
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.bounces = NO;
   // scrollView.contentOffset = CGPointMake(3*kUIScreenWidth, 0);
    [self.view addSubview:scrollView];
    
    for (int i =0; i<3; i++) {
        UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(i*kUIScreenWidth, 0, kUIScreenWidth, kUIScreenHeight)];
        NSString *imgName = [NSString stringWithFormat:@"guide_%d",i];
        img.image = [UIImage imageNamed:imgName];
        
        [scrollView addSubview:img];
        if (i==2) {
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(enter)];
            img.userInteractionEnabled = YES;
            [img addGestureRecognizer:tap];
        }
    }
}

-(void)enter{
    
    [QDFunction saveValue:YES forKey:kFirstLanuch];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationGuideEnter object:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
