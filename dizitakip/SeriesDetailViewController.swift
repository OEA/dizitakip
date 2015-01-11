//
//  SeriesDetailViewController.swift
//  dizitakip
//
//  Created by Ömer Emre Aslan on 06/01/15.
//  Copyright (c) 2015 OEASLAN. All rights reserved.
//

import Foundation
import UIKit

class SeriesDetailViewController:UIViewController{
 
    
    @IBOutlet weak var seriesLabelTitle: UILabel!
    @IBOutlet weak var lblGenres: UILabel!
    @IBOutlet weak var seriesImage: UIImageView!
    @IBOutlet var lblSeasonDetail: UILabel!
    @IBOutlet var lblCast: UILabel!
    
    var seriesModel: SeriesModel = SeriesModel()
    
    var seriesTitle: String = ""
    var genresTitle: String = ""
    var imageUrl: String = ""
    var seriesId: String!
    var seasons: [[String:String]]!
    var casts: [[String:String]]!
    
    var count: Int = 1
    override func viewDidLoad() {
        super.viewDidLoad()
        
        seriesModel.setSeasons(seriesId)
        seriesModel.setCasts(seriesId)
        seasons = seriesModel.seasons
        casts = seriesModel.casts
        
        initSeriesDetail()
        
    }
    
    func initSeriesDetail(){
        seriesLabelTitle.text = seriesTitle
        lblGenres.text = genresTitle
    
        var apiUrl = "http://localhost/imdb/" + imageUrl
    
        if let nsurl = NSURL(string: apiUrl) {
            if let nsdata = NSData(contentsOfURL: nsurl) {
                seriesImage.image = UIImage(data: nsdata)
            }
        }
        
        title = seriesTitle
        
        var seasonDetailText: String = ""
        var seasonCount: Int = seasons.count
        var episodeCount: Int = 0
        for season in seasons{
            var count: Int = season["episode_count"]!.toInt()!
            episodeCount = episodeCount + count
        }
        lblSeasonDetail.text = "\(seasonCount) Seasons \(episodeCount) Episodes"
        lblCast.text = "\(casts.count) Casts"
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showSeasons"{
            var newVC:SeasonViewController = segue.destinationViewController as SeasonViewController
            newVC.seriesId = seriesId
            newVC.seriesName = seriesTitle
        }else if segue.identifier == "showCasts"{
            var newVC:CastViewController = segue.destinationViewController as CastViewController
            newVC.casts = casts
            newVC.seriesTitle = seriesTitle

        }
    }
   
    
}