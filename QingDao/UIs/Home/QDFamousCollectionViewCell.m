//
//  QDFamousCollectionViewCell.m
//  QingDao
//
//  Created by 何川 on 15/11/26.
//  Copyright © 2015年 hechuan. All rights reserved.
//

#import "QDFamousCollectionViewCell.h"
#import "UIImageView+WebCache.h"
@interface QDFamousCollectionViewCell()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UIImageView *startImageView;
@property (weak, nonatomic) IBOutlet UILabel *disLabel;
@property (weak, nonatomic) IBOutlet UILabel *introLabel;

@end

@implementation QDFamousCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
    _disLabel.textColor = [UIColor orangeColor];
    
}

-(void)setModel:(QDFamousModel *)model
{
    _model = model;
    _nameLabel.text = model.name;
    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:_model.cover]];
    NSString *startImage = [NSString stringWithFormat:@"star_%d",_model.score];
   // [_startImageView setImage:[UIImage imageNamed:startImage]];
    _startImageView.image = [UIImage imageNamed:startImage];
    _introLabel.text = _model.intro;
   
}

@end
