//
//  UserFuncCell.swift
//  YKFSwift
//
//  Created by 魏子建 on 2017/4/5.
//  Copyright © 2017年 魏子建. All rights reserved.
//

import UIKit

class UserFuncCell: YKFTableViewCell {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    @IBOutlet weak var icon: UIImageView!
    
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var content: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.bottomLineY = 45
    }
}
