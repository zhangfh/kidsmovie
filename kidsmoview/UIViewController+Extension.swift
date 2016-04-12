//
//  UIViewController+Extension.swift
//  kidsmoview
//
//  Created by zhangfanghui on 16/4/12.
//  Copyright © 2016年 zhangfanghui. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showAlert(title title: String, message: String, buttonText: String) {
        
        let controller : UIAlertController!
        
        if title == "" {
            //設定Alert View的title、message、style
            controller = UIAlertController(title: nil, message: message, preferredStyle: .Alert)
        }else{
            if message == ""{
                controller = UIAlertController(title: title, message: nil, preferredStyle: .Alert)
            }else{
                controller = UIAlertController(title: title, message: message, preferredStyle: .Alert)
            }
        }
        

        let action = UIAlertAction(title: buttonText, style: .Default, handler: nil)
        
        controller.addAction(action)
        
 
        self.presentViewController(controller, animated: true, completion: nil)
    }
    
}

