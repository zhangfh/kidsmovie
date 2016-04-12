//
//  UserManager.swift
//  kidsmoview
//
//  Created by zhangfanghui on 16/4/12.
//  Copyright © 2016年 zhangfanghui. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class UserManager: NSObject {
    class var sharedInstance : UserManager {
        struct Static {
            static let instance : UserManager = UserManager()
        }
        return Static.instance
    }
    
    private override init() {
        super.init()
    }
}

extension UserManager {
    /**
     register user
     
     - parameter image:   UIImage
     - parameter success: 成功回调图片 model
     - parameter failure: 失败
     */
    class func registerUser(
        username:String,
        password:String,
        success:(Void) ->Void,
        failure:(errorreason : String) ->Void)
    {
        let parameters = [ "username" : username, "password" : password, "device" : Device.CURRENT_VERSION]
        
        let url = NSURL(string: "http://www.skillwhisper.com/film/api/user/register/format/json/")
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            
            Alamofire.request(.POST, url! , parameters: parameters)
                .response{
                    request, response, data, error in
                    print("\(request)")
                    print("response: \(response)")
                    print("data \(data)")
                    print("error \(error)")
                    if error != nil
                    {
                        
                        failure(errorreason: error.debugDescription)
                    }
                    else
                    {
                        let jsonObject = JSON(data: data!)
                        if jsonObject != JSON.null {
                            
                            /*
                             {
                             "reason" : {
                             "errno" : 31046,
                             "description" : "user already exist"
                             },
                             "success" : {
                             "errno" : -1,
                             "description" : "error"
                             }
                             }
                             */
                            
                            let errnomuber = jsonObject["reason"]["errno"].int
                            if errnomuber == 0
                            {
                                success()
                            }
                            else
                            {
                                failure(errorreason: jsonObject["reason"]["description"].string!)
                            }
                            
                            
                            
                        }
                        
                        
                    }
                    
                    
            }
        }
        /*
         .responseJSON(){
         response in
         print(response.request)
         print(response.response)
         print(response.data)
         print(response.result)
         
         
         if let JSON1 = response.result.value
         {
         print("json \(JSON1)")
         success()
         }
         
         
         }
         */
        
        
    }
    
    /**
     user Login
     
     
     - parameter success: 成功
     - parameter failure: 失败
     */
    class func loginUser(
        username:String,
        password:String,
        success:(jsonobject : JSON) ->Void,
        failure:(errorreason : String) ->Void)
    {
        let parameters = [ "username" : username, "password" : password]
        
        let url = NSURL(string: "http://www.skillwhisper.com/film/api/user/login/format/json/")
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            
            Alamofire.request(.POST, url! , parameters: parameters)
                .response{
                    request, response, data, error in
                    print("\(request)")
                    print("response: \(response)")
                    print("data \(data)")
                    print("error \(error)")
                    if error != nil
                    {
                        
                        failure(errorreason: error.debugDescription)
                    }
                    else
                    {
                        let jsonObject = JSON(data: data!)
                        if jsonObject != JSON.null {
                            
                            let errnomuber = jsonObject["reason"]["errno"].int
                            if errnomuber == 0
                            {
                                success(jsonobject: jsonObject)
                            }
                            else
                            {
                                failure(errorreason: jsonObject["reason"]["description"].string!)
                            }
                            
                        }
                        
                    }
                    
                    
            }
        }
        
        
        
    }
}
