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
    override func viewDidLoad() {
        
    }
    override func viewDidAppear(animated: Bool) {
        
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("episodeCell") as UITableViewCell
        
        return cell
    }
}