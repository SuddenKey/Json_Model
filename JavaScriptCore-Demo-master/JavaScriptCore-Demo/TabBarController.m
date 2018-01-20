//
//  TabBarController.m
//  JavaScriptCore-Demo
//
//  Created by haohao on 2018/1/20.
//  Copyright © 2018年 www.skyfox.org. All rights reserved.
//

#import "TabBarController.h"
#import "RootViewController.h"
#import "SecondViewController.h"
#import "JSCallOCViewController.h"
#import "OCCallJSViewController.h"
#import "BaseViewController.h"
#import "RootViewController.h"
@interface TabBarController ()

@end

@implementation TabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addChildViewControllers];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addChildViewControllers{
    BaseViewController *myInfo = [self setChildView:[[RootViewController alloc] init] title:@"我的" imageName:@"My_select_icon" selectedImageName:@"My_selected_icon"];
    
    BaseViewController *orderList = [self setChildView:[[OCCallJSViewController alloc] init] title:@"订单" imageName:@"Order_select_icon" selectedImageName:@"Order_selected_icon"];
    
    //    BaseNaviViewController *addOrder = [self setChildView:[[AddOrderViewController alloc] init] title:@"加单" imageName:@"Add_select_icon" selectedImageName:@"Add_selected_icon"];
    
    BaseViewController *home = [self setChildView:[[JSCallOCViewController alloc] init] title:@"首页" imageName:@"Home_select_icon" selectedImageName:@"Home_selected_icon"];
    
    
    NSArray *viewControllers = @[home,orderList, myInfo];
    [self setViewControllers:viewControllers animated:YES];
}

- (BaseViewController *)setChildView:(UIViewController *)childvc title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName{
    BaseViewController *navPeopleCenter = [[BaseViewController alloc] initWithRootViewController:childvc];
    navPeopleCenter.navigationBarHidden = NO;
    navPeopleCenter.tabBarItem.title = title;
    childvc.title = title;
    navPeopleCenter.tabBarItem.image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    navPeopleCenter.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor blackColor];
    textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:10];
    [navPeopleCenter.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    
    NSMutableDictionary *selectedTextAttrs = [NSMutableDictionary dictionary];
//    selectedTextAttrs[NSForegroundColorAttributeName] = kMainColor ;
    [navPeopleCenter.tabBarItem setTitleTextAttributes:selectedTextAttrs forState:UIControlStateSelected];
    navPeopleCenter.tabBarItem.titlePositionAdjustment =UIOffsetMake(0, -5);
    
    return navPeopleCenter;
}

@end
