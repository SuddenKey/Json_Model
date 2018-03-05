//
//  HomeHospCell.swift
//  YKFSwift
//
//  Created by 魏子建 on 2017/3/28.
//  Copyright © 2017年 魏子建. All rights reserved.
//

import UIKit

class HomeHospCell: YKFTableViewCell {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    let scrollView = UIScrollView.init(frame: CGRect.init(x: 7.5, y: 0, width: SCREEN.width - 15, height: 157))
    
    var dataArray : Array<Any> {
        didSet {
           scrollView.contentSize = CGSize.init(width: 120 * dataArray.count, height: 157)
            for i in 0 ..< dataArray.count {
                let hospView = HomeHospView.init(frame: CGRect.init(x: CGFloat(120 * i), y: 0, width: 120, height: 157))
                hospView.hospModel = dataArray[i] as! HomeHospModel
                scrollView.addSubview(hospView)
            }
        }
    }
    
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        dataArray = []
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        self.contentView.addSubview(scrollView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class HomeHospView: UIView {
    let hospIcon = UIImageView.init(frame: CGRect.init(x: 7.5, y: 15, width: 105, height: 95))
    let hospNameLB = UILabel.init(frame: CGRect.init(x: 7.5, y: 120, width: 105, height: 30))
    let bgIcon = UIImageView.init(frame: CGRect.init(x: 5, y: 0, width: 20, height: 33))
    let levelLB = UILabel.init(frame: CGRect.init(x: 1, y: 2, width: 18, height: 20))
    
    var hospModel : HomeHospModel {
        didSet {
            hospIcon.sd_setImage(with: URL.init(string: hospModel.hospPicUrl))
            levelLB.text = hospModel.level
            hospNameLB.text = hospModel.hospSName
            if (hospModel.level.contains("甲等")) {
                bgIcon.image = UIImage.init(named: "bg_hospital_level_blue")
            } else if (hospModel.level.contains("乙等")) {
                bgIcon.image = UIImage.init(named:"bg_hospital_level_green")
            }
        }
    }
    
    
    override init(frame: CGRect) {
        hospModel = HomeHospModel()
        super.init(frame: frame)
        
        hospIcon.isUserInteractionEnabled = true
        self.addSubview(hospIcon)
        
        hospNameLB.textColor = RGBCOLOR(r: 0.2, g: 0.2, b: 0.2)
        hospNameLB.font = UIFont.systemFont(ofSize: 12)
        hospNameLB.numberOfLines = 0
        self.addSubview(hospNameLB)
        
        hospIcon.addSubview(bgIcon)
        
        levelLB.textColor = UIColor.white
        levelLB.font = UIFont.systemFont(ofSize: 8)
        levelLB.numberOfLines = 0
        levelLB.textAlignment = NSTextAlignment.center
        bgIcon.addSubview(levelLB)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
}
