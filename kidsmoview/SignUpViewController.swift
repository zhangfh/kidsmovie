//
//  SignUpViewController.swift
//  kidsmoview
//
//  Created by zhangfanghui on 16/4/12.
//  Copyright © 2016年 zhangfanghui. All rights reserved.
//

import UIKit

class SignUpViewController : UIViewController
{
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordTextField.secureTextEntry = true
        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let _ = touches.first{
            self.view.endEditing(true)
        }
        super.touchesBegan(touches , withEvent:event)
    }
    
    @IBAction func closeButtonClicked(sender: AnyObject) {
        
        dismissViewControllerAnimated(true,completion: nil)
        
    }
    
    @IBAction func signupButtonClicked(sender: AnyObject) {
        var username = self.userNameTextField.text
        var password = self.passwordTextField.text
        
        //清除所有空格
        username = username!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        password = password!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        
        
        if let username = username where username.characters.count < 5 {
            showAlert(title: "无效", message: "用户名大于5", buttonText: "OK")
            
        } else if let password = password where password.characters.count < 8 {
            showAlert(title: "无效", message: "密码大于8个字符", buttonText: "OK")
            
        } else {
            
            //startProgress(self.view, text: "注册中,请稍后...")
            UserManager.registerUser(username!, password: password!, success: {
                _ in
                print("register success")
                dispatch_async(dispatch_get_main_queue()){
                    
                    //stopProgress(self.view)
                    //self.jumpToHome()
                    //startProgress(self.view, text: "登录中,请稍后...")
                    self.login(username!, password: password!)
                }
                
                }, failure: {
                    
                    errorreason in
                    print("register error: \(errorreason)")
                    dispatch_async(dispatch_get_main_queue()){
                        //stopProgress(self.view)
                        self.RegisterFail(errorreason)
                    }
            })
        }
        
    }
    
    func login(username: String, password: String)
    {
        UserManager.loginUser(username, password: password, success: {
            jsonObject in
            print("login success")
            dispatch_async(dispatch_get_main_queue()){
                //stopProgress(self.view)
                print("request_id is  \(jsonObject["request_id"])")
                self.jumpToHome(username, request_id: jsonObject["request_id"].string!)
            }
            
            }, failure: {
                
                errorreason in
                print("login error: \(errorreason)")
                dispatch_async(dispatch_get_main_queue()){
                    //stopProgress(self.view)
                    self.LoginFail(errorreason)
                }
        })
    }
    
    func jumpToHome(username: String, request_id: String)
    {
        dismissViewControllerAnimated(true, completion: nil)
        //self.delegate?.UserRegisterAndLoginSuccess( username, request_id: request_id)
        
    }
    
    func clearUI()
    {
        userNameTextField.text = ""
        passwordTextField.text = ""
        
        userNameTextField.becomeFirstResponder()
        
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
    
    func LoginFail(message: String)
    {
        let alertController : UIAlertController!
        
        alertController = UIAlertController(title: "登录失败", message: message , preferredStyle: .Alert)
        
        alertController.addAction(UIAlertAction(title: "确定", style: .Default, handler: {
            (paramAction:UIAlertAction!) in
            self.dismissViewControllerAnimated(true, completion: nil)
        }))
        
        self.presentViewController(alertController, animated: true, completion: nil)
        
    }
    
}
