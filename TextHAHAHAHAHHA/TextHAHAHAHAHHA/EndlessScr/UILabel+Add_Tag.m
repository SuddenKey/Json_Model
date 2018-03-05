//
//  UILabel+Add_Tag.m
//  TextHAHAHAHAHHA
//
//  Created by haohao on 2018/2/27.
//  Copyright © 2018年 haohao. All rights reserved.
//

#import "UILabel+Add_Tag.h"
#import <objc/runtime.h>

@implementation UILabel (Add_Tag)

- (void)setBaseTag:(NSString *)baseTag {
    objc_setAssociatedObject(self, @selector(setBaseTag:), baseTag, OBJC_ASSOCIATION_COPY);
}

- (NSString *)baseTag {
    return objc_getAssociatedObject(self, @selector(baseTag));
}

@end
