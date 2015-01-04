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
    
    let userDefaults = NSUserDefaults.standardUserDefaults()
    
    var profile: [String:String]!
    
    @IBOutlet
    var tableView: UITableView!
    
    var items: [String] = ["Today's Series", "Top 10 IMDB Series", "Favorited Series" , "Stuck Series"]
    
    override func viewDidLoad() {
        profile = userDefaults.objectForKey("profile") as [String:String]
        labelWelcome.text = "Welcome " + profile["user_name"]! + ", "
       
        
    }
      @IBAction func logoutTapped(sender: AnyObject) {
        userDefaults.setBool(false, forKey: "isLoggedIn")
        userDefaults.setObject(nil, forKey: "profile")
        let vc : AnyObject! = self.storyboard?.instantiateViewControllerWithIdentifier("Login")
        self.showViewController(vc as UIViewController, sender: vc)

    }
    
}