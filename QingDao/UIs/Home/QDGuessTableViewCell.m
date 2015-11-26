//
//  QDGuessTableViewCell.m
//  QingDao
//
//  Created by 何川 on 15/11/26.
//  Copyright © 2015年 hechuan. All rights reserved.
//

#import "QDGuessTableViewCell.h"
#import "UIImageView+WebCache.h"

@interface QDGuessTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *disLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *introLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

@end

@implementation QDGuessTableViewCell

- (void)awakeFromNib {
    // Initialization code
    _disLabel.textColor = [UIColor redColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setModel:(QDGuessModel *)model
{
    _model = model;
    _disLabel.text = [NSString stringWithFormat:@"%d",_model.price];
    _nameLabel.text = _model.title;
    _introLabel.text = _model.intro;
    
    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:_model.cover]];
    
}
@end
