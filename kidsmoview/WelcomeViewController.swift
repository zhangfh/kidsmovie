//
//  WelcomeViewController.swift
//  kidsmoview
//
//  Created by zhangfanghui on 16/4/8.
//  Copyright © 2016年 zhangfanghui. All rights reserved.
//

import UIKit
import SnapKit



class WelcomeViewController: UIViewController {
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        // 更新约束
       // userIcon.snp_updateConstraints { (make) -> Void in
         //   make.bottom.equalTo(-(kScreenH - 160))
            
            /* image constraint
             ------------------
             |                  |
             |                  |
             |      -------     |
             |     |       |    |
             |     |       |    |
             |     |       |    |
             |     ---------    |
             |                  |
             |                  |
             |                  |
             |                  |
             |                  |
             |                  |
             |                  |
             |                  |
             |                  |
             --------------------
             */
       // }
        
        // 动画移动头像
        UIView.animateWithDuration(1.0, delay: 0.1, usingSpringWithDamping: 0.6, initialSpringVelocity: 5, options: UIViewAnimationOptions(rawValue: 0), animations: { () -> Void in
            // 更新布局
            self.view.layoutIfNeeded()
        }) { (_) -> Void in
            // 动画渐变显示文字
            UIView.animateWithDuration(1.0, animations: { () -> Void in
                //print("usericon new \(self.userIcon.frame)")
                //self.userName.alpha = 1
                }, completion: { (_) -> Void in
                    // 进入主页
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (Int64)(1 * NSEC_PER_SEC)), dispatch_get_main_queue()) { () -> Void in
                        //ViewController is created in Storyboard, so below code will cause black screen.
                        let vc = mainStoryboard.instantiateViewControllerWithIdentifier(KidsTabBarController.identifier) as! KidsTabBarController
                        
                        UIApplication.sharedApplication().keyWindow?.rootViewController = vc
                        
                        
                    }
            })
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 背景颜色
        view.backgroundColor = UIColor(patternImage: UIImage(named: "welcome")!)
        // 添加控件
        //view.addSubview(userIcon)
        //view.addSubview(userName)
        
        // 约束头像
        //userIcon.snp_makeConstraints { (make) -> Void in
          //  make.size.equalTo(CGSize(width:100, height: 100))
          //  make.centerX.equalTo(view.snp_centerX)
          //  make.bottom.equalTo(-160)
            
            /* image constraint
             ------------------
             |                  |
             |                  |
             |                  |
             |                  |
             |                  |
             |                  |
             |                  |
             |      -------     |
             |     |       |    |
             |     |       |    |
             |     |       |    |
             |     ---------    |
             |                  |
             |                  |
             |                  |
             |                  |
             --------------------
             */
       // }
        
        // 约束用户名称
        //userName.snp_makeConstraints { (make) -> Void in
          //  make.centerX.equalTo(userIcon.snp_centerX)
          //  make.top.equalTo(userIcon.snp_bottom).offset(10)
        //}
        //print("userIcon bounds \(userIcon.frame)")
        // print("userName bounds \(userName.frame)")
        
    }
    
    /// MARK: - 懒加载
    /// 用户头像
    lazy var userIcon: UIImageView = {
        let iconView = UIImageView()
        // 加载用户头像
        //iconView.image = UIImage(named: "usericon")
        iconView.jf_setImageWithURL(NSURL(string: "http://ultrasound.lonshinetech.cn/mu1/uploads/demo.jpg"))
        iconView.layer.cornerRadius = 50
        iconView.clipsToBounds = true
        return iconView
    }()
    
    /// 用户名称
    lazy var userName: UILabel = {
        let name = UILabel()
        name.alpha = 0
        name.text = "欢迎归来"
        return name
    }()
}
