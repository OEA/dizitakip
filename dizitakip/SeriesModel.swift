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
    let baseApiUrl = "http://localhost/imdb/api/"
    var runUrl: String! = nil
    var top10: [[String:String]]! = nil
    var recent: [[String:String]]! = nil
    var favorites: [[String:String]]! = nil
    var errorMessage: String! = nil
    var likedOrNot: String! = nil
    
    func setTop10(){
        var apiUrl = baseApiUrl + "getTop10?apiKey=" + apiKey + "&apiSecret=" + apiSecret
        runUrl = apiUrl
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
    func setFavorites(userId: Int){
        
        var strUID: String = String(userId)
        var apiUrl = baseApiUrl + "likedseries?apiKey=" + apiKey + "&apiSecret=" + apiSecret + "&userId=" + strUID
        runUrl = apiUrl
        if let nsurl = NSURL(string: apiUrl) {
            
            if let nsdata = NSData(contentsOfURL: nsurl) {
                
                var jsonDict: [String:AnyObject]!
                jsonDict = NSJSONSerialization.JSONObjectWithData(nsdata, options: NSJSONReadingOptions.AllowFragments, error: nil) as [String:AnyObject]
                
                var status = jsonDict["status"] as String
                
                
                if (status=="success" as String){
                    favorites = jsonDict["result"] as [[String:String]]
                }else{
                    errorMessage = jsonDict["error_message"] as String
                }
                
                
            }
        }
    }
    
    func likeSeries(seriesId:Int , userId: Int){
        var strSID: String = String(seriesId)
        var strUID: String = String(userId)
        
        var apiUrl = baseApiUrl + "likeSeries?apiKey=" + apiKey + "&apiSecret=" + apiSecret + "&seriesId="+strSID+"&userId=" + strUID
        runUrl = apiUrl
        if let nsurl = NSURL(string: apiUrl) {
            if let nsdata = NSData(contentsOfURL: nsurl) {
                
                println(apiUrl)
                var jsonDict: [String:AnyObject]!
                jsonDict = NSJSONSerialization.JSONObjectWithData(nsdata, options: NSJSONReadingOptions.AllowFragments, error: nil) as [String:AnyObject]
                
                var status = jsonDict["status"] as String
                
                
                if (status=="success" as String){
                    likedOrNot = jsonDict["message"] as String
                }else{
                    errorMessage = jsonDict["message"] as String
                }
                
                
            }
        }
    }
    
    func isLikedSeries(seriesId: Int, userId:Int) -> Bool{
        var strSID: String = String(seriesId)
        var strUID: String = String(userId)
        
        var apiUrl = baseApiUrl + "isLikedSeries?apiKey=" + apiKey + "&apiSecret=" + apiSecret + "&seriesId="+strSID+"&userId=" + strUID
        runUrl = apiUrl
        if let nsurl = NSURL(string: apiUrl) {
            if let nsdata = NSData(contentsOfURL: nsurl) {
                
                var jsonDict: [String:AnyObject]!
                jsonDict = NSJSONSerialization.JSONObjectWithData(nsdata, options: NSJSONReadingOptions.AllowFragments, error: nil) as [String:AnyObject]
                
                var status = jsonDict["status"] as String
                
                
                if (status=="success" as String){
                    return true
                }else{
                    
                }
                
            }
        }
        return false
    }
    
}
