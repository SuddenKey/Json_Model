//
//  EndLessUITableView.m
//  TextHAHAHAHAHHA
//
//  Created by haohao on 2018/3/5.
//  Copyright © 2018年 haohao. All rights reserved.
//

#import "EndLessUITableView.h"

@implementation EndLessUITableView

- (void)layoutSubviews {
    [super layoutSubviews];
}


- (void)resetContentOffsetIfNeeded {
    CGPoint contentOffset = self.contentOffset;
    //头部
    if (contentOffset.y < 0.0) {
        contentOffset.y = self.contentSize.height / 3.0;
    }
    //尾部
    else if (contentOffset.y >= (self.contentSize.height - self.bounds.size.height)) {
        contentOffset.y = self.contentSize.height / 3.0 - self.bounds.size.height;
    }
    [self setContentOffset:contentOffset];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
