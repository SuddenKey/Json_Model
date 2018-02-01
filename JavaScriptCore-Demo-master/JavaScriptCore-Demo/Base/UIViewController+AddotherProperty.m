//
//  UIViewController+AddotherProperty.m
//  JavaScriptCore-Demo
//
//  Created by haohao on 2018/1/20.
//  Copyright © 2018年 www.skyfox.org. All rights reserved.
//

#import "UIViewController+AddotherProperty.h"
#import <objc/NSObjCRuntime.h>
#import <objc/runtime.h>
#pragma clang diagnostic ignored "-Wobjc-designated-initializers"
static const void *tagKey = &tagKey;

@implementation UIViewController (AddotherProperty)
- (instancetype) init {
    self = [super init];
    if (self) {
      
    }
    return self;
}

//- (void)addLeftBtn:(SEL)click{
//    UIButton *sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    sendBtn.frame = CGRectMake(0, 0, 80, 22);
//    sendBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
//    sendBtn.layer.borderWidth = 1.0;
//    sendBtn.layer.cornerRadius = 4;
//    sendBtn.clipsToBounds = YES;
//    sendBtn.layer.borderColor = [UIColor whiteColor].CGColor;
//    [sendBtn setBackgroundColor:[UIColor blackColor]];
//    [sendBtn setTitle:@"修改" forState:UIControlStateNormal];
//    [sendBtn addTarget:self action:click forControlEvents:UIControlEventTouchUpInside];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:sendBtn];
//
//}


//左返回键
- (UIButton *)leftBtn {
    UIButton *sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sendBtn.frame = CGRectMake(0, 0, 40, 40);
    sendBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
    sendBtn.layer.borderWidth = 1.0;
    sendBtn.layer.cornerRadius = 4;
    sendBtn.clipsToBounds = YES;
    sendBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    [sendBtn setBackgroundColor:[UIColor blackColor]];
    [sendBtn setTitle:@"左返回键" forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:sendBtn];
    self.leftBtn = sendBtn;
    
    return objc_getAssociatedObject(self, @selector(leftBtn));
}

- (void)setLeftBtn:(UIButton *)leftBtn {
    objc_setAssociatedObject(self, @selector(leftBtn), leftBtn, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

//右返回键
- (UIButton *)rightBtn {
    UIButton *sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sendBtn.frame = CGRectMake(0, 0, 40, 40);
    sendBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
    sendBtn.layer.borderWidth = 1.0;
    sendBtn.layer.cornerRadius = 4;
    sendBtn.clipsToBounds = YES;
    sendBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    [sendBtn setBackgroundColor:[UIColor blackColor]];
    [sendBtn setTitle:@"右返回键" forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:sendBtn];
    self.rightBtn = sendBtn;
    return objc_getAssociatedObject(self, @selector(rightBtn));
}


- (void)setRightBtn:(UIButton *)rightBtn {
    objc_setAssociatedObject(self, @selector(rightBtn), rightBtn, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
