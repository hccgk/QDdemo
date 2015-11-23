//
//  QDTabBarViewController.m
//  QingDao
//
//  Created by 何川 on 15/11/21.
//  Copyright © 2015年 hechuan. All rights reserved.
//

#import "QDTabBarViewController.h"
#import "QDFactory.h"
#define kTabTopViewHeight 44
@interface QDTabBarViewController ()
{
    
}
//顶部
@property (nonatomic, strong) UIView *topView;
//底部
@property (nonatomic, strong) UIView *bottonView;

@end

@implementation QDTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBar.hidden = YES;
    _bottonView = [[UIView alloc]initWithFrame:CGRectMake(0,kUIScreenHeight - kUITabBarHeight
                                                          , kUIScreenWidth, kUITabBarHeight)];
    _bottonView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:_bottonView];
    
    for (int i =0; i<5; i++) {
        UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
        NSString *normalImage = [NSString stringWithFormat:@"home_%d",i];
        [bt setBackgroundImage:[UIImage imageNamed:normalImage] forState:UIControlStateNormal];
        NSString *seleted = [NSString stringWithFormat:@"home_%d_pressed",i];
        [bt setBackgroundImage:[UIImage imageNamed:seleted] forState:UIControlStateSelected];
        
        bt.frame = CGRectMake(i*(kUIScreenWidth)/5.0, 0, kUIScreenWidth/5.0, kUITabBarHeight);
        bt.tag = i;
        [bt addTarget:self action:@selector(changeVC:) forControlEvents:UIControlEventTouchUpInside];
        [_bottonView addSubview:bt];
        
        if (i==0) {
            bt.selected = YES;
        }
        
    }
    
    //初始化TopView
    _topView = [[UIView alloc]initWithFrame:CGRectMake(0, kUIScreenHeight-kUITabBarHeight-kTabTopViewHeight,
                                                       kUIScreenWidth, kTabTopViewHeight)];
    _topView.backgroundColor = [UIColor yellowColor];
    _topView.hidden = YES;
    [self.view addSubview:_topView];
    //添加背景图片
    UIImageView *bgImageView = [[UIImageView alloc]initWithFrame:_topView.bounds];
    bgImageView.image = [UIImage imageNamed:@"home_topbar"];
    [_topView addSubview:bgImageView];
    //xmpp
    UIButton *xmpp = [UIButton buttonWithType:UIButtonTypeCustom];
    xmpp.frame = CGRectMake(0, 0, kUIScreenWidth*(123.0/640.0), kTabTopViewHeight);
    [xmpp addTarget:self action:@selector(changeVC:) forControlEvents:UIControlEventTouchUpInside];
    [xmpp setTitle:@"联系商家" forState:UIControlStateNormal];
    xmpp.tag = 5;
    [_topView addSubview:xmpp];
    //摇一摇
    UIButton *shake = [QDFactory type:0 withFrame:CGRectMake(kUIScreenWidth*(150.0/640.0),
                                                             0, kUIScreenWidth*(180.0/640),
                                                             kTabTopViewHeight)
                            withTitle:@"摇一摇" withTarget:self withAction:@selector(changeVC:)];
    shake.tag = 6;
    [_topView addSubview:shake];
    //直播
    UIButton *onlive = [QDFactory type:0 withFrame:CGRectMake(kUIScreenWidth*(350.0/640.0),
                                                             0, kUIScreenWidth*(108.0/640),
                                                             kTabTopViewHeight)
                            withTitle:@"直播" withTarget:self withAction:@selector(changeVC:)];
    onlive.tag = 7;
    [_topView addSubview:onlive];
    //关于
    UIButton *about = [QDFactory type:0 withFrame:CGRectMake(kUIScreenWidth*((640.0-150.0)/640.0),
                                                             0, kUIScreenWidth*(150.0/640),
                                                             kTabTopViewHeight)
                            withTitle:@"关于" withTarget:self withAction:@selector(changeVC:)];
    about.tag = 8;
    [_topView addSubview:about];
    
    
}

-(void)changeVC:(UIButton*)bt
{
    _topView.hidden = YES;
    [_bottonView.subviews enumerateObjectsUsingBlock:^(__kindof UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.selected = NO;
    }];
    bt.selected = YES;
    if (bt.tag<4) {
        self.selectedIndex = bt.tag;
    }
    else if (bt.tag ==4)
    {
        _topView.hidden =NO;
    } else
    {
        self.selectedIndex = bt.tag -1;
    }
}

-(void)showOrHiddenTabbarView:(BOOL)flag
{
    if (flag) {
        _topView.hidden = YES;
        _bottonView.hidden = YES;
        
    } else
        _bottonView.hidden = NO;
    
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
