//
//  DetailFilmViewController.swift
//  kidsmoview
//
//  Created by zhangfanghui on 16/4/11.
//  Copyright © 2016年 zhangfanghui. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import ObjectMapper

class DetailFilmViewController: UIViewController {


    @IBOutlet weak var tableView: UITableView!
    var currentfilm : Film!
    
     var filteredObjects  = [CommentModel]()
    
    override func viewDidLoad() {
        
        title = currentfilm.cn_name
        
        setupFilmTitleView()
        
        tableView.estimatedRowHeight = 44.0
        tableView.rowHeight = UITableViewAutomaticDimension
        
        tableView.delegate = self
        tableView.dataSource = self
        fetchComments()
    }
    
    func setupFilmTitleView()
    {
        if let headerview = tableView.tableHeaderView as? FilmTitleView {
            print("get headerview")
            headerview.post = currentfilm
            
            let height = headerview.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize).height
            var frame = headerview.frame
            frame.size.height = height
            headerview.frame = frame
            
            tableView.tableHeaderView = headerview
        }
    }
    func fetchComments()
    {
        filteredObjects.removeAll()
        let parameters = ["filmid":  currentfilm.film_id]
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            Alamofire.request(.POST, "http://www.skillwhisper.com/film/api/film/latestkidsfilmcomments/format/json",parameters: parameters)
                .responseJSON(){
                    response in
                    print(response.request)
                    print(response.response)
                    print(response.data)
                    print(response.result)
                    if let JSON1 = response.result.value
                    {
                        print("json \(JSON1)")
                        self.parsedataUsingObjectMapper(response.data!)
                       
                    }
                    else
                    {
                        /*
                         dispatch_async(dispatch_get_main_queue()){
                         self.refreshcontrol.endRefreshing()
                         }
                         */
                    }
                    
            }
        }
    }
    func parsedataUsingObjectMapper(jsondata: NSData)
    {
        let json = JSON(data: jsondata)
        if let resultArray = json["results"].arrayObject
        {
            for result in resultArray
            {
                let comment = Mapper<CommentModel>().map(result)
                print("comment \(comment)")
                
                filteredObjects.append(comment!)
                
            }
            dispatch_async(dispatch_get_main_queue()){
                self.updateUI()
            }
        }
        
        
    }
    
    func updateUI()
    {
        print("ok")
        self.tableView.reloadData()
    }
}

extension DetailFilmViewController : UITableViewDataSource
{
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 144
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredObjects.count
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Comments"
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
       
        if filteredObjects.count > 0
        {
            let comment = filteredObjects[indexPath.row]
            
            let cellIdentifier = "OpenCommentCell"
            
            let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! OpenedCommentsCell
            
            cell.comment = comment
            
            return cell
            
            
            
        }
        let cellIdentifier = "NoCommentCell"
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) 
        

        
        return cell
    }
}

extension DetailFilmViewController : UITableViewDelegate
{
    
}
