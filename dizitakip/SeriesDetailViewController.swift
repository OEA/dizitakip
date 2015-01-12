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
    
    let userDefaults = NSUserDefaults.standardUserDefaults()
    var profile: [String:String]!
    
    @IBOutlet var likeButton: UIButton!
    var count: Int = 1
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profile = userDefaults.objectForKey("profile") as [String:String]
        seriesModel.setSeasons(seriesId)
        seriesModel.setCasts(seriesId)
        seasons = seriesModel.seasons
        casts = seriesModel.casts
        
        initSeriesDetail()
        
        var userId: String! = profile["user_id"]
        var UID: Int = userId.toInt()!
        var SID: Int = seriesId.toInt()!
        if seriesModel.isLikedSeries(SID, userId:UID ){
            likeButton.setTitle("Unlike", forState: nil)
            likeButton.backgroundColor = UIColorFromRGB(0xFF0000)
        }
        
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
    
    @IBAction func likeButtonTapped(sender: AnyObject) {
        
        var userId: String! = profile["user_id"]
        var UID: Int = userId.toInt()!
        var SID: Int = seriesId.toInt()!
        seriesModel.likeSeries(SID, userId: UID)
        
        if seriesModel.isLikedSeries(SID, userId:UID ){
            likeButton.setTitle("Unlike", forState: nil)
            likeButton.backgroundColor = UIColorFromRGB(0xFF0000)
        }else{
            
            likeButton.setTitle("Like", forState: nil)
            likeButton.backgroundColor = UIColorFromRGB(0x29ADE0)
        
        }
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
    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
   
    
}