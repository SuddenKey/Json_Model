//
//  HomeHospModel.swift
//  YKFSwift
//
//  Created by 魏子建 on 2017/3/31.
//  Copyright © 2017年 魏子建. All rights reserved.
//

import UIKit

class HomeHospModel: BaseModel {
    var hospId = ""                         //医院ID
    var hospName = ""                       //医院名称
    var level = ""                          //医院等级
    var hospPicUrl = ""                     //医院图片地址
    var distance = ""                       //距离
    var hospSName = ""                      //医院简称
    var longitude = ""                      //经度
    var latitude = ""                       //纬度
    var area = ""                           //地址
    var tagList : Array<TagList>  = []      //	标签列表

}

class TagList: BaseModel {
    var servId = ""                         //	服务ID
    var servName = ""                       //	服务名称
    var color = ""                          //	服务功能标签颜色
}
