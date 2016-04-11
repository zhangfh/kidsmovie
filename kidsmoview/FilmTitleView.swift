//
//  FilmTitleView.swift
//  kidsmoview
//
//  Created by zhangfanghui on 16/4/11.
//  Copyright © 2016年 zhangfanghui. All rights reserved.
//

import UIKit

class FilmTitleView: UIView {

    @IBOutlet  weak var postImageView : UIImageView!
    
    var imageDownloadTask: NSURLSessionDownloadTask?
    
    var post: Film? {
        didSet {
            if let post = post {
                if post.imageURL != nil {
                    //imageDownloadTask = postImageView.loadImageWithMovieObject(film, imageSize: Film.ImageSize.w300)
                    print("ready download")
                }
            }
        }

    }

    
    override func layoutSubviews() {

    }
}
