//
//  YKFViewController.swift
//  YKFSwift
//
//  Created by 魏子建 on 2017/3/22.
//  Copyright © 2017年 魏子建. All rights reserved.
//

import UIKit
import RxSwift

class YKFViewController: UIViewController {
    
    var isPresent = false
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        // Do any additional setup after loading the view.
        ErrorViewModel.errorVM.errorShow.subscribe(onNext: { (objc) in
            if !self.isSignLogin(object: objc) {
                self.errorShow(objc: objc)
            }
            
        }, onError: nil, onCompleted: nil, onDisposed: nil).addDisposableTo(disposeBag)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addBackBtn(isPresent : Bool) -> Void {
        let backBtn = UIButton.init(type: UIButtonType.custom)
        backBtn.frame = CGRect.init(x: 0, y: 0, width: 20, height: 30)
        backBtn.setImage(UIImage.init(named: "btn_back"), for: UIControlState.normal)
        backBtn.addTarget(self, action: #selector(YKFViewController.back), for: UIControlEvents.touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: backBtn)
        self.isPresent = isPresent
    }
    
    func back() -> Void {
        if self.isPresent {
            self.dismiss(animated: true, completion: nil)
        } else {
            self.navigationController?.popViewController(animated: true)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func userLogin() -> Void {
        let loginIntroModel = LoginIntroModel()
        if !loginIntroModel.loginStatus {
            let loginVC = LoginVC()
            let navC = YKFNavigationController.init(rootViewController: loginVC)
            self.present(navC, animated: true, completion: nil)
        }
    }
    
    func errorShow(objc : Dictionary<String, Any>) -> Void {
        let errorType = objc["errorType"] as! String
        let responseData = objc["errorMsg"] as! ResponseData
        var errorMessage = ""
        if errorType == "1" {
            let errorShow = UserDefaults.standard.bool(forKey: "errorShow")
            if !errorShow {
                return
            } else {
                UserDefaults.standard.set(false, forKey: "errorShow")
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3, execute: {
                    UserDefaults.standard.set(true, forKey: "errorShow")
                })
            }
            let errorCode = responseData.errCode
            var errorMsg = responseData.msg

            
            if NullTool.isNullOrBlank(value: errorMsg as AnyObject) && !NullTool.isNullOrBlank(value: errorCode as AnyObject) {
                errorMsg = "系统繁忙，请稍后重试"
                errorMessage = "\(errorMsg) [\(errorCode)]"
            }
            if NullTool.isNullOrBlank(value: errorCode as AnyObject) {
                errorMessage = errorMsg
            }
            if NullTool.isNullOrBlank(value: errorMsg as AnyObject) && NullTool.isNullOrBlank(value: errorCode as AnyObject) {
                errorMessage = "系统繁忙，请稍后重试"
            }
        }
        if errorMessage == "请先登录" {
            UserDefaults.standard.set(false, forKey: "loginStatus")
        }
        if responseData.action == "10" {
            UIAlertController.alertShow(viewController: self, title: "提示", message: errorMessage, determineAction: "我知道了", cancelAction: "", determine: {
                print(errorMessage)
            }) {
                print("cancle")
            }
        } else {
            MBProgressHUD.showError(errorMessage, to: self.view)
        }
    }
    
   private func isSignLogin(object : Dictionary<String, Any>) -> Bool {
        var result = false
        let errorType = object["errorType"] as! String
        if errorType == "1" {
            let responseData = object["errorMsg"] as! ResponseData
            if responseData.code == "2" {
                UserDefaults.standard.set(false, forKey: "loginStatus")
                UIAlertController.alertShow(viewController: self, title: "", message: responseData.msg, determineAction: "立即登录", cancelAction: "", determine: {
                    self.userLogin()
                }) {
                }
                result = true
            }
        }
        return result
    }

}
