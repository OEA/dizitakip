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
    
    var seriesTitle: String = ""
    var genresTitle: String = ""
    var imageUrl: String = ""
    
    var count: Int = 1
    override func viewDidLoad() {
        super.viewDidLoad()
        initSeriesDetail()
        
        let screenSize: CGRect = UIScreen.mainScreen().bounds
        
        
        
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
    }
   
    
}