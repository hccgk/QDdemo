//
//  QDAdsTableViewCell.m
//  QingDao
//
//  Created by 何川 on 15/11/25.
//  Copyright © 2015年 hechuan. All rights reserved.
//

#import "QDAdsTableViewCell.h"
#import "iCarousel.h"
#import  <UIImageView+WebCache.h>
@interface QDAdsTableViewCell()<iCarouselDelegate,iCarouselDataSource>
@property (weak, nonatomic) IBOutlet iCarousel *carousel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (nonatomic, strong) NSMutableArray *items;
@property(nonatomic,assign)BOOL wrap;
@property (nonatomic, strong) NSTimer *timer;


@end

@implementation QDAdsTableViewCell

-(void)setList:(QDFocusList *)list
{
    _list = list;
    
    if (_list.list.count <= 0) {
        return;
    }
    //page
    _pageControl.numberOfPages = [_list.list count];
    //reload
    [_carousel reloadData];
    
    QDFocusModel *model = _list.list[0];
    _titleLabel.text = model.title;
    _pageControl.currentPage = 0;
    
    [self startTimer];
    
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

    return (NSInteger)[self.list.list count];

}
- (UIView *)carousel:(__unused iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
  //  UILabel *label = nil;
    if (view ==nil) {
        //instance
        QDFocusModel *model = _list.list[index];
        //image
        view = [[UIImageView alloc] initWithFrame:self.bounds];
        
        [((UIImageView*)view) sd_setImageWithURL:[NSURL URLWithString:model.cover]];
        //title
    }
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
        QDFocusModel *model = _list.list[index];

        view = [[UIImageView alloc] initWithFrame:self.bounds];
        [((UIImageView *)view) sd_setImageWithURL:[NSURL URLWithString:model.cover]];
        
        view.contentMode = UIViewContentModeCenter;
    }
        return view;
}


//直接粘贴过来的方法 end


#pragma iCarouselDelegate
- (void)carousel:(__unused iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index
{
    NSNumber *item = (self.list.list)[(NSUInteger)index];
    NSLog(@"Tapped view Nmuber:%@",item);
}
- (void)carouselCurrentItemIndexDidChange:(__unused iCarousel *)carousel
{
    NSLog(@"Index: %@", @(self.carousel.currentItemIndex));
    QDFocusModel *focus = self.list.list[self.carousel.currentItemIndex];
    //设置标题
    _titleLabel.text = focus.title;
    
    //修改page的现实
    _pageControl.currentPage = self.carousel.currentItemIndex;
}
#pragma 定时

-(void)startTimer
{
    if (self.timer) {
        return;
    }
    self.timer = [NSTimer timerWithTimeInterval:3.0 target:self selector:@selector(autoRun) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}
-(void)stopTimer
{
    if ([_timer isValid]) {
        [_timer invalidate];
        _timer = nil;
    }
}
-(void)autoRun
{
    [self.carousel scrollToItemAtIndex:(self.carousel.currentItemIndex+1)%_list.list.count animated:YES];
}
@end


























