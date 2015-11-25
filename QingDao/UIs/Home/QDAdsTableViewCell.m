//
//  QDAdsTableViewCell.m
//  QingDao
//
//  Created by 何川 on 15/11/25.
//  Copyright © 2015年 hechuan. All rights reserved.
//

#import "QDAdsTableViewCell.h"
#import "iCarousel.h"
#import "QDFocus.h"
#import  <UIImageView+WebCache.h>
@interface QDAdsTableViewCell()<iCarouselDelegate,iCarouselDataSource>
@property (weak, nonatomic) IBOutlet iCarousel *carousel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (nonatomic, strong) NSMutableArray *items;
@property(nonatomic,assign)BOOL wrap;


@end

@implementation QDAdsTableViewCell

-(void)setModel:(QDHomeModel * )model
{
    _model = model;
    
    //page
    _pageControl.numberOfPages = [_model.focus.list count];
    //reload
    [_carousel reloadData];
    
}


-(void)awakeFromNib{
    [self setUp];
    //type
    self.carousel.type = iCarouselTypeLinear;
    [_carousel reloadData];
}

-(id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setUp];
        self.carousel.type = iCarouselTypeLinear;
    }
    return self;
}

-(void)setUp{
    //是否循环
    self.wrap = YES;
}

-(void)dealloc
{
    _carousel.delegate = nil;
    _carousel.dataSource = nil;
}

#pragma View lifecycle


///不明白!!!!!
- (BOOL)shouldAutorotateToInterfaceOrientation:(__unused UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

#pragma mark UIActionSheet methods
//copy过来的
- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex >= 0)
    {
        //map button index to carousel type
        iCarouselType type = buttonIndex;
        
        //carousel can smoothly animate between types
        [UIView beginAnimations:nil context:nil];
        self.carousel.type = type;
        [UIView commitAnimations];
        
        
    }
}
#pragma iCarouselDataSource

- (NSInteger)numberOfItemsInCarousel:(__unused iCarousel *)carousel
{
    
    NSLog(@"数量是:%lu",(unsigned long)[_model.focus.list count]);

    return (NSInteger)[_model.focus.list count];
    //return [_model.focus.list count];
}
- (UIView *)carousel:(__unused iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
  //  UILabel *label = nil;
    if (view ==nil) {
        //instance
        QDFocus *fouces = _model.focus.list[index];
        //image
        view = [[UIImageView alloc] initWithFrame:self.bounds];
        
        [((UIImageView*)view) sd_setImageWithURL:[NSURL URLWithString:fouces.cover]];
        //title
        _titleLabel.text = fouces.title;
        //page
        _pageControl.currentPage = index;
        view.contentMode = UIViewContentModeScaleToFill;
    }
    else
    {
        
    }
    view.backgroundColor = [UIColor redColor];
    return view;
}

//直接粘贴过来的方法 begin  这时占位图片,需要有
- (NSInteger)numberOfPlaceholdersInCarousel:(__unused iCarousel *)carousel
{
    //note: placeholder views are only displayed on some carousels if wrapping is disabled
    return 2;
}
- (UIView *)carousel:(__unused iCarousel *)carousel placeholderViewAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    //   UILabel *label = nil;
    //create new view if no view is available for recycling
    if (view == nil)
    {
        //don't do anything specific to the index within
        //this `if (view == nil) {...}` statement because the view will be
        //recycled and used with other index values later
        //获取到 实例
        QDFocus *focus = _model.focus.list[index];
        view = [[UIImageView alloc] initWithFrame:self.bounds];
        [((UIImageView *)view) sd_setImageWithURL:[NSURL URLWithString:focus.cover]];
        
        view.contentMode = UIViewContentModeCenter;
        
        //设置标题
        _titleLabel.text = focus.title;
        //修改page的现实
        _pageControl.currentPage = index;
        
    }
    else
    {
    }
    //更改背景颜色
    view.backgroundColor = [UIColor redColor];
    
    return view;
}


//直接粘贴过来的方法 end


#pragma iCarouselDelegate
- (void)carousel:(__unused iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index
{
    NSNumber *item = (_model.focus.list)[(NSUInteger)index];
    NSLog(@"Tapped view Nmuber:%@",item);
}
- (void)carouselCurrentItemIndexDidChange:(__unused iCarousel *)carousel
{
    NSLog(@"Index: %@", @(self.carousel.currentItemIndex));
    QDFocus *focus = _model.focus.list[self.carousel.currentItemIndex];
    //设置标题
    _titleLabel.text = focus.title;
    
    //修改page的现实
    _pageControl.currentPage = self.carousel.currentItemIndex;
}

@end


























