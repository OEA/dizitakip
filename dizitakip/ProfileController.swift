//
//  ProfileController.swift
//  dizitakip
//
//  Created by Ömer Emre Aslan on 04/01/15.
//  Copyright (c) 2015 OEASLAN. All rights reserved.
//

import Foundation
import UIKit

class ProfileController: UIViewController {
    @IBOutlet weak var labelWelcome: UILabel!
    @IBOutlet weak var tblView: UITableView!
    
    let userDefaults = NSUserDefaults.standardUserDefaults()
    
    var profile: [String:String]!
    
    var system: SystemModel! = SystemModel()
    var statistics: [String:String]! = nil
   
        
    var items: [String] = ["Today's Series", "Top 10 IMDB Series", "Favorited Series" , "Stuck Series"]
    
    override func viewDidLoad() {
        profile = userDefaults.objectForKey("profile") as [String:String]
        
        system.setStatistics(profile["user_id"]!)
        statistics = system.statistics
    }
    
    override func viewDidAppear(animated: Bool) {
        system.setStatistics(profile["user_id"]!)
        statistics = system.statistics
        tblView.reloadData()
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
        return 4
    }  
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
     func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section==0{
            return "User Informations"
        }
        return "Statistics"
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("statistics") as UITableViewCell
        
        if indexPath.section == 0{
            switch(indexPath.row){
                case 0:
                    cell.textLabel!.text = "Username"
                    cell.detailTextLabel!.text = profile["user_name"]
                case 1:
                    cell.textLabel!.text = "Liked Series"
                    cell.detailTextLabel!.text = statistics["liked_series"]
                case 2:
                    cell.textLabel!.text = "Liked Episodes"
                    cell.detailTextLabel!.text = statistics["liked_episodes"]
                case 3:
                    cell.textLabel!.text = "Watched Episodes"
                    cell.detailTextLabel!.text = statistics["watched_episodes"]
                default:
                    cell.detailTextLabel!.text = "Test"
            }
        }else{
            
            switch(indexPath.row){
                case 0:
                    cell.textLabel!.text = "Total Series"
                    cell.detailTextLabel!.text = statistics["total_series"]
                case 1:
                    cell.textLabel!.text = "Total Genres"
                    cell.detailTextLabel!.text = statistics["total_genres"]
                case 2:
                    cell.textLabel!.text = "Total Casts"
                    cell.detailTextLabel!.text = statistics["total_casts"]
                case 3:
                    cell.textLabel!.text = "Total Episodes"
                    cell.detailTextLabel!.text = statistics["total_episodes"]
                default:
                    cell.detailTextLabel!.text = "Test"
       
            }
        }

        return cell
        }
    
      @IBAction func logoutTapped(sender: AnyObject) {
        
        userDefaults.setBool(false, forKey: "isLoggedIn")
        userDefaults.setObject(nil, forKey: "profile")
        let vc : AnyObject! = self.storyboard?.instantiateViewControllerWithIdentifier("LoginNavigation")
        self.presentViewController(vc as UIViewController, animated: true, completion: nil)
       // self.showViewController(vc, sender: vc)

    }
    
}