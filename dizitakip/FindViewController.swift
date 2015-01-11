//
//  FindViewController.swift
//  dizitakip
//
//  Created by Ömer Emre Aslan on 10/01/15.
//  Copyright (c) 2015 OEASLAN. All rights reserved.
//

import Foundation
import UIKit

extension String
{
    func replace(target: String, withString: String) -> String
    {
        return self.stringByReplacingOccurrencesOfString(target, withString: withString, options: NSStringCompareOptions.LiteralSearch, range: nil)
    }
}

class FindViewController : UITableViewController,UISearchBarDelegate{
    let seriesModel: SeriesModel = SeriesModel()
    var series: [[String:String]]! = nil
    
    let userDefaults = NSUserDefaults.standardUserDefaults()
    var profile: [String:String]!
    var count: Int = 0
    @IBOutlet var tblView: UITableView!
    @IBOutlet weak var searchBarItem: UISearchBar!
    @IBOutlet weak var searchType: UISegmentedControl!
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return count
    }
    override func viewDidLoad() {
        
        searchBarItem.delegate = self
        searchBarItem.showsCancelButton = false
        profile = userDefaults.objectForKey("profile") as [String:String]
    }
    @IBAction func typeChanged(sender: AnyObject) {
        let searchText = searchBarItem.text
        if searchText==""{
            series = nil
            self.count = 0
        }else{
            seriesModel.setSearch(searchText.replace(" ", withString: "+"),
                type:searchType.selectedSegmentIndex)
            series = seriesModel.search
            self.count = series.count
        }
        self.tblView.reloadData()  
    }
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        
        
        if searchText==""{
            series = nil
            self.count = 0
        }else{
            seriesModel.setSearch(searchText.replace(" ", withString: "+"),
                type:searchType.selectedSegmentIndex)
            series = seriesModel.search
            self.count = series.count
        }
        self.tblView.reloadData()
    }
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        
        
        
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("searchSeries") as SearchTableCell
        
        cell.searchTitle.text = series[indexPath.row]["series_name"]
        cell.searchGenres.text = series[indexPath.row]["series_genres"]
        
        
        var apiUrl = "http://localhost/imdb/"+series[indexPath.row]["series_img"]!
        
        
        if let nsurl = NSURL(string: apiUrl) {
            
            if let nsdata = NSData(contentsOfURL: nsurl) {
                
                cell.searchImage.image = UIImage(data: nsdata)
            }
            
        }
        
        return cell
    }
        
    @IBAction func swipeLeft(sender: AnyObject) {
        
        searchType.selectedSegmentIndex = 0
        typeChanged(self)
    }
    @IBAction func swipeRight(sender: AnyObject) {
        searchType.selectedSegmentIndex = 1
        typeChanged(self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "detailsFromSearch"{
            
            var newVC:SeriesDetailViewController = segue.destinationViewController as SeriesDetailViewController
            
            let cell = sender as UITableViewCell
            let indexPath = tableView.indexPathForCell(cell)
            let seriesTitle = series[indexPath!.item]["series_name"]!
            let genresTitle = series[indexPath!.item]["series_genres"]!
            let imageUrl = series[indexPath!.item]["series_img"]!
            
            newVC.seriesTitle = seriesTitle
            newVC.genresTitle = genresTitle
            newVC.imageUrl = imageUrl
            
            
            
        }
    }
    
}
