//
//  ViewController.m
//  BlueTooth
//
//  Created by haohao on 2018/3/7.
//  Copyright © 2018年 haohao. All rights reserved.
//

#import "ViewController.h"
#import <CoreBluetooth/CoreBluetooth.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)setSubView {
    _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, <#CGFloat width#>, <#CGFloat height#>) style:<#(UITableViewStyle)#>];
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    [self.view addSubview:_myTableView];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return <#expression#>;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return <#expression#>;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *<#identifier#> = @"<#cell#>";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell =  [[UITableViewCell alloc] initWithStyle:<#(UITableViewCellStyle)#> reuseIdentifier:<#(nullable NSString *)#>]
    }
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return <#expression#>;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return <#expression#>;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return <#expression#>;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KWidthSCREEN, 0.0001)];
    return headerView;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KWidthSCREEN, 6)];
    return headerView;
}


-(void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath

{
    if(indexPath.row == ((NSIndexPath*)[[tableView indexPathsForVisibleRows]lastObject]).row){
        dispatch_async(dispatch_get_main_queue(), ^{
            MyLog(@"%lf", tableView.contentSize.height);
            if (_footView == nil) {
                _footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KWidthSCREEN, KHeightSCREEN - tableView.contentSize.height)];
                _footView.backgroundColor = [UIColor whiteColor];
                _myTableView.tableFooterView = _footView;
            }
        });
    }
}

@end
