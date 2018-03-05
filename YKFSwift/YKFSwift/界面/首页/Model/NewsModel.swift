//
//  NewsModel.swift
//  YKFSwift
//
//  Created by 魏子建 on 2017/3/31.
//  Copyright © 2017年 魏子建. All rights reserved.
//

import UIKit

class NewsModel: BaseModel {
    var next = ""                           //  0 代表没有下一页；1 代表有下一页
    var count = ""                          //  条数
    var newsList : Array<NewsList> = []     //  最新资讯列表
}

class NewsList: BaseModel {
    var newsPicUrl = ""                     //  图片地址
    var title = ""                          //  资讯标题
    var time = ""                           //  时间
    var tagName = ""                        //  类型 ？传key？
    var tagColor = ""                       //  类型颜色
    var newsId = ""                         //  资讯ID
    var newsUrl = ""                        //  资讯详情链接
}
