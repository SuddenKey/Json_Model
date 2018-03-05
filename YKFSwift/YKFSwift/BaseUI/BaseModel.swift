//
//  BaseModel.swift
//  YKFSwift
//
//  Created by 魏子建 on 2017/3/28.
//  Copyright © 2017年 魏子建. All rights reserved.
//

import UIKit
import ObjectiveC.NSObjCRuntime


class BaseModel: NSObject {

    var propertyType : Dictionary<String , String> = [:]

    
    func model(dictionary : Dictionary<String, Any>) -> AnyObject {
        
        if NullTool.isNullOrBlank(value: dictionary as AnyObject) {
            
        } else {
            let propertyArray = self.propertyNames(aClass: self.classForCoder) as! Array<String>
 
            for key in propertyArray {
                
                var value = dictionary[key] as AnyObject
                
                if NullTool.isNullOrBlank(value: value) {
                    let type = propertyType[key]
                    if type == "NSArray" {
                        value = [] as AnyObject
                    } else if type == "NSDictionary" {
                        value = [:] as AnyObject
                    } else {
                        value = "" as AnyObject
                    }
                }
                
                if value.isKind(of: NSDictionary.classForCoder())  {
                    let str1 = key.substringToIndex(index: 1)
                    let str2 = key.substringFromIndex(index: 1)
                    let className = "YKFSwift.\(str1.capitalized)\(str2)"
                    
                    let type : AnyClass? = NSClassFromString(className)!
                    let model = type as! NSObject.Type
                    let aa = model.init() as! BaseModel
                    value = aa.model(dictionary: value as! Dictionary<String, Any>)
                
                } else if value.isKind(of: NSArray.classForCoder()) {
                    var childObjects : Array<Any> = []
                    for child in value as! Array<AnyObject>  {
                        if child.classForCoder.isSubclass(of: NSDictionary.classForCoder()) {
                            let str1 = key.substringToIndex(index: 1)
                            let str2 = key.substringFromIndex(index: 1)
                            let className = "YKFSwift.\(str1.capitalized)\(str2)"
                            
                            let arrayItemType : AnyClass = NSClassFromString(className)!
                    
                            if arrayItemType.isSubclass(of: NSDictionary.classForCoder()) {
                                childObjects.append(child)
                            } else if arrayItemType.isSubclass(of: BaseModel.classForCoder()) {
                                
                                let type : AnyClass? = NSClassFromString(className)!
                                let model = type as! NSObject.Type
                                let aa = model.init() as! BaseModel
                                let model1 = aa.model(dictionary: child as! Dictionary<String, Any>)
                                childObjects.append(model1)
                            }
                        } else {
                            childObjects.append(child)
                        }
                    }
                    value = childObjects as AnyObject
                }
                if value.isKind(of: NSArray.classForCoder()) {
                    self.setValue(value, forKey: key)
                } else if value.isKind(of: NSDictionary.classForCoder()){
                    self.setValue(value, forKey: key)
                } else {
                    let str = String.value(object: value)
                    self.setValue(str, forKey: key)
                }
            }
        }
        return self
    }
    
    func propertyNames(aClass : AnyClass) -> Array<Any> {
        let className = NSStringFromClass(aClass)
        if className == "BaseModel" {
            return []
        }
        var propertyArray : Array<Any> = []
        var propertyCount : UInt32 = 0
        let properties = class_copyPropertyList(aClass, &propertyCount)
        for i in 0..<propertyCount {
            let property : objc_property_t = properties![Int(i)]!
            let propertyName = String.init(cString: property_getName(property))
            propertyArray.append(propertyName)
            let type = String.init(cString: property_getTypeName(property))
            propertyType[propertyName] = type
        }
        free(properties)
        return propertyArray
    }

}




