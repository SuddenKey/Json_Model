//
//  YKFTableViewCell.swift
//  YKFSwift
//
//  Created by 魏子建 on 2017/3/22.
//  Copyright © 2017年 魏子建. All rights reserved.
//

import UIKit

class YKFTableViewCell: UITableViewCell {
    
    var topline: UIView = UIView()
    
    var bottomLine: UIView = UIView()

    let leftLB = UILabel()
    let centerLB = UILabel()
    
    
    
    var bottomLineLeading: CGFloat = 0.0{
        didSet{
            bottomLine.frame = CGRect.init(x: bottomLineLeading, y: minY(view: bottomLine), width: SCREEN.width, height: 0.5)
        }
    }
    
    var bottomLineY : CGFloat = 0.0{
        didSet {
            bottomLine.frame = CGRect.init(x: minX(view: bottomLine), y: bottomLineY - 0.5, width: SCREEN.width, height: 0.5)
        }
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        self.setUI()
        
    }

//    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        self.setUI()
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUI() -> Void {
        topline.frame = CGRect.init(x: 0, y: 0, width: SCREEN.width, height: 0.5)
        topline.backgroundColor = RGBCOLOR(r: 0.820, g: 0.827, b: 0.835)
        topline.isHidden = true
        self.contentView.addSubview(topline)
        
        bottomLine.frame = CGRect.init(x: 0, y: sizeH(view: self) - 0.5, width: SCREEN.width, height: 0.5)
        bottomLine.backgroundColor = RGBCOLOR(r: 0.820, g: 0.827, b: 0.835)
        self.contentView.addSubview(bottomLine)
        
        leftLB.frame = CGRect.init(x: 20, y: (sizeH(view: self) - 20) / 2, width: 102, height: 20)
        leftLB.font = UIFont.systemFont(ofSize: 16)
        leftLB.textColor = HEXCOLOR(hexColor: "262626")
        centerLB.frame = CGRect.init(x: 122, y: (sizeH(view: self) - 20) / 2, width: 130, height: 20)
        centerLB.font = UIFont.systemFont(ofSize: 16)
        centerLB.textColor = HEXCOLOR(hexColor: "262626")
        self.contentView.addSubview(leftLB)
        self.contentView.addSubview(centerLB)
    }

}
