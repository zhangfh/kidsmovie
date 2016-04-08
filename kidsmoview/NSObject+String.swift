//
//  NSObject+String.swift
//  kidsmoview
//
//  Created by zhangfanghui on 16/4/8.
//  Copyright © 2016年 zhangfanghui. All rights reserved.
//

import Foundation

extension NSObject {
    
    class var nameOfClass: String {
        //MyProject.ViewController
        return NSStringFromClass(self).componentsSeparatedByString(".").last! as String
    }
    
    //用于获取 cell 的 reuse identifier
    class var identifier: String {
        return String(format: "%@_identifier", self.nameOfClass)
    }
    
}