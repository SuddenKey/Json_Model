//
//  HomeConsultingCell.swift
//  YKFSwift
//
//  Created by 魏子建 on 2017/3/28.
//  Copyright © 2017年 魏子建. All rights reserved.
//

import UIKit
import SDWebImage

class HomeConsultingCell: YKFTableViewCell {

    @IBOutlet weak var hospIcon: UIImageView!
    
    @IBOutlet weak var titleLB: UILabel!
    
    @IBOutlet weak var timeLB: UILabel!
    
    @IBOutlet weak var tagLB: UILabel!
    
    var newsModel = NewsList()
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override func awakeFromNib() {
        self.selectionStyle = UITableViewCellSelectionStyle.none
        tagLB.layer.cornerRadius = 2
        tagLB.layer.borderWidth = 0.5
    }
    func model(model : NewsList) -> Void {
        if model != newsModel {
            hospIcon.sd_setImage(with: URL.init(string: model.newsPicUrl))
            titleLB.text = model.title
            timeLB.text = model.time
            tagLB.text = model.tagName
            tagLB.textColor = HEXCOLOR(hexColor: model.tagColor)
            tagLB.layer.borderColor = HEXCOLOR(hexColor: model.tagColor).cgColor
        }
    }

}
