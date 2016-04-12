//
//  NewCommentViewController.swift
//  kidsmoview
//
//  Created by zhangfanghui on 16/4/12.
//  Copyright © 2016年 zhangfanghui. All rights reserved.
//

import UIKit

class NewCommentViewController : UIViewController
{
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 背景颜色
        view.backgroundColor = UIColor.whiteColor()
        // 准备UI
        prepareUI()
        // 添加键盘frame改变的通知
        addkeyboardObserver()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        // 主动弹出键盘
        textView.becomeFirstResponder()
        // 保证是系统键盘
        textView.inputView = nil
        
    }
    
    func addkeyboardObserver() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(NewCommentViewController.keyboardWillChangeFrame(_:)), name: UIKeyboardWillChangeFrameNotification, object: nil)
    }
    
    // MARK: - 键盘frame改变方法
    /// 键盘frame改变方法
    func keyboardWillChangeFrame(notifiction: NSNotification) {
        // 获取键盘最终的frame
        let endFrame = notifiction.userInfo![UIKeyboardFrameEndUserInfoKey]!.CGRectValue
        
        // toolBar底部到父控件的底部的距离 = 屏幕高度 - 键盘.frame.origin.y
        let bottomOffset = kScreenH - endFrame.origin.y
        
        // 更新约束
        toolBar.snp_updateConstraints { (make) -> Void in
            make.bottom.equalTo(-bottomOffset)
        }
 
        
        // 获取动画时间
        let duration = notifiction.userInfo![UIKeyboardAnimationDurationUserInfoKey]!.doubleValue
        
        // toolBar动画
        UIView.animateWithDuration(duration) { () -> Void in
            self.view.layoutIfNeeded()
        }
    }
    
    /**
     移除键盘监听
     */
    func removeKeyboardObserver() {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }

    deinit {
        // 注销通知
        removeKeyboardObserver()
    }
    // MARK: - 懒加载
    /// 工具条
    private lazy var toolBar: UIToolbar = {
        let toolBar = UIToolbar()
        // 设置背景颜色
        toolBar.backgroundColor = UIColor(white: 0.8, alpha: 1)
        return toolBar
    }()
    
    /// 文本框
    private lazy var textView: PlaceholderTextView = {
        
        let textView = PlaceholderTextView()
        
        // 设置字体大小
        textView.font = UIFont.systemFontOfSize(17)
        
        // 设置 textView 有回弹效果
        textView.alwaysBounceVertical = true
        
        // 拖动textView关闭键盘
        textView.keyboardDismissMode = UIScrollViewKeyboardDismissMode.OnDrag
        
        // 添加代理，监听文字改变来设置导航栏右边按钮
        textView.delegate = self
        
        // 自定义占位符
        textView.placeholder = "add comments..."
        
        return textView
    }()
    
    /// comments文本长度标签
    private lazy var lengthTipLabel = UILabel(textColor: UIColor.lightGrayColor(), fontSize: 12)
    
    /// comment文本最大长度
    private let statusMaxLength = 120
    
    func prepareUI() {
        
        // 添加子控件
        view.addSubview(textView)
        view.addSubview(toolBar)
        view.addSubview(lengthTipLabel)
        
        // 设置导航
        setupNavigationBar()
        
        // 文本框
        textView.snp_makeConstraints { (make) -> Void in
            make.left.top.right.equalTo(0)
            make.bottom.equalTo(toolBar.snp_top)
        }
        
        // 工具条
        
        toolBar.snp_makeConstraints { (make) -> Void in
            make.left.bottom.right.equalTo(0)
            make.height.equalTo(44)
        }
        // 设置工具条
        setupToolBar()
        
        // 长度提示文本
        lengthTipLabel.snp_makeConstraints { (make) -> Void in
            make.right.equalTo(-12)
            make.bottom.equalTo(toolBar.snp_top).offset(-8)
        }
        // 设置文字
        lengthTipLabel.text = "\(statusMaxLength)"
        
    }
    
    /**
     设置工具条
     */
    private func setupToolBar() {
        
        // 创建toolBar上的item数组
        var items = [UIBarButtonItem]()
        
        // 每个item对应的图片名称和监听方法名称
        let itemSettings = [["imageName": "compose_toolbar_picture", "action" : "picture"],
                            ["imageName": "compose_mentionbutton_background", "action" : "mention"],
                            ["imageName": "compose_trendbutton_background", "action" : "trend"],
                            ["imageName": "compose_emoticonbutton_background", "action" : "emotion"],
                            ["imageName": "message_add_background", "action" : "add"]]
        
        // 遍历 itemSettings 创建 UIBarbuttonItem
        for dict in itemSettings {
            
            // 获取图片名称
            let name = dict["imageName"]!
            let nameHighlighted = name + "_highlighted"
            
            // 获取方法名
            let action = dict["action"]!
            
            // 创建item按钮
            let button = UIButton()
            
            // 创建item
            let item = UIBarButtonItem(button: button, imageName: name, highlightedImageName: nameHighlighted)
            
            // 添加点击事件
            button.addTarget(self, action: Selector(action), forControlEvents: UIControlEvents.TouchUpInside)
            
            // 将创建好的item添加到items数组
            items.append(item)
            
            // 添加弹簧（第一个左边和最后一个右边没有弹簧，所以第一个弹簧要在第一个item添加后再添加）
            items.append(UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil))
        }
        
        // 删除最后一根弹簧，移除数组中最后一个元素
        items.removeLast()
        
        // 设置工具条上的按钮
        toolBar.items = items
    }
    /**
     设置导航条
     */
    private func setupNavigationBar() {
        
        // 取消
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(NewCommentViewController.didTappedCancelButton))
        
        // 发送
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Send", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(NewCommentViewController.didTappedSendButton))
        
        // 标题
        setupTitle()
    }
    
    func didTappedCancelButton() {

        // 退出键盘
        textView.resignFirstResponder()

        self.navigationController?.popViewControllerAnimated(true)

    }
    
    func didTappedSendButton() {
        print("text \(textView.text)")
        print("base64 \(textView.text.toBase64())")
        self.didTappedCancelButton()
    }
    
    /**
     @
     */
     func mention() {
        print("@")
    }
    
    func picture() {
        print("图片")
        

        
        // 隐藏键盘
        textView.resignFirstResponder()
        
        UIView.animateWithDuration(0.25) { () -> Void in
            self.view.layoutIfNeeded()
        }
    }
    
    /**
     #
     */
    func trend() {
        print("#")
    }
    
    func emotion() {
        print("表情")
        
        removeKeyboardObserver()
        
        // 先将键盘退下
        textView.resignFirstResponder()
        
        // 切换键盘
        //textView.inputView = textView.inputView == nil ? emotiocnViewController.view : nil
        
        addkeyboardObserver()
        
        // 再呼出键盘
        textView.becomeFirstResponder()
    }

    func add() {
        print("加号")
    }
    

    
    
    /**
     设置导航标题
     */
    private func setupTitle() {
        
        // 标题
        let prefixString = "add Comment"
        

            
            // 创建标题标签
            let titleLabel = UILabel()
            titleLabel.numberOfLines = 0
            titleLabel.textAlignment = NSTextAlignment.Center
            
            // 拼接完整标题字符串
            let titleString = prefixString + "\n" + "maxburns"
            
            // 创建属性字符串
            let attributeText = NSMutableAttributedString(string: titleString)
            
            // 设置前缀属性
            let prefixRange = (titleString as NSString).rangeOfString(prefixString)
            attributeText.addAttribute(NSFontAttributeName, value: UIFont.systemFontOfSize(14), range: prefixRange)
            
            // 昵称属性
            let nameRange = (titleString as NSString).rangeOfString("maxburns")
            attributeText.addAttributes([NSFontAttributeName : UIFont.systemFontOfSize(12), NSForegroundColorAttributeName : UIColor.grayColor()], range: nameRange)
            
            // 设置Label的attributedText值
            titleLabel.attributedText = attributeText
            
            // 自适应
            titleLabel.sizeToFit()
            
            // 设置自定义的标题视图
            navigationItem.titleView = titleLabel

        
    }
    
}

// MARK: - 扩展 NewCommentViewController 实现 UITextViewDelegate代理
extension NewCommentViewController: UITextViewDelegate {
    
    // 文字改变代理方法
    func textViewDidChange(textView: UITextView) {
        // 设置发布按钮的禁用状态
        navigationItem.rightBarButtonItem?.enabled = textView.hasText()
        
        // 计算剩余文本的长度
        let text = textView.text
        
        let length = statusMaxLength - text.characters.count
        
        // 设置文本内容
        lengthTipLabel.text = "\(length)"
        
        // 设置文本颜色, length < 0 红色
        lengthTipLabel.textColor = length < 0 ? UIColor.redColor() : UIColor.lightGrayColor()
    }
}
