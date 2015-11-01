//
//  ViewControllerRun.swift
//  ficohsaseguros
//
//  Created by mac on 30/10/15.
//  Copyright © 2015 SoftwareFactoryHN. All rights reserved.
//

import UIKit
import CoreData
import CoreLocation
import HealthKit
import MapKit

let DetailSegueName = "RunDetails"

class ViewControllerRun: UIViewController {
    var managedObjectContext: NSManagedObjectContext?
    
    var XmlGestion :[XmlGestiones] = [XmlGestiones]()
     
    
    var seconds = 0.0
    var distance = 0.0
    @IBOutlet weak var label3: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label1: UILabel!
    
    lazy var locationManager: CLLocationManager = {
        var _locationManager = CLLocationManager()
        _locationManager.delegate = self
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest
        _locationManager.activityType = .Fitness
        
        // Movement threshold for new events
        _locationManager.distanceFilter = 10.0
        return _locationManager
        }()
    
    //lazy var locations = [CLLocation]()
    lazy var timer = NSTimer()
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        //startButton.hidden = false
        //promptLabel.hidden = false
        
        locationManager.requestAlwaysAuthorization()
        
    } 
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        timer.invalidate()
    }
    
    func eachSecond(timer: NSTimer) {
        seconds++
        let secondsQuantity = HKQuantity(unit: HKUnit.secondUnit(), doubleValue: seconds)
        label1.text = "Time: " + secondsQuantity.description
        //let distanceQuantity = HKQuantity(unit: HKUnit.meterUnit(), doubleValue: distance)
        //distanceLabel.text = "Distance: " + distanceQuantity.description
        
        //let paceUnit = HKUnit.secondUnit().unitDividedByUnit(HKUnit.meterUnit())
        //let paceQuantity = HKQuantity(unit: paceUnit, doubleValue: seconds / distance)
        //paceLabel.text = "Pace: " + paceQuantity.description
    }
    
    
    @IBAction func DetenerTracking(sender: AnyObject) {
        seconds = 0.0
        distance = 0.0
        timer.invalidate()
        locationManager.stopUpdatingLocation();
        
        label1.text =  "Time: "
        label2.text =  "c: "
        label3.text =  "c: "
        
        
        /*let actionSheet = UIActionSheet(title: "Run Stopped", delegate: self, cancelButtonTitle: "Cancel", destructiveButtonTitle: nil, otherButtonTitles: "Save", "Discard")
        actionSheet.actionSheetStyle = .Default
        actionSheet.showInView(view)*/
        
    }
    
    @IBAction func empezarTracking(sender: AnyObject) {
   
        seconds = 0.0
        distance = 0.0
        //locations.removeAll(keepCapacity: false)
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "eachSecond:", userInfo: nil, repeats: true)
        locationManager.startUpdatingLocation()
        
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
       
    }
}

// MARK: - MKMapViewDelegate
extension ViewControllerRun: MKMapViewDelegate {
    func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer! {
        if !overlay.isKindOfClass(MKPolyline) {
            return nil
        }
        
        let polyline = overlay as! MKPolyline
        let renderer = MKPolylineRenderer(polyline: polyline)
        renderer.strokeColor = UIColor.blueColor()
        renderer.lineWidth = 3
        return renderer
    }
}

// MARK: - CLLocationManagerDelegate
extension ViewControllerRun: CLLocationManagerDelegate,NSURLConnectionDelegate {
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        for location in locations {
            let howRecent = location.timestamp.timeIntervalSinceNow
            
            let password = (NSUserDefaults.standardUserDefaults().objectForKey(Constantes.password)) as! NSDictionary
            let passwordText:NSString = password.valueForKey(Constantes.password) as! NSString

            
             NSLog("Latitude ==> %ld", location.coordinate.latitude);
             NSLog("Longitud ==> %ld", location.coordinate.longitude);
            
            var strLattitud:String = String(format:"%.7f", location.coordinate.latitude)
            var strLongitud:String = String(format:"%.7f", location.coordinate.longitude)
            var idGestion:String = XmlGestion[0].id_gestion
            
            
            label2.text =  "c: \(strLattitud)"
            label3.text =  "c: \(strLongitud)"
            
            
            /*let post:NSString = "<tem:coorX>\(strLattitud)</tem:coorX><tem:coorY>\(strLongitud)</tem:coorY>"
            let soapMessage1 = "<?xml version='1.0' encoding='utf-8'?><soapenv:Envelope xmlns:soapenv='http://schemas.xmlsoap.org/soap/envelope/' xmlns:tem='http://tempuri.org/'><soapenv:Header/><soapenv:Body><tem:insertarCoordenada>\(post)</tem:insertarCoordenada></soapenv:Body></soapenv:Envelope>"
            let urlString = "http://lordkortex-001-site1.smarterasp.net/pediasureService.asmx"*/
            
            
            
            let post:NSString = "<tem:pToken>\(passwordText)</tem:pToken><tem:pIdGestion>\(idGestion)</tem:pIdGestion><tem:pIdAsistencia>0</tem:pIdAsistencia><tem:pLongitud>\(strLattitud)</tem:pLongitud><tem:pLatitud>\(strLongitud)</tem:pLatitud>"
            
            let soapMessage1 = "<?xml version='1.0' encoding='utf-8'?><soapenv:Envelope xmlns:soapenv='http://schemas.xmlsoap.org/soap/envelope/' xmlns:tem='http://tempuri.org/'><soapenv:Header/><soapenv:Body><tem:setLocation>\(post)</tem:setLocation></soapenv:Body></soapenv:Envelope>"
            
            
            let urlString = "http://hdavid87-001-site1.btempurl.com/WebServices/wsFicohsaApp.asmx"
            
            let url = NSURL(string: urlString)
            
            let theRequest = NSMutableURLRequest(URL: url!)
            
            let msgLength = String(soapMessage1.characters.count)
            
            NSLog("PostData: %@",soapMessage1);
            
            theRequest.addValue("text/xml; charset=utf-8", forHTTPHeaderField: "Content-Type")
            theRequest.addValue(msgLength, forHTTPHeaderField: "Content-Length")
            theRequest.HTTPMethod = "POST"
            theRequest.HTTPBody = soapMessage1.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false) // or false
            
            let connection = NSURLConnection(request: theRequest, delegate: self, startImmediately: true)
            connection?.start();
            
            
            if (connection == true) {
                NSLog("Data Saved: %@",soapMessage1);
            }


        }
        
        
        
        
    }
}


