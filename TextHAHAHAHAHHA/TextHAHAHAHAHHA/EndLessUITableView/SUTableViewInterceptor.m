//
//  SUTableViewInterceptor.m
//  TextHAHAHAHAHHA
//
//  Created by haohao on 2018/3/10.
//  Copyright © 2018年 haohao. All rights reserved.
//

#import "SUTableViewInterceptor.h"

@implementation SUTableViewInterceptor

#pragma mark - forward & respone override

- (id)forwardingTargetForSelector:(SEL)aSelector {
    if ([self.receive respondsToSelector:aSelector]) {return self.receive;}
    if ([self.middleman respondsToSelector:aSelector]) {return self.middleman;}
    return [super forwardingTargetForSelector:aSelector];
}

- (BOOL)respondsToSelector:(SEL)aSelector {
    if ([self.receive respondsToSelector:aSelector]) {return self.receive;}
    if ([self.middleman respondsToSelector:aSelector]) {return self.middleman;}
    return [super respondsToSelector:aSelector];
}

@end
