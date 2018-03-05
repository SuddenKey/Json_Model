//
//  LoginViewModel.swift
//  YKFSwift
//
//  Created by 魏子建 on 2017/4/7.
//  Copyright © 2017年 魏子建. All rights reserved.
//

import UIKit
import RxSwift

enum Result {
    case ok
    case showMessage(message : String)
//    case valid(result : Bool)
    var valid : Bool {
        switch self {
        case .ok:
            return true
        default:
            return false
        }
    }
    
    func show(value : String) -> Result {
        return Result.showMessage(message: value)
    }
}

class LoginViewModel {
    
    
    let disposeBag = DisposeBag()
    
    let userName = Variable<String>("")
    let password = Variable<String>("")
    
    let loginAction = PublishSubject<String>()
    let loginResult = PublishSubject<Bool>()
    
    init() {
        loginAction.subscribe(onNext: { (str) in
            self.login()
        }, onError: nil, onCompleted: nil, onDisposed: nil).addDisposableTo(disposeBag)
    }
    
    func login() -> Void {
        let uuid = UIDevice.current.identifierForVendor?.uuidString
        let passwordStr = SecurityUtil.encryptAESData(password.value)
        let parameter : Dictionary<String, Any> = ["mobile" : userName.value, "password" : passwordStr ?? String(), "deviceType" : "2", "deviceCode" : uuid ?? String()]
        HTTPRequst.init().POST(urlString: path(ulrString: URL_Login), parameter: parameter, success: { (jsonData) -> (Void) in
            UserDefaults.standard.setValue(self.userName.value, forKey: "userName")
            UserDefaults.standard.set(true, forKey: "loginStatus")
            UserDefaults.standard.setValue(jsonData["sessionId"].string, forKey: "sessionId")
            self.loginResult.onNext(true)
        }) { (error) -> (Void) in
            
        }
        
    }
}
