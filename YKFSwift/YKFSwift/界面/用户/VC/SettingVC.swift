//
//  SettingVC.swift
//  YKFSwift
//
//  Created by 魏子建 on 2017/4/12.
//  Copyright © 2017年 魏子建. All rights reserved.
//

import UIKit

class SettingVC: YKFViewController, UITableViewDelegate, UITableViewDataSource {
    
    let tableView = UITableView.init(frame: CGRect.init(x: 0, y: 10, width: SCREEN.width, height: SCREEN.height), style: UITableViewStyle.plain)
    let logoutBtn = UIButton.init(type: UIButtonType.custom)
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUI()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setUI() -> Void {
        self.view.addSubview(self.tableView)
        self.tableView.backgroundColor = RGBCOLOR(r: 0.933, g: 0.933, b: 0.933)
        self.tableView.bounces = false
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.tableFooterView = UIView()
        
        self.logoutBtn.frame = CGRect.init(x: 0, y: 184, width: SCREEN.width, height: 50)
        self.logoutBtn.backgroundColor = UIColor.white
        self.logoutBtn.setTitle("退出登录", for: UIControlState.normal)
        self.logoutBtn.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        self.logoutBtn.setTitleColor(UIColor.red, for: UIControlState.normal)
        logoutBtn.addTarget(self, action: #selector(logout), for: UIControlEvents.touchUpInside)
        self.view.addSubview(self.logoutBtn)
    }
    
    // MARK: - tableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("YKFTableViewCell", owner: self, options: nil)?.first as! YKFTableViewCell
        let loginIntro = LoginIntroModel()
        
        if indexPath.row == 0 {
            cell.leftLB.text = "账号"
            cell.centerLB.text = loginIntro.userName
            cell.topline.isHidden = false
            cell.bottomLineLeading = 20
            print(cell.contentView.subviews)
        } else {
            cell.leftLB.text = "修改登录密码"
            cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        }
        return cell
    }

    func logout() -> Void {
        UIAlertController.alertShow(viewController: self, title: "", message: "您确定要退出登录吗?", determineAction: "确定", cancelAction: "取消", determine: { 
            HTTPRequst().POST(urlString: path(ulrString: URL_LoginOut), parameter: nilParameter, success: { (jsonData) -> (Void) in
                UserDefaults.standard.set(false, forKey: "loginStatus")
                UserDefaults.standard.setValue("", forKey: "sessionId")
                MBProgressHUD.showSuccess("退出登录成功")
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5, execute: {
                    self.navigationController?.popViewController(animated: true)
                })
                self.tabBarController?.selectedIndex = 0
            }) { (error) -> (Void) in
                
            }
        }) { 
            
        }
        
    }

}
