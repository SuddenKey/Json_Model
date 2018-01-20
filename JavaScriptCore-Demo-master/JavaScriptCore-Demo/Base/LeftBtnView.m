//
//  LeftBtnView.m
//  JavaScriptCore-Demo
//
//  Created by haohao on 2018/1/20.
//  Copyright © 2018年 www.skyfox.org. All rights reserved.
//

#import "LeftBtnView.h"

@implementation LeftBtnView

- (instancetype)init {
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, 60, 40);
        
        self.backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.backBtn.frame = CGRectMake(20, 20, 40, 40);
        [self.backBtn setTitle:@"返回" forState:UIControlStateNormal];
        [self.backBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.backBtn setImage:[UIImage imageNamed:@"navi_return"] forState:UIControlStateNormal];
        [self.backBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 30)];

        [self addSubview:self.backBtn];
    }
    return self;
}

- (void)setClickMethod:(SEL)clickMethod {
    [self.backBtn addTarget:self action:@selector(clickMethod) forControlEvents:UIControlEventTouchUpInside];
}



@end
