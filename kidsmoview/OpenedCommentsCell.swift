//
//  OpenedCommentsCell.swift
//  kidsmoview
//
//  Created by zhangfanghui on 16/4/11.
//  Copyright © 2016年 zhangfanghui. All rights reserved.
//

import UIKit

class OpenedCommentsCell: UITableViewCell {
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!

    @IBOutlet weak var commentTextView: UITextView!
    
    
    var comment: CommentModel? {
        didSet {
   
            dateLabel.text = comment?.dateCreated
            authorLabel.text = comment?.autherUsername
            
            if let textView = commentTextView {
                let commentFont = UIFont.systemFontOfSize(15) //UIFont(name: "HelveticaNeue-Light", size: 15)
                let commentTextColor = UIColor.darkGrayColor()
                let lineSpacing = 4 as CGFloat
                
                let relacingCommentText  = comment!.text.stringByReplacingOccurrencesOfString("\\n", withString: "\n")
                
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
    
    func configureCell(comment: CommentModel)
    {
        commentTextView.text = comment.text
        authorLabel.text = comment.autherUsername
    }
}
