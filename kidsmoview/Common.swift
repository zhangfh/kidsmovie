//
//  Common.swift
//  kidsmoview
//
//  Created by zhangfanghui on 16/4/8.
//  Copyright © 2016年 zhangfanghui. All rights reserved.
//

import UIKit

// 屏幕的bounds
let kScreenBounds = UIScreen.mainScreen().bounds

// 屏幕宽度
let kScreenW = kScreenBounds.size.width

// 屏幕高度
let kScreenH = kScreenBounds.size.height

// 通用storyboard
let mainStoryboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())

let UserStoryboard = UIStoryboard(name: "User", bundle: NSBundle.mainBundle())

// 沙盒文档路径
let kSandDocumentPath = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true).last!

// 保存用户信息的路径
let filePath = "\(kSandDocumentPath)/userAccount.data"
