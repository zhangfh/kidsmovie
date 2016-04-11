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
                if post.fullImage != nil{
                    postImageView.image = post.fullImage
                }else{
                    if post.imageURL != nil {
                        imageDownloadTask = postImageView.loadImageWithMovieObject(post, imageSize: Film.ImageSize.w300)
                        print("ready download")
                    }
                }
            }
        }

    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    
        
    }
 
    func configure(){
      
        //postImageView.addObserver(self, forKeyPath: "image", options: [], context: nil)
    }
    deinit {
        //postImageView.removeObserver(self, forKeyPath: "image")
    }
    
    
    override func layoutSubviews() {

    }
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if keyPath == "image" {
            //self.setNeedsLayout()
        }
    }
    
}
