//
//  CommentModel.swift
//  kidsmoview
//
//  Created by zhangfanghui on 16/4/11.
//  Copyright © 2016年 zhangfanghui. All rights reserved.
//

import Foundation
import ObjectMapper

enum CommentType {
    case Default
}

class CommentModel : Mappable
{
    var type : CommentType?
    
    var _type : String?
    {
        didSet{
            let type_int = Int(_type!)
            switch type_int!
            {
                case 1:
                    type = .Default
                default:
                    type = .Default
            }
        }
    }
    
    var comments_id : String!
    var kidsfilm_id : String!
    var autherUsername : String!
    var parentCommentID : String!
    var level :  String!
    
    var dateCreated : String!
    var text : String!
    
    required init?(_ map: Map) {
        
    }
    
    init(kidsfilm_id:String, autherUsername: String, text:String)
    {
        self.kidsfilm_id = kidsfilm_id
        self.autherUsername = autherUsername
        self.text = text
    }
    
    func mapping(map: Map) {
        
         _type <- map["type"]
        comments_id <- map["comments_id"]
        kidsfilm_id <- map["kidsfilm_id"]
        autherUsername <- map["autherUsername"]
        parentCommentID <- map["parentCommentID"]
        level <- map["level"]
        dateCreated <- map["dateCreated"]
        text <- map["text"]
    }
}