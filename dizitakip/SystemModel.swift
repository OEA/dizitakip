//
//  SystemModel.swift
//  dizitakip
//
//  Created by Ömer Emre Aslan on 03/01/15.
//  Copyright (c) 2015 OEASLAN. All rights reserved.
//
import Foundation

class SystemModel{
    let apiKey = "d3ff368943be4b576251437784234c5d3a200160"
    let apiSecret = "268403caf178514c213cc9ee41bf7252848a4b50"
    var apiUrl = "http://localhost/imdb/api/"
    
    var profile: [String:String]! = nil
    var errorMessage: String! = nil
    func login(username: String, password: String) -> Bool{
        apiUrl = apiUrl + "login?apiKey=" + apiKey + "&apiSecret=" + apiSecret + "&username=" + username + "&password=" + password
        
        if let nsurl = NSURL(string: apiUrl) {
            
            if let nsdata = NSData(contentsOfURL: nsurl) {
                
                var jsonDict: [String:AnyObject]!
                jsonDict = NSJSONSerialization.JSONObjectWithData(nsdata, options: NSJSONReadingOptions.AllowFragments, error: nil) as [String:AnyObject]
                
                var status = jsonDict["status"] as String
                
                
                if (status=="success" as String){
                    var userInfos = jsonDict["result"] as [[String:String]]
                    profile =  userInfos[0]
                    return true
                }
                
                
            }
        }
        
        return false
    }
    
    func register(username: String, password: String, email: String)->Bool{
        
        apiUrl = apiUrl + "register?apiKey=" + apiKey + "&apiSecret=" + apiSecret + "&username=" + username + "&password=" + password + "&email=" + email
        
        if let nsurl = NSURL(string: apiUrl) {
            
            if let nsdata = NSData(contentsOfURL: nsurl) {
                
                var jsonDict: [String:AnyObject]!
                jsonDict = NSJSONSerialization.JSONObjectWithData(nsdata, options: NSJSONReadingOptions.AllowFragments, error: nil) as [String:AnyObject]
                
                var status = jsonDict["status"] as String
                
                
                if (status=="success" as String){
                    var userInfos = jsonDict["result"] as [[String:String]]
                    profile =  userInfos[0]
                    return true
                }else{
                    errorMessage = jsonDict["error_message"] as String
                }
                
                
            }
        }
        
        return false
        
    }
}