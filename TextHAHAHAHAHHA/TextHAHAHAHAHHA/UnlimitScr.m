//
//  UnlimitScr.m
//  TextHAHAHAHAHHA
//
//  Created by haohao on 2018/2/1.
//  Copyright © 2018年 haohao. All rights reserved.
//

#import "UnlimitScr.h"

@interface UnlimitScr()<UIScrollViewDelegate>

@end

@implementation UnlimitScr

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpSubView];
    }
    return self;
}

- (void)setUpSubView {
   UIScrollView * scr = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 300, 200)];
    scr.userInteractionEnabled = YES;
    scr.pagingEnabled = YES;
    scr.delegate = self;
    scr.backgroundColor = [UIColor whiteColor];
    scr.contentSize = CGSizeMake(300 * 3, 200);
    scr.showsHorizontalScrollIndicator = NO;
    scr.showsVerticalScrollIndicator = NO;
    scr.alwaysBounceHorizontal = YES;
    scr.bounces = NO;
    [self addSubview:scr];
}

#pragma mark - UIScrollViewDelegate

@end
