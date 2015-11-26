//
//  QDFamousTableViewCell.h
//  QingDao
//
//  Created by 何川 on 15/11/26.
//  Copyright © 2015年 hechuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QDHomeModel.h"
//@protocol  QDFamousTableViewCellDelegate;
@protocol  QDFamousTableViewCellDelegate <NSObject>

- (void)didFamousItemClick:(NSInteger)index;

@end

@interface QDFamousTableViewCell : UITableViewCell

@property (nonatomic,strong) QDFamousList *list;

@property (nonatomic, weak)id<QDFamousTableViewCellDelegate>delegate;

@end

