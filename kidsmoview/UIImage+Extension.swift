//
//  UIImage+Extension.swift
//  kidsmoview
//
//  Created by zhangfanghui on 16/4/8.
//  Copyright © 2016年 zhangfanghui. All rights reserved.
//

import UIKit
import SDWebImage

// MARK: - 隔离SDWebImage
extension UIImageView {
    
    /**
     URL加载图片
     
     - parameter url: 图片URL
     */
    public func jf_setImageWithURL(url: NSURL!) {
        //sd_setImageWithURL(url)
        //不能忽略缓存
        sd_setImageWithURL(url, placeholderImage: UIImage(named: "usericon"), options: SDWebImageOptions.RefreshCached)
    }
    
    /**
     带占位图的URL加载图片
     
     - parameter url:         图片URL
     - parameter placeholder: 占位图
     */
    public func jf_setImageWithURL(url: NSURL!, placeholderImage placeholder: UIImage!) {
        sd_setImageWithURL(url, placeholderImage: placeholder)
    }
}

