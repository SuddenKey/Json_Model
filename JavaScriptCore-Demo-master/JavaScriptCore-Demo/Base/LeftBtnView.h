//
//  LeftBtnView.h
//  JavaScriptCore-Demo
//
//  Created by haohao on 2018/1/20.
//  Copyright © 2018年 www.skyfox.org. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LeftBtnViewDelegate<NSObject>

- (void)clickBackView;

@end

@interface LeftBtnView : UIView

@property (nonatomic, strong) UIButton *backBtn;

@property (nonatomic, copy) id<LeftBtnViewDelegate> delegate;

@property (nonatomic, assign) SEL clickMethod;

@property (nonatomic, copy)   NSString *title;

@end
