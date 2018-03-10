//
//  EndLessUITableView.m
//  TextHAHAHAHAHHA
//
//  Created by haohao on 2018/3/5.
//  Copyright © 2018年 haohao. All rights reserved.
//

#import "EndLessUITableView.h"
#import "SUTableViewInterceptor.h"


@interface EndLessUITableView ()

@property (nonatomic, strong) SUTableViewInterceptor *dataSourceInterceptor;

@property (nonatomic, assign) NSInteger actualRows;

@end

@implementation EndLessUITableView

- (void)layoutSubviews {
    [self resetContentOffsetIfNeeded];
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


- (void)setDataSource:(id<UITableViewDataSource>)dataSource {
    [super setDataSource:dataSource];
    self.dataSourceInterceptor.receive = dataSource;
}

- (SUTableViewInterceptor *)dataSourceInterceptor {
    if (_dataSourceInterceptor == nil) {
        _dataSourceInterceptor = [[SUTableViewInterceptor alloc] init];
    }
    return _dataSourceInterceptor;
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section {
    self.actualRows = [self.dataSourceInterceptor.receive tableView:tableView numberOfRowsInSection:section];
    return self.actualRows * 3;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSIndexPath *actulIndexPath = [NSIndexPath indexPathForRow:indexPath.row % self.actualRows inSection:indexPath.section];
    return [self.dataSourceInterceptor.receive tableView:tableView cellForRowAtIndexPath:actulIndexPath];
}




@end
