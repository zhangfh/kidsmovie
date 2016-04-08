//
//  MovieViewController.swift
//  kidsmoview
//
//  Created by zhangfanghui on 16/4/8.
//  Copyright © 2016年 zhangfanghui. All rights reserved.
//

import UIKit
import ObjectMapper

class MovieViewController: UIViewController {

    @IBOutlet weak var moviewTableView: UITableView!
    
    var filteredObjects  = [Film]()
    
    /// 提示Label
    private lazy var tipLabel: TipLabel =
        {
            let label  = TipLabel(frame: CGRectZero)
            // 将提示信息Label 插入 导航条
            self.navigationController?.navigationBar.insertSubview(label, atIndex: 0)
            return label
            
    }()
    
    override func viewDidLoad() {
        title = "Kid's  Movie"
        
        initNavigationBar()
        //addrefreshControl()
        moviewTableView.registerNib(SearchResultCell.NibObject(), forCellReuseIdentifier: SearchResultCell.identifier)
        moviewTableView.rowHeight = 140
        
        moviewTableView.sectionIndexBackgroundColor = UIColor.clearColor()
        
        moviewTableView.delegate = self
        moviewTableView.dataSource = self
        
        fetchFilmlist()
    }
    
    func initNavigationBar()
    {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "barbuttonicon_add"), style: .Plain, target: self, action: #selector(MovieViewController.clickBarButtonItem))
        
    }
    
    func clickBarButtonItem()
    {
        print("click right")
    }
    
    func fetchFilmlist()
    {
        filteredObjects.removeAll()
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            Alamofire.request(.POST, "http://www.skillwhisper.com/film/api/film/latestkidsfilms/format/json")
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
                let film = Mapper<Film>().map(result)
                print("film \(film)")
                
                filteredObjects.append(film!)
                
            }
            dispatch_async(dispatch_get_main_queue()){
                self.updateUI()
            }
        }
        
        
    }
    
    func updateUI()
    {
        //refreshcontrol.endRefreshing()
        moviewTableView.reloadData()
        showPullMessage(filteredObjects.count)
    }
    
    /**
     显示下拉信息
     */
    private func showPullMessage(count: Int) {
        
        tipLabel.text = count == 0 ? "没有新的推荐" : "加载了\(count)条推荐"
        
        // 初始frame
        let srcFrame = tipLabel.frame
        
        // 动画显示、隐藏tipLabel
        UIView.animateWithDuration(0.75, animations: { () -> Void in
            self.tipLabel.frame.origin.y = 44
        }) { (_) -> Void in
            UIView.animateWithDuration(0.75, delay: 0.25, options: UIViewAnimationOptions(rawValue: 0), animations: { () -> Void in
                // 还原frame
                self.tipLabel.frame = srcFrame
                }, completion: {(_) -> Void in
                    // 移除tipLabel
                    //                       self.tipLabel.removeFromSuperview()
            })
        }
        
    }
    
    
    
    
    
}

// MARK: - UITableView Delegate / Data Source

extension MovieViewController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        return indexPath
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        let editMovieAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Edit") { _ in
            self.moviewTableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
        
        editMovieAction.backgroundColor = UIColor(red: 141.0 / 255.0, green: 141.0 / 255.0, blue: 141.0 / 255.0, alpha: 1.0)
        
        let deleteMovieAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Delete") { _ in
            
        }
        
        deleteMovieAction.backgroundColor = UIColor(red: 126.0 / 255.0, green: 126.0 / 255.0, blue: 126.0 / 255.0, alpha: 1.0)
        
        let changeMovieStatusAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Status") { _ in
            
        }
        
        changeMovieStatusAction.backgroundColor = UIColor(red: 178.0 / 255.0, green: 178.0 / 255.0, blue: 178.0 / 255.0, alpha: 1.0)
        
        return [deleteMovieAction, editMovieAction, changeMovieStatusAction]
    }
    
}


extension MovieViewController: UITableViewDataSource {
    
    func sectionIndexTitlesForTableView(tableView: UITableView) -> [String]? {
        
        return Constants.titleIndex
        
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return nil
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return (filteredObjects.count)
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(SearchResultCell.identifier, forIndexPath: indexPath) as! SearchResultCell
        let film = filteredObjects[indexPath.row]
        
        cell.configureForSearchResult(film)
        
        return cell
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
        
    }
}

