//
//  TableViewControllerNotificacionesMotoristas.swift
//  ficohsaseguros
//
//  Created by mac on 29/10/15.
//  Copyright © 2015 SoftwareFactoryHN. All rights reserved.
//

import UIKit

class TableViewControllerGestiones: UITableViewController {
    
    @IBOutlet weak var Open: UIBarButtonItem!
    
    var arrayOfXmlGestiones:[XmlGestiones] = [XmlGestiones]()
    var mutableData:NSMutableData  = NSMutableData.init()
    var sesionFechaP = NSString()
    
    let basicCellIdentifier = "BasicCell"
    let imageCellIdentifier = "ImageCell"
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        
        Open.target = self.revealViewController()
        Open.action = Selector("revealToggle:")
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
    }
    
    
    
    override func viewDidAppear(animated: Bool) {
        self.navigationController?.navigationBar.topItem?.title = "Getiones"
        
        let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        
        //var color: UIColor = UIColor(red: 62/255, green: 93/255, blue: 132/255, alpha: 1.0)
        
        //self.navigationController?.navigationBar.barTintColor = color
        //let titleDict: NSDictionary = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        //self.navigationController?.navigationBar.titleTextAttributes = titleDict as [NSObject : AnyObject]
        //self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        let isLoggedIn:Int? = prefs.integerForKey("ISLOGGEDIN") as Int
        let isMotorista:Int? = prefs.integerForKey("ISMOTORISTA") as Int
        
        
        if (isLoggedIn != 0 || isLoggedIn == nil || isMotorista == 0 )  {
            self.performSegueWithIdentifier("gotoMenu", sender: self)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        
        let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        let isLoggedIn:Int? = prefs.integerForKey("ISLOGGEDIN") as Int
        
        
        if (segue.identifier == "gotoMenu") {
            let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
            prefs.setObject("", forKey: "USERNAME")
            prefs.setInteger(isLoggedIn!, forKey: "ISLOGGEDIN")
            prefs.synchronize()
            
            
        }
        
        if (segue.identifier == "gotoRunView") {
            let indexPath : NSIndexPath = self.tableView.indexPathForSelectedRow!
            let gestion : XmlGestiones = arrayOfXmlGestiones[indexPath.row]
            let svc = segue.destinationViewController as! ViewControllerRun;
            svc.XmlGestion.append(gestion)
        
        }
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfXmlGestiones.count
    }
    
    
    
    override func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat{
        
        return UITableViewAutomaticDimension
        
    }
    
    func configureTableView() {
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 100.0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        /*let cell : TableViewControllerNotificacionesCell = tableView.dequeueReusableCellWithIdentifier("NotificacionCell", forIndexPath: indexPath) as! TableViewControllerNotificacionesCell
        
        let notificacion = arrayOfXmlNotificaciones[indexPath.row]
        
        cell.NotificacionFecha.text = notificacion.notificacion_fecha
        cell.NotificacionDescripcion.text = notificacion.notificacion_mensaje
        
        return cell*/
        
        return imageCellAtIndexPath(indexPath)
        
    }
    
    func imageCellAtIndexPath(indexPath:NSIndexPath) -> ImageCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier(imageCellIdentifier) as! ImageCell
        
        let gestion = arrayOfXmlGestiones[indexPath.row]
        
        //setImageForCell(cell, indexPath: indexPath)
        cell.titleLabel.text =  gestion.fec_evento
        cell.subtitleLabel.text =  gestion.txt_obs
        
        return cell
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    }
    
    
    
}




