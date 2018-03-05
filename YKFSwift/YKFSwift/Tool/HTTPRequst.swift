//
//  HTTPRequst.swift
//  YKFSwift
//
//  Created by 魏子建 on 2017/3/22.
//  Copyright © 2017年 魏子建. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


class HTTPRequst: NSObject {
    
    typealias successBlock = (JSON)->(Void)
    typealias failBlock = (Error)->(Void)
    func POST(urlString: String, parameter:Dictionary<String, Any>, success:@escaping successBlock, fail:@escaping failBlock) -> Void {
        let loginIntro = LoginIntroModel()
        
        var par = ["v" : VersionNum, "s" : loginIntro.sessionId]
        for key in parameter.keys {
            par[key] = parameter[key] as? String
        }
        Alamofire.request(urlString, method:HTTPMethod.post, parameters: par, encoding:URLEncoding.default, headers:nil).responseJSON { (response) in
            switch response.result {
            case .success(let value):
                let responseData = ResponseData.init(value: value as! Dictionary<String, Any>)
                if responseData.code == "0" {
                    success(responseData.data)
                } else {
                    let errorDic = ["errorType" : "1", "errorMsg" : responseData, "url" : urlString] as [String : Any]
                    ErrorViewModel.errorVM.errorShow.onNext(errorDic)
                }
            
            case .failure(let error):
                fail(error as Error)
                let errorDic = ["errorType" : "2", "errorMsg" : error] as [String : Any]
                ErrorViewModel.errorVM.errorShow.onNext(errorDic)
            }
        }

    }
    
}

class ResponseData {
    var code = ""
    var errCode = ""
    var msg = ""
    var action = ""
    var data : JSON
    
    init(value : Dictionary<String, Any>) {
        code = String.value(object: value["code"])
        errCode = String.value(object: value["errCode"])
        msg = String.value(object: value["msg"])
        action = String.value(object: value["action"])
        data = JSON.init(value["data"] as Any)
    }
}
