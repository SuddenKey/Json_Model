//
//  endLessScro.m
//  TextHAHAHAHAHHA
//
//  Created by haohao on 2018/2/24.
//  Copyright © 2018年 haohao. All rights reserved.
//

#define selfWidth   self.frame.size.width
#define selfHeight   self.frame.size.height

#import "endLessScro.h"

@interface endLessScro()<UIScrollViewDelegate> {
    NSInteger _pageNumber;
    NSInteger currPage;
    NSInteger timeRecond;
    UIScrollView *scr;
}

@end

@implementation endLessScro

- (instancetype)initWithDur:(NSInteger)number frame:(CGRect)frame{
    self = [super init];
    if (self) {
        _pageNumber = number;
        self.frame = frame;
        [self setUpSubView];
    }
    return self;
}

- (void)setUpSubView {
    scr = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, selfWidth, selfHeight)];
    scr.userInteractionEnabled = YES;
    scr.pagingEnabled = YES;
    scr.delegate = self;
    scr.backgroundColor = [UIColor redColor];
    scr.contentSize = CGSizeMake(selfWidth * _pageNumber, selfHeight);
    scr.showsHorizontalScrollIndicator = NO;
    scr.showsVerticalScrollIndicator = NO;
    scr.alwaysBounceHorizontal = NO;
    scr.bounces = NO;
    [self addSubview:scr];
    
    for (int i = 0; i < _pageNumber; i++) {
        UILabel *backLabel = [[UILabel alloc] initWithFrame:CGRectMake(i * selfWidth, 5, selfWidth - 10, selfHeight -10)];
        backLabel.backgroundColor = [UIColor yellowColor];
        backLabel.text = [NSString stringWithFormat:@"%d", i];
        backLabel.textAlignment = NSTextAlignmentCenter;
        backLabel.textColor = [UIColor blackColor];
        [scr addSubview:backLabel];
    }
    
    NSTimer *time = [NSTimer scheduledTimerWithTimeInterval:3 repeats:YES block:^(NSTimer * _Nonnull timer) {
        timeRecond ++;
        [scr setContentOffset:CGPointMake(selfWidth * 1, 0) animated:YES];
        currPage = timeRecond % 5;
    }];
    [time fire];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [scr.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    for (int i = 0; i < _pageNumber; i++) {

        UILabel *backLabel = [[UILabel alloc] initWithFrame:CGRectMake(i * selfWidth, 5, selfWidth - 10, selfHeight - 10)];
        if (i < _pageNumber) {
            backLabel.text = [NSString stringWithFormat:@"%ld", currPage + i];
        } else {
            backLabel.text = [NSString stringWithFormat:@"%ld", currPage - (currPage - i)];
        }
        backLabel.backgroundColor = [UIColor yellowColor];
        backLabel.textAlignment = NSTextAlignmentCenter;
        backLabel.textColor = [UIColor blackColor];
        [scr addSubview:backLabel];
    }
    
    [scr setContentOffset:CGPointMake(0, 0) animated:YES];
}

@end
