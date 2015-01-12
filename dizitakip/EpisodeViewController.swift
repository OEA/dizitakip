//
//  EpisodeViewController.swift
//  dizitakip
//
//  Created by Ömer Emre Aslan on 11/01/15.
//  Copyright (c) 2015 OEASLAN. All rights reserved.
//

import Foundation
import UIKit

class EpisodeViewController : UITableViewController{
    var episodes:[[String:String]]!
    var seriesTitle: String!
    
    
    let userDefaults = NSUserDefaults.standardUserDefaults()
    var profile: [String:String]!
    
    
    var seriesModel:SeriesModel = SeriesModel()
    override func viewDidLoad() {
        title = "Ep. of "+seriesTitle
        
        profile = userDefaults.objectForKey("profile") as [String:String]
    }
    override func viewDidAppear(animated: Bool) {
        
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodes.count
    }
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            // handle delete (by removing the data from your array and updating the tableview)
        }
        if (editingStyle == UITableViewCellEditingStyle.None){
            
        }
    }
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [AnyObject] {
        
        
        var episodeId:String = episodes[indexPath.row]["episode_id"]!
        var userID: String = profile["user_id"]! 
        var likeAction: UITableViewRowAction!
        var watchAction: UITableViewRowAction!
        var paths = indexPath
        //Unlike process
        if self.seriesModel.isLikedEpisode(episodeId, userId: userID){
            likeAction = UITableViewRowAction(style: .Normal, title: "Unlike") { (action, indexPath) -> Void in
                tableView.editing = false
                self.seriesModel.likeEpisode(episodeId, userId: userID)
            }
            likeAction.backgroundColor = UIColorFromRGB(0xFF0000)
        }else{
            likeAction = UITableViewRowAction(style: .Normal, title: "Like") { (action, indexPath) -> Void in
                tableView.editing = false
                self.seriesModel.likeEpisode(episodeId, userId: userID)
            }
            likeAction.backgroundColor = UIColorFromRGB(0x29ade0)
        }
        
        
        if self.seriesModel.isWatchedEpisode(episodeId, userId: userID){
            watchAction = UITableViewRowAction(style: .Normal, title: "Unwatch") { (action, indexPath) -> Void in
                tableView.editing = false
                self.seriesModel.watchEpisode(episodeId, userId: userID)
            }
            watchAction.backgroundColor = UIColorFromRGB(0xFF0000)
        }else{
            watchAction = UITableViewRowAction(style: .Normal, title: "Watch") { (action, indexPath) -> Void in
                tableView.editing = false
                self.seriesModel.watchEpisode(episodeId, userId: userID)
            }
            watchAction.backgroundColor = UIColorFromRGB(0xFF8000)
        }
        
        
        return [likeAction, watchAction]
        
        
    }

    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("episodeCell") as UITableViewCell
        
        cell.textLabel!.text = episodes[indexPath.row]["episode_name"]
        cell.detailTextLabel!.text = episodes[indexPath.row]["episode_editedtime"]
       
        
        return cell
    }
}