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
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector:#selector(DetailFilmViewController.downloadImageFinish), name: "DetailFilmDownloadImageNotification", object: nil)
        //how make it work, please set textview's scroll enable is false
        tableView.estimatedRowHeight = 44.0
        tableView.rowHeight = UITableViewAutomaticDimension
        
        
        tableView.delegate = self
        tableView.dataSource = self
        fetchComments()
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func downloadImageFinish()
    {
        setupFilmTitleView()
        updateUI()
        let newIndexPath = NSIndexPath(forRow: 0, inSection: 0)
        tableView.scrollToRowAtIndexPath(newIndexPath, atScrollPosition: .Top, animated: true)

    }
    func setupFilmTitleView()
    {
        if let headerview = tableView.tableHeaderView as? FilmTitleView {
            print("get headerview")
            
            
            if headerview.post == nil {
                //headerview.configure()
                headerview.post = currentfilm
            }
            
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
    
    func addNewComment()
    {
        
    }
}

extension DetailFilmViewController : UITableViewDataSource
{

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredObjects.count + 1
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return currentfilm.name
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        //hardcode
        
        if indexPath.row == 0
        {
            
            let cellIdentifier = "DescriptionCell"
            
            let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! DescriptionCell
            cell.configure(currentfilm.longDesc)
            
            return cell
        }else
        {
            
            
            if filteredObjects.count > 0
            {
                let comment = filteredObjects[indexPath.row - 1]
                
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
}

extension DetailFilmViewController : UITableViewDelegate
{
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if(section == 0) {
            
            let view = UIView() // The width will be the same as the cell, and the height should be set in tableView:heightForRowAtIndexPath:
            
            let label = UILabel()
            label.text=currentfilm.name
            label.translatesAutoresizingMaskIntoConstraints = false
            
            
            let button = UIButton(type: .System)
            button.addTarget(self, action: #selector(DetailFilmViewController.addNewComment), forControlEvents:.TouchUpInside)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.setTitle("Add New Comment", forState: .Normal)
            button.setTitleColor(UIColor.redColor(), forState: .Normal)
           
            let views = ["label": label,"button":button,"view": view]
            
            view.addSubview(label)
            view.addSubview(button)
            
            let horizontallayoutContraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|-10-[label]-60-[button]-10-|", options: .AlignAllCenterY, metrics: nil, views: views)
            view.addConstraints(horizontallayoutContraints)
            
            let verticalLayoutContraint = NSLayoutConstraint(item: label, attribute: .CenterY, relatedBy: .Equal, toItem: view, attribute: .CenterY, multiplier: 1, constant: 0)
            view.addConstraint(verticalLayoutContraint)
            return view
        }
        return nil
    }
    
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
}
