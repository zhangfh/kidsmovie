//
//  DescriptionCell.swift
//  kidsmoview
//
//  Created by zhangfanghui on 16/4/11.
//  Copyright © 2016年 zhangfanghui. All rights reserved.
//

import UIKit

class DescriptionCell : UITableViewCell
{
    @IBOutlet  weak var descriptionTextView : UITextView!
    
    func configure(text: String)
    {
        
        if let textView = descriptionTextView {
            let commentFont = UIFont.systemFontOfSize(15) //UIFont(name: "HelveticaNeue-Light", size: 15)
            let commentTextColor = UIColor.darkGrayColor()
            let lineSpacing = 4 as CGFloat
            
            let relacingCommentText  = text.stringByReplacingOccurrencesOfString("\\n", withString: "\n")
            
            let commentAttributedString = NSMutableAttributedString(string: relacingCommentText)
            let paragraphStyle = NSMutableParagraphStyle.defaultParagraphStyle().mutableCopy() as! NSMutableParagraphStyle
            paragraphStyle.lineSpacing = lineSpacing
            
            let commentRange = NSMakeRange(0, commentAttributedString.length)
            
            commentAttributedString.addAttribute(NSFontAttributeName, value: commentFont, range: commentRange)
            commentAttributedString.addAttribute(NSForegroundColorAttributeName, value: commentTextColor, range: commentRange)
            commentAttributedString.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: commentRange)
            
            textView.attributedText = commentAttributedString.copy() as! NSAttributedString
        }
    }
}
