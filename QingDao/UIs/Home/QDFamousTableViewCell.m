//
//  QDFamousTableViewCell.m
//  QingDao
//
//  Created by 何川 on 15/11/26.
//  Copyright © 2015年 hechuan. All rights reserved.
//

#import "QDFamousTableViewCell.h"
#import "QDFamousCollectionViewCell.h"
@interface QDFamousTableViewCell ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flowLayout;

@end

static NSString * identier = @"QDFamousCollectionViewCell";

@implementation QDFamousTableViewCell

- (void)awakeFromNib {
    // Initialization code
    [_collectionView registerNib:[UINib nibWithNibName:identier bundle:nil] forCellWithReuseIdentifier:identier];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.scrollEnabled = NO;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    _flowLayout.itemSize = CGSizeMake(self.frame.size.width / 2, self.frame.size.height / 2 );
    _flowLayout.minimumInteritemSpacing = 0;
    _flowLayout.minimumLineSpacing = 0;
    _flowLayout.sectionInset = UIEdgeInsetsZero;
}


-(void)setList:(QDFamousList *)list
{
    _list = list;
    
    if (_list.list<=0) {
        return;
    }
    
    [_collectionView reloadData];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


#pragma UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _list.list.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    QDFamousCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identier forIndexPath:indexPath];
    
    cell.model = _list.list[indexPath.row];
    
    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    //NSLog(@"%ld",indexPath.row);
    if ([_delegate respondsToSelector:@selector(didFamousItemClick:)]) {
        [_delegate didFamousItemClick:indexPath.row];
    }
    
}


@end
