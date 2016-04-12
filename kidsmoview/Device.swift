//
//  Device.swift
//  kidsmoview
//
//  Created by zhangfanghui on 16/4/12.
//  Copyright © 2016年 zhangfanghui. All rights reserved.
//


import UIKit
struct Device {
    
    // MARK: - Singletons
    
    static var TheCurrentDevice: UIDevice {
        struct Singleton {
            static let device = UIDevice.currentDevice()
        }
        return Singleton.device
    }
    
    static var TheCurrentDeviceVersion: Float {
        struct Singleton {
            static let version = (UIDevice.currentDevice().systemVersion as NSString).floatValue
        }
        return Singleton.version
    }
    
    static var CURRENT_VERSION: String {
        return "\(TheCurrentDeviceVersion)"
    }
}