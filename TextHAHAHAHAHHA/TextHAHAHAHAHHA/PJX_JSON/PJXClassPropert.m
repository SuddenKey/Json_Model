//
//  PJXClassPropert.m
//  TextHAHAHAHAHHA
//
//  Created by haohao on 2018/1/17.
//  Copyright © 2018年 haohao. All rights reserved.
//

#import "PJXClassPropert.h"
#import <objc/runtime.h>
@interface PJXClassPropert ()
@property (nonatomic, assign) objc_objectptr_t property;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) SEL setter;
@end

@implementation PJXClassPropert

- (instancetype)initWithPeopleInfo:(objc_objectptr_t)property {
    self = [super init];
    if (self) {
        _property = property;
        
        const char *name = property_getName(property);
        if (name) {
            _name = [NSString stringWithUTF8String:name];
        }
        NSString *setter = [NSString stringWithFormat:@"%@%@", [_name substringFromIndex:1].uppercaseString, [_name substringFromIndex:1]];
        
        _setter = NSSelectorFromString([NSString stringWithFormat:@"set%@:", setter]);
    }
    return self;
}

@end
