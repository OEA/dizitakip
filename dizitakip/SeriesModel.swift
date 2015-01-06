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
    
    var top10: [[String:String]]! = nil
    var recent: [[String:String]]! = nil
    var errorMessage: String! = nil
    
    func setTop10(){
        apiUrl = apiUrl + "getTop10?apiKey=" + apiKey + "&apiSecret=" + apiSecret
        
        if let nsurl = NSURL(string: apiUrl) {
            
            if let nsdata = NSData(contentsOfURL: nsurl) {
                
                var jsonDict: [String:AnyObject]!
                jsonDict = NSJSONSerialization.JSONObjectWithData(nsdata, options: NSJSONReadingOptions.AllowFragments, error: nil) as [String:AnyObject]
                
                var status = jsonDict["status"] as String
                
                
                if (status=="success" as String){
                    top10 = jsonDict["result"] as [[String:String]]
                }else{
                    errorMessage = jsonDict["error_message"] as String
                }
                
                
            }
        }
    }
    func setRecent(){
        apiUrl = apiUrl + "recent?apiKey=" + apiKey + "&apiSecret=" + apiSecret
        
        if let nsurl = NSURL(string: apiUrl) {
            
            if let nsdata = NSData(contentsOfURL: nsurl) {
                
                var jsonDict: [String:AnyObject]!
                jsonDict = NSJSONSerialization.JSONObjectWithData(nsdata, options: NSJSONReadingOptions.AllowFragments, error: nil) as [String:AnyObject]
                
                var status = jsonDict["status"] as String
                
                
                if (status=="success" as String){
                    top10 = jsonDict["result"] as [[String:String]]
                }else{
                    errorMessage = jsonDict["error_message"] as String
                }
                
                
            }
        }
    }

}
