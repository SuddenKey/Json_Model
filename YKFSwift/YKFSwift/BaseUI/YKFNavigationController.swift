//
//  YKFNavigationController.swift
//  YKFSwift
//
//  Created by 魏子建 on 2017/3/22.
//  Copyright © 2017年 魏子建. All rights reserved.
//

import UIKit

class YKFNavigationController: UINavigationController, UIGestureRecognizerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.interactivePopGestureRecognizer?.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer == self.interactivePopGestureRecognizer {
            if self.viewControllers.count == 1 {
                return false
            } else {
                return true
            }
        }
        return true
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if self.viewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
            let backBtn = UIButton.init(type: UIButtonType.custom)
            backBtn.frame = CGRect.init(x: 0, y: 0, width: 20, height: 30)
            backBtn.setImage(UIImage.init(named: "btn_back"), for: UIControlState.normal)
            backBtn.addTarget(self, action: #selector(YKFNavigationController.back), for: UIControlEvents.touchUpInside)
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: backBtn)
        }
        super.pushViewController(viewController, animated: animated)
    }
    
    func back() -> Void {
        self.popViewController(animated: true)
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
