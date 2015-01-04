//
//  SeriesModel.swift
//  dizitakip
//
//  Created by Ömer Emre Aslan on 04/01/15.
//  Copyright (c) 2015 OEASLAN. All rights reserved.
//

import Foundation

class SeriesModel{
   
    let apiKey = "d3ff368943be4b576251437784234c5d3a200160"
    let apiSecret = "268403caf178514c213cc9ee41bf7252848a4b50"
    var apiUrl = "http://localhost/imdb/api/"
    
    var series: [String:String]! = nil
    var errorMessage: String! = nil
    
}