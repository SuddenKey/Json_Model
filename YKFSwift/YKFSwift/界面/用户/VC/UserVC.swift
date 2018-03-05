//
//  UserVC.swift
//  YKFSwift
//
//  Created by 魏子建 on 2017/4/1.
//  Copyright © 2017年 魏子建. All rights reserved.
//

import UIKit

class UserVC: YKFViewController, UITableViewDelegate, UITableViewDataSource {
    
    let tableView = UITableView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN.width, height: SCREEN.height), style: UITableViewStyle.grouped)
    
    let headerView = UserHeaderView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN.width, height: 170 + 75))
    
    var userIntroModel = UserIntroModel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        UserViewModel.instance
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setUI()
        self.bindViewModel()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.barStyle = UIBarStyle.blackOpaque
    self.navigationController?.navigationBar.setBackgroundImage(UIImage.init(named: "bg_blank"), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage.init(named: "bg_blank")
        let loginIntroModel = LoginIntroModel()
        if !loginIntroModel.loginStatus {
            self.headerView.userBtn.setTitle("注册/登录", for: UIControlState.normal)
            self.headerView.avatarIcon.image = UIImage.init(named: "img_head");
        } else {
            UserViewModel.instance.refreshUserIntro.onNext("")
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.barStyle = UIBarStyle.default
        self.navigationController?.navigationBar.setBackgroundImage(UIImage.init(named: ""), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage.init(named: "")
    }
    
    func setUI() -> Void {
        self.automaticallyAdjustsScrollViewInsets = false
        
        self.tableView.tableHeaderView = headerView
        headerView.userBtn.addTarget(self, action: #selector(UserVC.userLogin), for: UIControlEvents.touchUpInside)
        self.tableView.bounces = false
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.view.addSubview(self.tableView)
        
        let messageBtn = UIButton.init(type: UIButtonType.custom)
        messageBtn.frame = CGRect.init(x: 0, y: 0, width: 17, height: 21)
        messageBtn.setBackgroundImage(UIImage.init(named: "icon_message"), for: UIControlState.normal)
        messageBtn.addTarget(self, action: #selector(userMessage), for: UIControlEvents.touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: messageBtn)
        
        let setBtn = UIButton.init(type: UIButtonType.custom)
        setBtn.frame = CGRect.init(x: 0, y: 0, width: 20, height: 20)
        setBtn.setBackgroundImage(UIImage.init(named: "icon_set"), for: UIControlState.normal)
        setBtn.addTarget(self, action: #selector(userSetting), for: UIControlEvents.touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: setBtn)
    }
    
    func bindViewModel() -> Void {
        UserViewModel.instance.getUserIntro.subscribe(onNext: { (userModel) in
            self.userIntroModel = userModel
            self.headerView.avatarIcon.sd_setImage(with: URL.init(string: userModel.picUrl))
            self.headerView.userBtn.setTitle(userModel.userName, for: UIControlState.normal)
        }, onError: nil, onCompleted: nil, onDisposed: nil).addDisposableTo(disposeBag)
    }
    
    // MARK: - 跳转页面
    
    func userSetting() -> Void {
        let loginIntroModel = LoginIntroModel()
        if !loginIntroModel.loginStatus {
            self.userLogin()
        } else {
            let setVC = SettingVC()
            self.navigationController?.pushViewController(setVC, animated: true)
        }
    }
    
    func userMessage() -> Void {
        
    }

    // MARK: - tableView
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 3
        } else if section == 1 {
            return 2
        } else if section == 2 {
            return 4
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let titleArray = [["家庭成员", "我的病历号/就诊卡", "收藏医生"], ["支付密码", "指纹支付"], ["告诉好友", "邀请码", "帮助中心", "关于我们"]]
        let iconArray = [["icon_per_menu1", "icon_jzr", "icon_per_menu2"], ["icon_per_menu3", "icon_per_menu4"], ["icon_per_menu5", "icon_per_menu6", "icon_per_menu7", "icon_per_menu8"]]
        
        let cell = Bundle.main.loadNibNamed("UserFuncCell", owner: self, options: nil)?.first as! UserFuncCell
        cell.title.text = titleArray[indexPath.section][indexPath.row]
        cell.icon.image = UIImage.init(named: iconArray[indexPath.section][indexPath.row])
        if indexPath.row == 0 {
            cell.topline.isHidden = false
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let loginIntro = LoginIntroModel()
        if !loginIntro.loginStatus {
           self.userLogin()
        } else {
            
        }
        UserViewModel.instance.cellDiDsubject.onNext(indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = RGBCOLOR(r: 0.9166, g: 0.9166, b: 0.9166)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        footerView.backgroundColor = RGBCOLOR(r: 0.9166, g: 0.9166, b: 0.9166)
        return footerView
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
//    override func errorShow(objc: Dictionary<String, Any>) {
//        
//    }
}

class UserHeaderView: UIImageView {
    
    let avatarIcon = UIImageView.init(frame: CGRect.init(x: (SCREEN.width - 74) / 2.0, y: 52, width: 74, height: 74))
    
    let userBtn = UIButton.init(type: UIButtonType.custom)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.image = UIImage.init(named: "bg_person_top")
        self.isUserInteractionEnabled = true
        
        avatarIcon.image = UIImage.init(named: "img_head")
        avatarIcon.layer.cornerRadius = 37
        avatarIcon.clipsToBounds = true
        
        userBtn.frame = CGRect.init(x: (SCREEN.width - 100) / 2.0, y: 134, width: 100, height: 20)
        userBtn.titleLabel?.textAlignment = NSTextAlignment.center
        userBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        userBtn.setTitleColor(UIColor.white, for: UIControlState.normal)
        userBtn.setTitle("注册/登录", for: UIControlState.normal)
        self.addSubview(avatarIcon)
        self.addSubview(userBtn)
        
        let titleArr = ["我的挂号单", "我的处方单", "我的报告单"]
        for i in 0..<titleArr.count {
            let width = SCREEN.width / 3.0
            let bgView = UIView.init(frame: CGRect.init(x: width * CGFloat(i), y: 170, width: width, height: 75))
            bgView.backgroundColor = UIColor.white
            self.addSubview(bgView)
            
            let icon = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: 27, height: 27))
            icon.center = CGPoint.init(x: width / 2.0, y: 27)
            icon.image = UIImage.init(named: titleArr[i])
            bgView.addSubview(icon)
            
            let nameLB = UILabel.init(frame: CGRect.init(x: 0, y: maxY(view: icon) + 8, width: width, height: 15))
            nameLB.font = UIFont.systemFont(ofSize: 15)
            nameLB.textColor = UIColor.init(white: 0.2, alpha: 1)
            nameLB.textAlignment = NSTextAlignment.center
            nameLB.text = titleArr[i]
            bgView.addSubview(nameLB)
            
            if i > 0 {
                let line = UIView.init(frame: CGRect.init(x: width * CGFloat(i), y: 170 + 10, width: 0.5, height: 55))
                line.backgroundColor = UIColor.init(white: 0.867, alpha: 1)
                self.addSubview(line)
            }
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
