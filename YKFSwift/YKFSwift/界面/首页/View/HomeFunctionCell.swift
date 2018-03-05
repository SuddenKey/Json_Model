//
//  HomeFunctionCell.swift
//  YKFSwift
//
//  Created by 魏子建 on 2017/3/27.
//  Copyright © 2017年 魏子建. All rights reserved.
//

import UIKit

class HomeFunctionCell: YKFTableViewCell {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    private let horizontalLine = UIView.init(frame: CGRect.init(x: 0, y: 80, width: SCREEN.width, height: 0.5))
    private let verticallLine = UIView.init(frame: CGRect.init(x: SCREEN.width / 2, y: 0, width: 0.5, height: 160))
    let registered = FunctionView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN.width / 2, height: 80))
    let payCost = FunctionView.init(frame: CGRect.init(x: SCREEN.width / 2, y: 0, width: SCREEN.width / 2, height: 80))
    let waiting = FunctionView.init(frame: CGRect.init(x: 0, y: 80, width: SCREEN.width / 2, height: 80))
    let report = FunctionView.init(frame: CGRect.init(x: SCREEN.width / 2, y: 80, width: SCREEN.width / 2, height: 80))
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        registered.titleLB.text = "预约挂号"
        registered.contentLB.text = "普通、专家、名医"
        registered.icon.image = UIImage.init(named: "icon_index_register")
        self.addSubview(registered)
        
        payCost.titleLB.text = "我要缴费"
        payCost.contentLB.text = "医保自费,一键支付"
        payCost.icon.image = UIImage.init(named: "icon_index_pay")
        self.addSubview(payCost)
        
        waiting.titleLB.text = "候诊叫号"
        waiting.contentLB.text = "叫号查看,精准候诊"
        waiting.icon.image = UIImage.init(named: "icon_index_line")
        self.addSubview(waiting)
        
        report.titleLB.text = "取报告单"
        report.contentLB.text = "检查检验,报告查看"
        report.icon.image = UIImage.init(named: "icon_index_report")
        self.addSubview(report)
        
        horizontalLine.backgroundColor = HEXCOLOR(hexColor: "C7C9CB")
        verticallLine.backgroundColor = HEXCOLOR(hexColor: "C7C9CB")
        self.addSubview(horizontalLine)
        self.addSubview(verticallLine)
        
        self.selectionStyle = UITableViewCellSelectionStyle.none
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

class FunctionView: UIView {
    
    let titleLB = UILabel.init(frame: CGRect.init(x: 15, y: 18, width: 100, height: 17))
    let contentLB = UILabel.init(frame: CGRect.init(x: 15, y: 44, width: 100, height: 11))

    let icon = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.titleLB.font = UIFont.systemFont(ofSize: 17)
        self.titleLB.textColor = HEXCOLOR(hexColor: "333333")
        self.addSubview(self.titleLB)
        
        self.contentLB.font = UIFont.systemFont(ofSize: 11)
        self.contentLB.textColor = HEXCOLOR(hexColor: "999999")
        self.addSubview(self.contentLB)
        
        self.icon.frame = CGRect.init(x: self.frame.size.width - 50, y: 24, width: 38, height: 38)
        self.addSubview(self.icon)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
