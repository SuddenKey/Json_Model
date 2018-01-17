//
//  PJXClassInfo.m
//  TextHAHAHAHAHHA
//
//  Created by haohao on 2018/1/17.
//  Copyright © 2018年 haohao. All rights reserved.
//

#import "PJXClassInfo.h"
#import "PJXPropertyInfo.h"
#import <objc/runtime.h>
@interface PJXClassInfo()

@end

@implementation PJXClassInfo

- (instancetype)initWithClassInfo:(Class)cls {
    self = [super init];
    unsigned int propertyCount = 0;
    objc_property_t *properties = class_copyPropertyList(cls, &propertyCount);
    _peopletyInfos = [NSMutableDictionary dictionary];
    
    if (properties) {
        for (unsigned int i = 0; i < propertyCount; i++) {
            PJXPropertyInfo *prepertyInfo = [[PJXPropertyInfo alloc] initWithPeopleInfo:properties[i]];
            _peopletyInfos[prepertyInfo.name] = prepertyInfo;
        }
        free(properties);
    }
    return self;
}

@end
