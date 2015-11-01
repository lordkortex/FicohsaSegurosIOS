//
//  ViewControllerPanic.swift
//  ficohsaseguros
//
//  Created by mac on 18/10/15.
//  Copyright © 2015 SoftwareFactoryHN. All rights reserved.
//

import UIKit
import CoreData
import CoreLocation
import HealthKit
import MapKit

class ViewControllerPanic: UIViewController {
    
    
    @IBOutlet weak var Open: UIBarButtonItem!
    
    var strLattitud:String = ""
    var strLongitud:String = ""
    
    lazy var locationManager: CLLocationManager = {
        var _locationManager = CLLocationManager()
        _locationManager.delegate = self
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest
        _locationManager.activityType = .Fitness
        
        // Movement threshold for new events
        _locationManager.distanceFilter = 10.0
        return _locationManager
        }()

     
    
    override func viewDidLoad() {
       
        super.viewDidLoad()
        Open.target = self.revealViewController()
        Open.action = Selector("revealToggle:")
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        
    } 
    
    @IBOutlet weak var ButtonPanic: UIButton!
    
    @IBAction func ButtonPanicAction(sender: AnyObject) {
 
        var refreshAlert = UIAlertController(title: "Error de comunicacion", message: "Imposible comunicarse con asistencia Ficohsa.Levantar llamada.", preferredStyle: UIAlertControllerStyle.Alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in
            //println("Handle Ok logic here")
        }))
        
        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .Default, handler: { (action: UIAlertAction!) in
            //println("Handle Cancel Logic here")
        }))
        
        presentViewController(refreshAlert, animated: true, completion: nil)
        
    }
    
    @IBAction func AlertDialog(sender: AnyObject) {
        
        
    }
    
    
    override func viewDidAppear(animated: Bool) {
        self.navigationController?.navigationBar.topItem?.title = "Solicitar Asistencia"
        
        
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
    
        let isMotorista:Int? = prefs.integerForKey("ISMOTORISTA") as Int
        
        if (isLoggedIn == 0 && isMotorista == 1)  {
            self.performSegueWithIdentifier("gotoMotorista", sender: self)
        }
        
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        
        
        
        if (segue.identifier == "gotoLogin") {
            let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
            prefs.setObject("", forKey: "USERNAME")
            prefs.setInteger(1, forKey: "ISLOGGEDIN")
            prefs.synchronize()
            
            
        }
        
        if (segue.identifier == "gotoMotorista") {
            let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
            
        let svc = segue.destinationViewController as! TableViewControllerGestiones;
        var arrayOfObjectsUnarchivedData = prefs.dataForKey(Constantes.arrayOfXmlGestionesName)!
        svc.arrayOfXmlGestiones = NSKeyedUnarchiver.unarchiveObjectWithData(arrayOfObjectsUnarchivedData) as! [XmlGestiones]
            
        
        }
    }
    
    
}


extension ViewControllerPanic: CLLocationManagerDelegate,NSURLConnectionDelegate {
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        for location in locations {
            
            strLattitud = String(format:"%.7f", location.coordinate.latitude)
            strLongitud = String(format:"%.7f", location.coordinate.longitude)
            
        }
    }
}
