//
//  HomeTBViewModel.swift
//  YKFSwift
//
//  Created by 魏子建 on 2017/3/23.
//  Copyright © 2017年 魏子建. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources


class HomeViewModel {
    
    let disposeBag = DisposeBag()
    
    let refreshSdcy = PublishSubject<Array<HomeBannerModel>>()
    
    let refreshNearbyHosp = PublishSubject<Array<HomeHospModel>>()
    
    let refreshNews = PublishSubject<NewsModel>()
    
    let refreshUI = PublishSubject<String>()
    
    
    let cellDiDsubject = PublishSubject<IndexPath>()
    
    var hospArray : Array<HomeHospModel> = []
    var bannerArray : Array<HomeBannerModel> = []
//    var newsArray : Array<NewsList> = []

    init() {
        
        self.getBannerData()
        self.getNearbyHospitalData()
        self.getNewsData()
        
        self.refreshUI.subscribe(onNext: { (str) in
            self.getBannerData()
            self.getNearbyHospitalData()
            self.getNewsData()
        }, onError: nil, onCompleted: nil, onDisposed: nil).addDisposableTo(disposeBag)
        
        self.cellDidSelect()
    }
    
    func getBannerData() -> Void {
        HTTPRequst.init().POST(urlString: path(ulrString: URL_SdcyImage), parameter: nilParameter, success: { (jsonData) -> (Void) in
            let array = jsonData.arrayObject!
            
            for value in array {
                let bannerModel = HomeBannerModel().model(dictionary: value as! Dictionary<String, Any>) as! HomeBannerModel
                self.bannerArray.append(bannerModel)
            }
            self.refreshSdcy.onNext(self.bannerArray)
        }, fail: { (error) -> (Void) in
            
        })
    }
    
    func getNearbyHospitalData() -> Void {
        let parameter = ["showFlag": "0"]
        HTTPRequst.init().POST(urlString: path(ulrString: URL_HomeNearHospList), parameter: parameter, success: { (jsonData) -> (Void) in
            let array = jsonData.arrayObject!
            for value in array {
                let hospModel = HomeHospModel().model(dictionary: value as! Dictionary<String, Any>) as! HomeHospModel
                self.hospArray.append(hospModel)
            }
            self.refreshNearbyHosp.onNext(self.hospArray)

        }, fail: { (error) -> (Void) in
            
        })
    }
    
    func getNewsData() -> Void {
        let parameter = ["pageSize": pageCount, "pageNo" : "1"]
        HTTPRequst.init().POST(urlString: path(ulrString: URL_HomeNewsList), parameter: parameter, success: { (jsonData) -> (Void) in

      
            let newsModel = NewsModel().model(dictionary: jsonData.dictionaryObject!) as! NewsModel
            self.refreshNews.onNext(newsModel)
            
        }, fail: { (error) -> (Void) in
            
        })
        
    }
    
   
    
    func cellDidSelect() -> Void {
        self.cellDiDsubject.asObserver().subscribe(onNext: { (indexPath) in
            print(indexPath.section + indexPath.row)
        }, onError: nil, onCompleted: nil, onDisposed: nil).addDisposableTo(disposeBag)
    }

}
