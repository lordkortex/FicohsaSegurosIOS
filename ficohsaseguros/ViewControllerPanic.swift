//
//  ViewControllerPanic.swift
//  ficohsaseguros
//
//  Created by mac on 18/10/15.
//  Copyright © 2015 SoftwareFactoryHN. All rights reserved.
//

import UIKit

class ViewControllerPanic: UIViewController {
    
    
    @IBOutlet weak var Open: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Open.target = self.revealViewController()
        Open.action = Selector("revealToggle:")
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
    }
    
    override func viewDidAppear(animated: Bool) {
        self.navigationController?.navigationBar.topItem?.title = "Menu"
        
        
        //var color: UIColor = UIColor(red: 62/255, green: 93/255, blue: 132/255, alpha: 1.0)
        
        //self.navigationController?.navigationBar.barTintColor = color
        //let titleDict: NSDictionary = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        //self.navigationController?.navigationBar.titleTextAttributes = titleDict as [NSObject : AnyObject]
        //self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        let isLoggedIn:Int? = prefs.integerForKey("ISLOGGEDIN") as Int
        if (isLoggedIn != 0 || isLoggedIn == nil)  {
            self.performSegueWithIdentifier("gotoLogin", sender: self)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        
        
        
        if (segue.identifier == "gotoLogin") {
            let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
            prefs.setObject("", forKey: "USERNAME")
            prefs.setInteger(1, forKey: "ISLOGGEDIN")
            prefs.synchronize()
            
            
        }
        
        /*if (segue.identifier == "gotoNotificaciones") {
        let svc = segue.destinationViewController as! TableViewControllerNotificacionesCell;
        
        }*/
    }
    

}