//
//  SeasonsViewController.swift
//  dizitakip
//
//  Created by Ömer Emre Aslan on 11/01/15.
//  Copyright (c) 2015 OEASLAN. All rights reserved.
//

import Foundation
import UIKit

class SeasonViewController : UITableViewController{
    
    let seriesModel: SeriesModel = SeriesModel()
    var seasons: [[String:String]]!
    var seriesId: String!
    var seriesName: String!
    override func viewDidLoad() {
        seriesModel.setSeasons(seriesId)
        seasons = seriesModel.seasons
        title = seriesName
    }
    override func viewDidAppear(animated: Bool) {
        
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return seasons.count
    }
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("seasonCell") as UITableViewCell
        
        cell.textLabel!.text = String(indexPath.row+1)+". Season"
        cell.detailTextLabel!.text = seasons[indexPath.row]["episode_count"]
        
        return cell
    }
}