//
//  MBProgressHUD+MJ.m
//
//  Created by mj on 13-4-18.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "MBProgressHUD+MJ.h"
#import "UIImage+GIF.h"
#import "YKFSwift-Swift.h"
#import "LoadingImageView.h"

@implementation MBProgressHUD (MJ)
#pragma mark 显示信息
+ (void)show:(NSString *)text icon:(NSString *)icon view:(UIView *)view
{
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.detailsLabelText = text;
    hud.detailsLabelFont = [UIFont systemFontOfSize:15];
    // 设置图片
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"MBProgressHUD.bundle/%@", icon]]];
    // 再设置模式
    hud.mode = MBProgressHUDModeCustomView;
    
    hud.color = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.75];
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    
    hud.backgroundColor = [UIColor clearColor];
    
    // 1秒之后再消失
    [hud hide:YES afterDelay:2];
}

#pragma mark 显示错误信息
+ (void)showError:(NSString *)error toView:(UIView *)view{
    [self show:error icon:@"error.png" view:view];
}

+ (void)showSuccess:(NSString *)success toView:(UIView *)view
{
    [self show:success icon:@"success.png" view:view];
}

#pragma mark 显示一些信息

+ (MBProgressHUD *)showLoading:(NSString *)message toView:(UIView *)view {
    if (view == nil) {
        view = [[UIApplication sharedApplication].windows lastObject];
    }
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    if ([NullTool isNullOrBlankWithValue:message]) {
        hud.detailsLabelText = @"加载中...";
    } else {
        hud.detailsLabelText = message;
    }
    hud.detailsLabelFont = [UIFont systemFontOfSize:12];
    hud.detailsLabelColor = [UIColor whiteColor];
    //添加动态加载logo
    hud.mode = MBProgressHUDModeCustomView;
    LoadingImageView *loadImageView = [[LoadingImageView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
    hud.customView = loadImageView;
    
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    hud.animationType =
    // YES代表需要蒙版效果
    hud.dimBackground = NO;
    hud.backgroundColor = [UIColor clearColor];
    hud.color = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.645362367021276];
//    hud.sizeFlag = YES;
    return hud;
}

+ (MBProgressHUD *)showAlphaMessage:(NSString *)message toView:(UIView *)view {
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.detailsLabelText = message;
    hud.detailsLabelFont = [UIFont systemFontOfSize:15];
    hud.detailsLabelColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
    //动画加载
    hud.mode = MBProgressHUDModeIndeterminate;
    
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    hud.animationType =
    // YES代表需要蒙版效果
    hud.dimBackground = NO;
    hud.backgroundColor = [UIColor clearColor];
    hud.color = [UIColor blackColor];
    hud.activityIndicatorColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
    return hud;
}

+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view {
    if (view == nil) {
        view = [[UIApplication sharedApplication].windows lastObject];
    }
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.detailsLabelText = message;
    hud.detailsLabelFont = [UIFont systemFontOfSize:12];
    hud.detailsLabelColor = [UIColor whiteColor];
    //添加动态加载logo
    hud.mode = MBProgressHUDModeCustomView;
    LoadingImageView *loadImageView = [[LoadingImageView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
    hud.customView = loadImageView;
    
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    hud.animationType =
    // YES代表需要蒙版效果
    hud.dimBackground = NO;
    hud.backgroundColor = [UIColor clearColor];
    hud.color = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.601479388297872];
    return hud;
}

+ (MBProgressHUD *)showtip:(NSString *)message toView:(UIView *)view {
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.detailsLabelText = message;
    hud.detailsLabelFont = [UIFont systemFontOfSize:15];
    hud.detailsLabelColor = [UIColor colorWithRed:0.3258 green:0.3258 blue:0.3258 alpha:1.0];
    //动画加载
    hud.mode = MBProgressHUDModeCustomView;
    UIImageView *gifImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 62, 62)];
    gifImg.image = [UIImage sd_animatedGIFNamed:@"loading"];
    hud.customView = gifImg;
    
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    // YES代表需要蒙版效果
    hud.dimBackground = NO;
    hud.backgroundColor = [UIColor clearColor];
    hud.color = [UIColor clearColor];;
//        hud.activityIndicatorColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
    return hud;
}

+ (MBProgressHUD *)showNOData:(NSString *)message toView:(UIView *)view {
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.detailsLabelText = message;
    hud.detailsLabelFont = [UIFont systemFontOfSize:15];
    hud.detailsLabelColor = [UIColor colorWithRed:0.5296 green:0.5296 blue:0.5296 alpha:1.0];
    hud.yOffset = -20;
    //动画加载
    hud.mode = MBProgressHUDModeCustomView;
    UIImageView *noDataImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 77, 53)];
    noDataImage.image = [UIImage imageNamed:@"img_no_more"];
    hud.customView = noDataImage;
    
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    // YES代表需要蒙版效果
    hud.dimBackground = NO;
    hud.backgroundColor = [UIColor clearColor];
    hud.color = [UIColor clearColor];
    return hud;
}

+ (void)showSuccess:(NSString *)success
{
    [self showSuccess:success toView:nil];
}

+ (void)showError:(NSString *)error
{
    [self showError:error toView:nil];
}

+ (MBProgressHUD *)showMessage:(NSString *)message
{
    return [self showMessage:message toView:nil];
}

+ (void)hideHUDForView:(UIView *)view
{
    [self hideHUDForView:view animated:YES];
}

+ (void)hideHUD
{
    [self hideHUDForView:nil];
}
@end

