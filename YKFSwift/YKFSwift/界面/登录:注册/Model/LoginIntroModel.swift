//
//  LoginIntroModel.swift
//  YKFSwift
//
//  Created by 魏子建 on 2017/4/10.
//  Copyright © 2017年 魏子建. All rights reserved.
//

import UIKit

class LoginIntroModel {
    var userName = ""
    var loginStatus = false
    var patnNum = ""
    var sessionId = ""
    init() {
        userName = String.value(object: UserDefaults.standard.value(forKey: "userName"))
        loginStatus =  UserDefaults.standard.bool(forKey: "loginStatus")
        patnNum = String.value(object: UserDefaults.standard.value(forKey: "patnNum"))
        sessionId = String.value(object: UserDefaults.standard.value(forKey: "sessionId"))
    }
}

