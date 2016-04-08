//
//  Film.swift
//  kidsmoview
//
//  Created by zhangfanghui on 16/4/8.
//  Copyright © 2016年 zhangfanghui. All rights reserved.
//

import UIKit
import ObjectMapper

class Film : Mappable
{
    
    enum URLType {
        case posterW92
        case posterW300
        case movieDetails
        case movieCredits
    }
    
    enum ImageSize {
        case w92
        case w300
    }
    
    
    var film_id : String!
    
    var cn_name : String!
    var name : String!
    var language : String!
    var director : String!
    var type : String!
    var IMDB : String!
    var desc : String?
    
    var remark : String?
    var w92PosterAddress: String!
    var date : String!
    var longDesc : String!
    
    var w92Poster: UIImage?
    
    required init?(_ map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        film_id <- map["film_id"]
        
        name <- map["name"]
        cn_name <- map["cn_name"]
        language <- map["language"]
        director <- map["director"]
        
        type <- map["type"]
        IMDB <- map["IMDB"]
        desc <- map["desc"]
        
        remark <- map["remark"]
        w92PosterAddress <- map["w92PosterAddress"]
        date <- map["date"]
        longDesc <- map["longDesc"]
    }
    
    
    func getURLWithType(type: URLType) -> NSURL {
        var url = ""
        switch type {
        case .posterW92:
            url = String(format: "http://www.skillwhisper.com/film/p/%@", w92PosterAddress)
        case .posterW300:
            url = String(format: "http://www.skillwhisper.com/film/p/%@", w92PosterAddress)
        case .movieDetails:
            url = String(format: "http://www.skillwhisper.com/film/moviedetail/%@", film_id)
        case .movieCredits:
            url = String(format: "http://www.skillwhisper.com/film/moviecredits/%@", film_id)
        }
        return NSURL(string: url)!
    }
}