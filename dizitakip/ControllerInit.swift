//
//  File.swift
//  dizitakip
//
//  Created by Ömer Emre Aslan on 04/01/15.
//  Copyright (c) 2015 OEASLAN. All rights reserved.
//

import Foundation
import UIKit

class ControllerInit : UINavigationController{
    
    let userDefaults = NSUserDefaults.standardUserDefaults()
    
    override func viewDidLoad() {
        
        let isLoggedIn = userDefaults.boolForKey("isLoggedIn")
        if isLoggedIn{
            let vc : AnyObject! = self.storyboard?.instantiateViewControllerWithIdentifier("Home")
            self.showViewController(vc as UIViewController, sender: vc)
        }else{
            let vc : AnyObject! = self.storyboard?.instantiateViewControllerWithIdentifier("Login")
            self.showViewController(vc as UIViewController, sender: vc)
        }
    }
    
}