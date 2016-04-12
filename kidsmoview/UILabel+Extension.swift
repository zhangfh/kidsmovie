//
//  UILabel+Extension.swift
//  kidsmoview
//
//  Created by zhangfanghui on 16/4/12.
//  Copyright © 2016年 zhangfanghui. All rights reserved.
//
import UIKit

extension UILabel {
    
    /**
     便利构造方法
     
     - parameter textColor: 文本颜色
     - parameter fontSize:  文本大小
     
     - returns: 返回UILabel
     */
    convenience init(textColor: UIColor, fontSize: CGFloat) {
        self.init()
        self.textColor = textColor
        self.font = UIFont.systemFontOfSize(fontSize)
    }
}