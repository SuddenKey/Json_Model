//
//  NullTool.swift
//  YKFSwift
//
//  Created by 魏子建 on 2017/4/14.
//  Copyright © 2017年 魏子建. All rights reserved.
//

import UIKit

class NullTool : NSObject {

    static func isNullOrBlank(value : AnyObject) -> Bool {
        if value.isKind(of: NSNull.self) {
            return true
        }
        if value == nil {
            return true
        }
        if value.isEqual("") {
            return true
        }
        if value.isEqual("null") {
            return true
        }
        if value.isEqual("(null)") {
            return true
        }
        if value.isEqual("<null>") {
            return true
        }
        return false
    }
}
