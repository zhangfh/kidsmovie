//
//  UIImageView+downloadimage.swift
//  kidsmoview
//
//  Created by zhangfanghui on 16/4/8.
//  Copyright © 2016年 zhangfanghui. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func loadImageWithMovieObject(movie: Film, imageSize: Film.ImageSize) -> NSURLSessionDownloadTask {
        var url = NSURL()
        switch imageSize {
        case .w92:
            url = movie.getURLWithType(Film.URLType.posterW92)
        case .w300:
            url = movie.getURLWithType(Film.URLType.posterW300)
        }
        
        let session = NSURLSession.sharedSession()
        let downloadTask = session.downloadTaskWithURL( url, completionHandler: { [weak self] url, response, error in
            if error == nil && url != nil {
                if let data = NSData(contentsOfURL: url!) {
                    if let image = UIImage(data: data) {
                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                            // check whether the UIImageView is still existing
                            if let strongSelf = self {
                                strongSelf.image = image
                                switch imageSize {
                                case .w92:
                                    movie.w92Poster = image
                                case .w300:
                                    break
                                }
                            }
                        })
                    }
                }
            }
            })
        downloadTask.resume()
        return downloadTask
    }
}