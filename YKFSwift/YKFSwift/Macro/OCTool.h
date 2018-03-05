//
//  OCTool.h
//  YKFSwift
//
//  Created by 魏子建 on 2017/3/30.
//  Copyright © 2017年 魏子建. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

static const char *property_getTypeName(objc_property_t property) {
    const char *attributes = property_getAttributes(property);
    char buffer[1 + strlen(attributes)];
    strcpy(buffer, attributes);
    char *state = buffer, *attribute;
    while ((attribute = strsep(&state, ",")) != NULL) {
        if (attribute[0] == 'T') {
            size_t len = strlen(attribute);
            attribute[len - 1] = '\0';
            return (const char *)[[NSData dataWithBytes:(attribute + 3) length:len - 2] bytes];
        }
    }
    return "@";
}

@interface OCTool : NSObject

@end
