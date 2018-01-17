//
//  TEXTTableViewCell.m
//  TextHAHAHAHAHHA
//
//  Created by haohao on 2017/12/4.
//  Copyright © 2017年 haohao. All rights reserved.
//

#import "TEXTTableViewCell.h"

@implementation TEXTTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUpSubView];
    }
    return self;
}

- (void)setUpSubView {
    UIView *textView = [[UIView alloc] initWithFrame:CGRectMake(0, 44, self.frame.size.width, self.frame.size.height)];
    [self.contentView addSubview:textView];
    
//    UITapGestureRecognizer
}

@end
