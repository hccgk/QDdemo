//
//  QDThirdCollectionViewCell.m
//  QingDao
//
//  Created by 何川 on 15/11/27.
//  Copyright © 2015年 hechuan. All rights reserved.
//

#import "QDThirdCollectionViewCell.h"

@interface QDThirdCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *label;

@end
@implementation QDThirdCollectionViewCell

-(void)setData:(NSDictionary *)data
{
    _data = data;
    _imageView.image = [UIImage imageNamed:_data[@"icon"]];
    _label.text = _data[@"name"];
    
}
@end
