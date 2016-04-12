//
//  LoginViewController.swift
//  kidsmoview
//
//  Created by 张方辉 on 16/4/12.
//  Copyright © 2016年 zhangfanghui. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        
        passwordTextField.secureTextEntry = true
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let _ = touches.first{
            self.view.endEditing(true)
        }
        super.touchesBegan(touches , withEvent:event)
    }
    
    
    
    @IBAction func closeButtonClicked(sender: AnyObject) {
        
        dismissViewControllerAnimated(true, completion: nil)
     
        
    }
    @IBAction func loginButtonClicked(sender: AnyObject) {
        
        var username = self.usernameTextField.text
        var password = self.passwordTextField.text
        
        //清除所有空格
        username = username!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        password = password!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        
        
        if let username = username where username.characters.count < 5 {
            showAlert(title: "无效", message: "用户名大于5", buttonText: "OK")
            
        } else if let password = password where password.characters.count < 8 {
            showAlert(title: "无效", message: "密码大于8个字符", buttonText: "OK")
            
        } else {
            //startProgress(self.view, text: "登录中,请稍后...")
            UserManager.loginUser(username!, password: password!, success: {
                jsonObject in
                print("login success")
                dispatch_async(dispatch_get_main_queue()){
                    
                    //stopProgress(self.view)
                    print("request_id is  \(jsonObject["request_id"])")
                    self.jumpToHome( username!, request_id: jsonObject["request_id"].string!)
                }
                
                }, failure: {
                    
                    errorreason in
                    print("login error: \(errorreason)")
                    dispatch_async(dispatch_get_main_queue()){
                        //stopProgress(self.view)
                        self.RegisterFail(errorreason)
                    }
            })
        }
    }
    
    func clearUI()
    {
        usernameTextField.text = ""
        passwordTextField.text = ""
        
        usernameTextField.becomeFirstResponder()
        
    }
    
    func RegisterFail(message: String)
    {
        let alertController : UIAlertController!
        
        alertController = UIAlertController(title: "失败", message: message , preferredStyle: .Alert)
        
        alertController.addAction(UIAlertAction(title: "确定", style: .Default, handler: {
            (paramAction:UIAlertAction!) in
            self.clearUI()
        }))
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func jumpToHome(username: String, request_id: String)
    {
        dismissViewControllerAnimated(true, completion: nil)
        //self.delegate?.UserLoginSuccess( username, request_id: request_id)
        
        
    }
    
}
