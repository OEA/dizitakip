//
//  RegisterController.swift
//  dizitakip
//
//  Created by Ömer Emre Aslan on 04/01/15.
//  Copyright (c) 2015 OEASLAN. All rights reserved.
//

import Foundation
import UIKit

class RegisterController: UIViewController {
    
    var system: SystemModel! = SystemModel()
    var destinationVC: UIViewController!
    let userDefaults = NSUserDefaults.standardUserDefaults()
    
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var btnRegister: UIButton!
    override func viewDidLoad() {
        btnRegister.enabled = false
    }
    @IBAction func cancelTapped(sender: AnyObject) {
        
        self.navigationController?.popToViewController(destinationVC, animated: true)
    }
    @IBAction func txtChanged(sender: AnyObject) {
        if txtUsername.text != "" && txtPassword.text != "" && txtEmail.text != "" {
            btnRegister.enabled = true
        }else{
            btnRegister.enabled = false
        }
        
    }
    @IBAction func registerTapped(sender: AnyObject) {
        
        if validateEmail(txtEmail.text){
            var isRegistered: Bool = system.register(txtUsername.text, password: txtPassword.text, email: txtEmail.text)
            println(isRegistered)
            if isRegistered{
                userDefaults.setBool(true, forKey: "isLoggedIn")
                userDefaults.setObject(system.profile, forKey: "profile")
                
                let vc : AnyObject! = self.storyboard?.instantiateViewControllerWithIdentifier("Home")
                self.showViewController(vc as UIViewController, sender: vc)
                
            }else{
                txtPassword.text = ""
                
                let alertController = UIAlertController(title: "Error", message:
                    system.errorMessage, preferredStyle: UIAlertControllerStyle.Alert)
                alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default,handler: nil))
                self.presentViewController(alertController, animated: true, completion: nil)
                
            }

        }else{
            txtPassword.text = ""
            txtEmail.text = ""
            let alertController = UIAlertController(title: "Error", message:
                "Please write valid email. \n Ex: mail@site.com!", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default,handler: nil))
            self.presentViewController(alertController, animated: true, completion: nil)

        }
    
    }
    func validateEmail(candidate: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex)!.evaluateWithObject(candidate)
    }
}