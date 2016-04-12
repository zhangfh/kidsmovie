//
//  UserAccount.swift
//  kidsmoview
//
//  Created by zhangfanghui on 16/4/12.
//  Copyright © 2016年 zhangfanghui. All rights reserved.
//

import UIKit

class UserAccount: NSObject , NSCoding{

    /// 用户名称
    var username: String?
    var password: String?
    var request_id: String?
    
    
    /// 用户账号单例对象
    static let shareUserAccount: UserAccount = {
        // 从沙盒加载用户账号信息
        var userAccount = UserAccount()
        if let account = NSKeyedUnarchiver.unarchiveObjectWithFile(filePath) {
            userAccount = account as! UserAccount
           
        }
        return userAccount
    }()
    
    // 是否登录成功
    var isLogin: Bool {
        get {
            // 判断是否授权成功
            if request_id != nil {
                return true
            } else {
                return false
            }
        }
    }
    
    
    // 防止外界初始化
    private override init() {}
    
    // MARK: - 保存用户信息到沙盒
    /**
     保存用户信息到沙盒
     - parameter userAccount: 存储用户信息的字典
     */
    func saveUserAccount(userAccount: [String : AnyObject]) {
        
        // kvc 为单例对象赋值
        UserAccount.shareUserAccount.setValuesForKeysWithDictionary(userAccount)
        
        // 保存信息到指定文件
        NSKeyedArchiver.archiveRootObject(self, toFile: filePath)
    }
    
    /**
     *  归档、解档
     */
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(username, forKey: "username")
        aCoder.encodeObject(password, forKey: "password")
        aCoder.encodeObject(request_id, forKey: "request_id")
        
    }
    
    required  init?(coder aDecoder: NSCoder) {
        username = aDecoder.decodeObjectForKey("username") as? String
        password = aDecoder.decodeObjectForKey("password") as? String
        request_id = aDecoder.decodeObjectForKey("request_id") as? String
        
    }
}

