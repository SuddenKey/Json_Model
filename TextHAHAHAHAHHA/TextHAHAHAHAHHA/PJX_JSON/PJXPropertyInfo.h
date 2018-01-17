//
//  PJXPropertyInfo.h
//  TextHAHAHAHAHHA
//
//  Created by haohao on 2018/1/17.
//  Copyright © 2018年 haohao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PJXPropertyInfo : NSObject

@property (nonatomic, assign) objc_objectptr_t property;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) SEL setter;

- (instancetype)initWithPeopleInfo:(objc_objectptr_t)property;

@end
