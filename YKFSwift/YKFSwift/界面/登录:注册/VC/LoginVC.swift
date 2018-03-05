//
//  LoginVC.swift
//  YKFSwift
//
//  Created by 魏子建 on 2017/4/6.
//  Copyright © 2017年 魏子建. All rights reserved.
//

import UIKit
import RxCocoa


class LoginVC: YKFViewController {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var loginBtn: UIButton!
    
    let userNameIV = InputView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN.width, height: 55))
    let passwordIV = InputView.init(frame: CGRect.init(x: 0, y: 55, width: SCREEN.width, height: 55))
    let loginVM = LoginViewModel.init()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setUI()
        self.bindViewModel()
    }

    func setUI() -> Void {
        
        self.loginBtn.layer.cornerRadius = 5
        self.bgView.addSubview(self.userNameIV)
        self.bgView.addSubview(self.passwordIV)
        self.userNameIV.bottomLineX = 20
        self.userNameIV.inputTF.placeholder = "请输入手机号"
        self.userNameIV.imageName = "icon_phone"
        self.userNameIV.inputTF.keyboardType = UIKeyboardType.numberPad
        self.userNameIV.inputTF.becomeFirstResponder()
        self.passwordIV.inputTF.placeholder = "请输入密码"
        self.passwordIV.imageName = "icon_password"
        self.passwordIV.topLine.isHidden = true
        self.addBackBtn(isPresent: true)
        
        let loginIntro = LoginIntroModel()
        self.userNameIV.inputTF.text = loginIntro.userName
    }
    
    func bindViewModel() -> Void {
        self.userNameIV.inputTF.rx.text.orEmpty.bindTo(loginVM.userName).addDisposableTo(disposeBag)
        self.passwordIV.inputTF.rx.text.orEmpty.bindTo(loginVM.password).addDisposableTo(disposeBag)
 
        self.loginVM.loginResult.subscribe(onNext: { (result) in
            
            if result {
                UserViewModel.instance.refreshUserIntro.onNext("")
                self.dismiss(animated: true, completion: nil)
            }
        }, onError: nil, onCompleted: nil, onDisposed: nil).addDisposableTo(disposeBag)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func login(_ sender: Any) {
        loginVM.loginAction.onNext("")
    }
    
    @IBAction func forgetPassword(_ sender: Any) {
    }

    @IBAction func smsLogin(_ sender: Any) {
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

class InputView: UIView, UITextFieldDelegate {
    let icon = UIImageView.init(frame: CGRect.init(x: 35, y: 16.5, width: 15, height: 21))
    let inputTF = UITextField.init(frame: CGRect.init(x: 58, y: 16.5, width: SCREEN.width - 58 - 15, height: 21))
    let rightBtn = UIButton.init(type: UIButtonType.custom)
    let topLine = UIView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN.width, height: 0.5))
    let bottomLine = UIView.init(frame: CGRect.init(x: 0, y: 54.5, width: SCREEN.width , height: 0.5))
    var imageName = ""{
        didSet {
            icon.image = UIImage.init(named: imageName)
        }
    }
    
    
    var topLineX : CGFloat = 0.0 {
        didSet {
            topLine.frame = CGRect.init(x: topLineX, y: minY(view: topLine), width: sizeW(view: topLine), height: sizeH(view: topLine))
        }
    }
    
    var bottomLineX : CGFloat = 0.0 {
        didSet {
            bottomLine.frame = CGRect.init(x: bottomLineX, y: minY(view: bottomLine), width: sizeW(view: bottomLine), height: sizeH(view: bottomLine))
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(icon)
        self.addSubview(inputTF)
        self.addSubview(rightBtn)
        self.addSubview(topLine)
        self.addSubview(bottomLine)
        topLine.backgroundColor = HEXCOLOR(hexColor: "d1d3d5")
        bottomLine.backgroundColor = HEXCOLOR(hexColor: "d1d3d5")
        
        self.inputTF.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let name = "\(imageName)_on"
        icon.image = UIImage.init(named: name)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        icon.image = UIImage.init(named: imageName)
    }
    
}
