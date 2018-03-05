//
//  ErrorViewModel.swift
//  YKFSwift
//
//  Created by 魏子建 on 2017/4/13.
//  Copyright © 2017年 魏子建. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class ErrorViewModel {
    static let errorVM = ErrorViewModel()
    let errorShow = PublishSubject<Dictionary<String, Any>>()
    
}
