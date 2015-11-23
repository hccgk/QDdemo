//
//  QDBaseViewController.h
//  QingDao
//
//  Created by 何川 on 15/11/21.
//  Copyright © 2015年 hechuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QDBaseViewController : UIViewController
{
    
}

-(void)showLoadView;
-(void)showLoadViewWithMessage:(NSString*)message;
-(void)dismissLoadView;

-(void)showToast:(NSString*)message;
@end
