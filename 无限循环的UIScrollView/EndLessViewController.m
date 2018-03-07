//
//  EndLessViewController.m
//  TextHAHAHAHAHHA
//
//  Created by haohao on 2018/3/5.
//  Copyright © 2018年 haohao. All rights reserved.
//

#import "EndLessViewController.h"

#define SCREEN_WIDTH    self.view.frame.size.width
#define SCREEN_HEIGHT 568
#define IMAGEVIEW_COUNT 3
#define KWidth    self.view.frame.size.width
#define KHeight   self.view.frame.size.height
@interface EndLessViewController ()<UIScrollViewDelegate> {
    UIImageView *_leftImageView;
    UIImageView *_centerImageView;
    UIImageView *_rightImageView;
    UIPageControl *_pageControl;
    
    int _currentImageIndex;//当前图片索引
    int _imageCount;//图片总数
    
    NSTimer *time;
}

@property (nonatomic, strong) UIScrollView *scr;

@end

@implementation EndLessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addPageControl];
    [self setUpSubView];
}

- (void)setUpSubView {
    
    self.view.backgroundColor = [UIColor whiteColor];
    _imageCount = 3;
    _currentImageIndex = 0;
    _scr = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, KWidth, 200)];
    _scr.center = self.view.center;
    _scr.userInteractionEnabled = YES;
    _scr.pagingEnabled = YES;
    _scr.delegate = self;
    _scr.backgroundColor = [UIColor whiteColor];
    _scr.contentSize = CGSizeMake(KWidth * 3, 200);
    _scr.showsHorizontalScrollIndicator = NO;
    _scr.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_scr];
    
    _leftImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _leftImageView.contentMode=UIViewContentModeScaleAspectFit;
    [_scr addSubview:_leftImageView];
    _centerImageView=[[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _centerImageView.contentMode=UIViewContentModeScaleAspectFit;
    [_scr addSubview:_centerImageView];
    _rightImageView=[[UIImageView alloc]initWithFrame:CGRectMake(2*SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _rightImageView.contentMode=UIViewContentModeScaleAspectFit;
    [_scr addSubview:_rightImageView];
    
    _leftImageView.image=[UIImage imageNamed:@"SCR2"];
    _centerImageView.image=[UIImage imageNamed:@"SCR1"];
    _rightImageView.image=[UIImage imageNamed:@"SCR3"];
    _pageControl.currentPage=_currentImageIndex;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        time = [NSTimer scheduledTimerWithTimeInterval:4 target:self selector:@selector(repeat:) userInfo:nil repeats:YES];
        [time setFireDate:[NSDate date]];
    });

}

- (void)repeat:(NSTimer *)sender{
//    [UIView animateWithDuration:1 animations:^{
        [_scr setContentOffset:CGPointMake(SCREEN_WIDTH * 2 , 0) animated:YES];
//    }];
}

-(void)addPageControl{
    _pageControl=[[UIPageControl alloc]init];
    //注意此方法可以根据页数返回UIPageControl合适的大小
    CGSize size= [_pageControl sizeForNumberOfPages:_imageCount];
    _pageControl.bounds=CGRectMake(0, 0, size.width, size.height);
    _pageControl.center=CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT-100);
    //设置颜色
    _pageControl.pageIndicatorTintColor=[UIColor colorWithRed:193/255.0 green:219/255.0 blue:249/255.0 alpha:1];
    //设置当前页颜色
    _pageControl.currentPageIndicatorTintColor=[UIColor colorWithRed:0 green:150/255.0 blue:1 alpha:1];
    //设置总页数
    _pageControl.numberOfPages=_imageCount;
    
    [self.view addSubview:_pageControl];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView  {
    //    //重新加载图片
        [self reloadImage];
    //    //移动到中间
        [_scr setContentOffset:CGPointMake(KWidth, 0) animated:NO];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
////    //重新加载图片
//    [self reloadImage];
////    //移动到中间
//    [_scr setContentOffset:CGPointMake(0, 0) animated:NO];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
}

#pragma mark 滚动停止事件
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
    [time setFireDate:[NSDate distantFuture]];
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    //重新加载图片
    [self reloadImage];
    //移动到中间
    [_scr setContentOffset:CGPointMake(SCREEN_WIDTH, 0) animated:NO];
    //设置分页
    _pageControl.currentPage=_currentImageIndex;
    //设置描述
    NSString *imageName=[NSString stringWithFormat:@"%i.jpg",_currentImageIndex];
    NSDate *dateTime = [NSDate dateWithTimeInterval:4 sinceDate:[NSDate date]];
    [time setFireDate:dateTime];
//    _label.text=_imageData[imageName];
}

#pragma mark 重新加载图片
-(void)reloadImage{
    int leftImageIndex,rightImageIndex;
    CGPoint offset=[_scr contentOffset];
    if (offset.x>=SCREEN_WIDTH) { //向右滑动
        _currentImageIndex = _currentImageIndex + 1;
        _currentImageIndex= _currentImageIndex %_imageCount;
        NSLog(@"_currentImageIndex =  %d", _currentImageIndex);

    }else if(offset.x<SCREEN_WIDTH){ //向左滑动
        _currentImageIndex = _currentImageIndex + _imageCount - 1;
        
        _currentImageIndex=_currentImageIndex %_imageCount;
        NSLog(@"_imageCount - 1 =  %d", _currentImageIndex);

    }
    //UIImageView *centerImageView=(UIImageView *)[_scrollView viewWithTag:2];
    _centerImageView.image=[UIImage imageNamed:[NSString stringWithFormat:@"SCR%i.jpg",_currentImageIndex]];
    //重新设置左右图片
    leftImageIndex=(_currentImageIndex+_imageCount-1)%_imageCount;
    rightImageIndex=(_currentImageIndex+1)%_imageCount;
    _leftImageView.image=[UIImage imageNamed:[NSString stringWithFormat:@"SCR%i.jpg",leftImageIndex]];
    _rightImageView.image=[UIImage imageNamed:[NSString stringWithFormat:@"SCR%i.jpg",rightImageIndex]];
}

@end
