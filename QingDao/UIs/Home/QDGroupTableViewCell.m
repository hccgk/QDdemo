//
//  QDGroupTableViewCell.m
//  QingDao
//
//  Created by 何川 on 15/11/25.
//  Copyright © 2015年 hechuan. All rights reserved.
//

#import "QDGroupTableViewCell.h"
#import "QDGroupCollectionViewCell.h"
@interface QDGroupTableViewCell ()<UICollectionViewDataSource,
UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flowLayout;

@end

static NSString * identier = @"QDGroupCollectionViewCell";

@implementation QDGroupTableViewCell

- (void)awakeFromNib {
    [_collectionView registerNib:[UINib nibWithNibName:identier bundle:nil] forCellWithReuseIdentifier:identier];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.scrollEnabled = NO;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    _flowLayout.itemSize = CGSizeMake(self.frame.size.width/4, self.frame.size.height/2);
    _flowLayout.minimumInteritemSpacing = 0;
    _flowLayout.minimumLineSpacing = 0;
    _flowLayout.sectionInset = UIEdgeInsetsZero;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setList:(QDGroupList *)list
{
    _list = list;
    [_collectionView reloadData];
}

#pragma UICollectionViewDataSource

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _list.list.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    QDGroupCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identier forIndexPath:indexPath];
    cell.model = _list.list[indexPath.row];
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%ld",indexPath.row);
    [_delegate didItemSelected:indexPath.row];
}

@end
