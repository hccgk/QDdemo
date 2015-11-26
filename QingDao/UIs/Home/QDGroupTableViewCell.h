//
//  QDGroupTableViewCell.h
//  QingDao
//
//  Created by 何川 on 15/11/25.
//  Copyright © 2015年 hechuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QDHomeModel.h"
@protocol QDGroupTableViewCellDelegate;

@interface QDGroupTableViewCell : UITableViewCell
@property (nonatomic, strong) QDHomeModel *model;
@property (nonatomic, strong) QDGroupList *list;

@property(nonatomic,weak) id<QDGroupTableViewCellDelegate> delegate;


@end

@protocol QDGroupTableViewCellDelegate <NSObject>

-(void)didItemSelected:(NSInteger)index;

@end
