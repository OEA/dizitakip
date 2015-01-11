//
//  CastViewController.swift
//  dizitakip
//
//  Created by Ömer Emre Aslan on 11/01/15.
//  Copyright (c) 2015 OEASLAN. All rights reserved.
//

import Foundation
import UIKit

class CastViewController : UITableViewController{
    
    var casts: [[String:String]]!
    var seriesTitle: String!
    override func viewDidLoad() {
        
    }
    override func viewDidAppear(animated: Bool) {
        
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return casts.count
    }
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Casts of " + seriesTitle
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("castCell") as UITableViewCell
        
        
            cell.textLabel!.text = casts[indexPath.row]["cast_name"]
         
        return cell
    }
}