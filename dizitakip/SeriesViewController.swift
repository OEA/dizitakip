//
//  SeriesViewController.swift
//  dizitakip
//
//  Created by Ömer Emre Aslan on 04/01/15.
//  Copyright (c) 2015 OEASLAN. All rights reserved.
//

import Foundation
import UIKit

class SeriesViewController : UITableViewController{
    let transportItems = ["Person Of Interest","Medcezir","Game of Thrones","Gotham","Silicon Valley", "Da Vinci's Demons", "Arrow"]
    let images = ["d1d7e4079b8c","3ebcca824e0e","557d6301f200","32cae652a495","310a43ac848e","fe4cd354ded7","979ddc397a09"]
    let genres = ["Action | Drama | Mystery", "Comedy | Drama | Romance", "Adventure | Drama | Fantasy", "Crime | Drama | Thriller", "Comedy", "Adventure | Drama | Fantasy", "Action | Adventure | Crime"]
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transportItems.count
    }
    override func viewDidLoad() {
        
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("SeriesTableCell") as SeriesTableCell
        
        cell.seriesTitle.text = transportItems[indexPath.row]
        cell.seriesGenres.text = genres[indexPath.row]
        var apiUrl = "http://localhost/imdb/images/"+images[indexPath.row]+".jpg"
        
        if let nsurl = NSURL(string: apiUrl) {
            
            if let nsdata = NSData(contentsOfURL: nsurl) {
                
                cell.seriesImage.image = UIImage(data: nsdata)
                }
            
            }
        
        return cell
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
            var likeAction = UITableViewRowAction(style: .Normal, title: "Like") { (action, indexPath) -> Void in
                tableView.editing = false
                println("likeAction")
            }
        likeAction.backgroundColor = UIColorFromRGB(0x29ade0)
        
            var followAction = UITableViewRowAction(style: .Default, title: "Follow") { (action, indexPath) -> Void in
                tableView.editing = false
                println("followAction")
            }
        
            followAction.backgroundColor = UIColorFromRGB(0x158cba)
        
           
            return [likeAction, followAction]
        }
        
    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }

    
}