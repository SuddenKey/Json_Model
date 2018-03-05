//
//  UrlContancts.swift
//  YKFSwift
//
//  Created by 魏子建 on 2017/3/27.
//  Copyright © 2017年 魏子建. All rights reserved.
//

import UIKit

let nilParameter = Dictionary<String, Any>()
let pageCount = "12"
let VersionNum = "2.4"



func path(ulrString : String) -> String {
    let url = "http://test.dabay.com.cn:8680/app_web/v2"
//    let url = "https://app3.dabay.cn/app_web/v2"
    return (url + ulrString)
}

//首页
let URL_SdcyImage = "/index/banner"             //首页轮播图
let URL_HomeNearHospList = "/hosp/nearby"       //首页附近医院列表接口
let URL_HomeNewsList = "/news/list"       //首页附近医院列表接口

//用户
let URL_UserIntro = "/user/info"

//登录/注册
let URL_Login = "/user/login"                   //登录(普通)
let URL_LoginOut = "/user/logout";         //退出登录

