//
//  QDNavBaseViewController.h
//  QingDao
//
//  Created by 何川 on 15/11/21.
//  Copyright © 2015年 hechuan. All rights reserved.
//

#import "QDBaseViewController.h"

@interface QDNavBaseViewController : QDBaseViewController
{
    
}

//nav View
@property (nonatomic ,strong)UIView *navView;
//left buton
@property (nonatomic, strong) UIButton *leftButton;
//midel label
@property (nonatomic, strong) UILabel *titleLabel;
//right buton
@property (nonatomic, strong) UIButton *rightButton;

-(void)backMethod;
-(void)loginMethod;

@end
