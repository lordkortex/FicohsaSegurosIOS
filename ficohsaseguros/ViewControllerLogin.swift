//
//  ViewControllerLogin.swift
//  ficohsaseguros
//
//  Created by mac on 18/10/15.
//  Copyright © 2015 SoftwareFactoryHN. All rights reserved.
//

import UIKit

class ViewControllerLogin: UIViewController {
    
    
    @IBOutlet weak var TextViewUser: UITextField!
    @IBOutlet weak var TextViewPassword: UITextField!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func login(sender: AnyObject) {
        
        let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        prefs.setObject("", forKey: "USERNAME")
        prefs.setInteger(0, forKey: "ISLOGGEDIN")
        prefs.synchronize()

        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
}