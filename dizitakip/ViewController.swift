//
//  ViewController.swift
//  dizitakip
//
//  Created by Ömer Emre Aslan on 14/11/14.
//  Copyright (c) 2014 OEASLAN. All rights reserved.
//
import UIKit

class ViewController: UIViewController {

    
    var system: SystemModel = SystemModel()
    
    let userDefaults = NSUserDefaults.standardUserDefaults()
    
    @IBOutlet weak var txtPass: UITextField!
    
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var txtUser: UITextField!
    @IBAction func txtChanged(sender: AnyObject) {
        if txtUser.text != "" && txtPass.text != "" {
            btnLogin.enabled = true
        }else{
            btnLogin.enabled = false
        }
    }
    override func viewDidLoad() {
        btnLogin.enabled = false
    }
    @IBAction func loginTapped(sender: AnyObject) {
        var isLoggedIn: Bool = system.login(txtUser.text, password: txtPass.text)
        println(isLoggedIn)
        if isLoggedIn{
            userDefaults.setBool(true, forKey: "isLoggedIn")
            userDefaults.setObject(system.profile, forKey: "profile")
            
            let vc : AnyObject! = self.storyboard?.instantiateViewControllerWithIdentifier("Home")
            self.showViewController(vc as UIViewController, sender: vc)
            
        }else{
            txtPass.text = ""
            let alertController = UIAlertController(title: "Error", message:
                "Please check your credentials.", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default,handler: nil))
            self.presentViewController(alertController, animated: true, completion: nil)
            
        }
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "register"{
            let newVC = segue.destinationViewController as RegisterController
            newVC.destinationVC = self
        }
        
    }
}

