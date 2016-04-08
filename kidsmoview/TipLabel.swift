//
//  TipLabel.swift
//  kidsmoview
//
//  Created by zhangfanghui on 16/4/8.
//  Copyright © 2016年 zhangfanghui. All rights reserved.
//

import UIKit

class TipLabel: UILabel {
    
    let tipHeight = 44
    
    override init(frame: CGRect) {
        
        super.init(frame: CGRect(x: 0, y: -20 - tipHeight, width: Int(kScreenW), height: tipHeight))
        // 创建提示信息Label
        
        backgroundColor = UIColor.orangeColor()
        textColor       = UIColor.whiteColor()
        font            = UIFont.systemFontOfSize(14)
        textAlignment   = NSTextAlignment.Center
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

