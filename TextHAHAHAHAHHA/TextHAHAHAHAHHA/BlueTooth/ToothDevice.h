//
//  ToothDevice.h
//  TextHAHAHAHAHHA
//
//  Created by haohao on 2018/3/7.
//  Copyright © 2018年 haohao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ToothDevice : NSObject

@property (nonatomic, copy) NSString *kCBAdvDataLocalName;
@property (nonatomic, copy) NSString *kCBAdvDataManufacturerData;
@property (nonatomic, copy) NSString *kCBAdvDataIsConnectable;
@property (nonatomic, strong) NSArray *kCBAdvDataServiceUUIDs;

@end
