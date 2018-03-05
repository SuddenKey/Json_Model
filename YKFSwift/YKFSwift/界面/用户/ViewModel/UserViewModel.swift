//
//  UserViewModel.swift
//  YKFSwift
//
//  Created by 魏子建 on 2017/4/10.
//  Copyright © 2017年 魏子建. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class UserViewModel {
    
    static let instance: UserViewModel = UserViewModel()
    
    let disposeBag = DisposeBag()
    let getUserIntro = PublishSubject<UserIntroModel>()
    let refreshUserIntro = PublishSubject<String>()
    let cellDiDsubject = PublishSubject<IndexPath>()
    
    init() {
        self.getUserIntroData()
        self.refreshUserIntro.subscribe(onNext: { (str) in
            self.getUserIntroData()
        }, onError: nil, onCompleted: nil, onDisposed: nil).addDisposableTo(disposeBag)
        self.cellDiDsubject.subscribe(onNext: { (indexPath) in
            self.cellDidSelect(index: indexPath)
        }, onError: nil, onCompleted: nil, onDisposed: nil).addDisposableTo(disposeBag)
    }
    
    func getUserIntroData() -> Void {
        let loginIntro = LoginIntroModel.init()
        if !loginIntro.loginStatus {
            return
        }
        let uuid = UIDevice.current.identifierForVendor?.uuidString
        let parameter : Dictionary<String, Any> = ["deviceCode" : uuid ?? String()]
        
        HTTPRequst().POST(urlString: path(ulrString: URL_UserIntro), parameter: parameter, success: { (jsonData) -> (Void) in
            
            let introModel = UserIntroModel().model(dictionary: jsonData.dictionaryObject!) as! UserIntroModel
            self.getUserIntro.onNext(introModel)
        }) { (error) -> (Void) in
            print(error)
        }
    }
    
    func cellDidSelect(index : IndexPath) -> Void {
        
    }
}
