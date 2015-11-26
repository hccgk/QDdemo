//
//  QDGroupCollectionViewCell.m
//  QingDao
//
//  Created by 何川 on 15/11/25.
//  Copyright © 2015年 hechuan. All rights reserved.
//

#import "QDGroupCollectionViewCell.h"
#import "UIImageView+WebCache.h"
@interface QDGroupCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UILabel *label;

@end
@implementation QDGroupCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)setModel:(QDGroupModel *)model
{
    _model = model;
    _label.text = _model.title;
    [_iconImage sd_setImageWithURL:[NSURL URLWithString:_model.cover]];
}
@end
