//
//  TableViewControllerNotificaciones.swift
//  ficohsaseguros
//
//  Created by mac on 18/10/15.
//  Copyright © 2015 SoftwareFactoryHN. All rights reserved.
//

import UIKit

class TableViewControllerNotificaciones: UITableViewController {
    
    @IBOutlet weak var Open: UIBarButtonItem!
    
    var arrayOfXmlNotificaciones:[XmlNotificaciones] = [XmlNotificaciones]()
    var mutableData:NSMutableData  = NSMutableData.init()
    var sesionFechaP = NSString()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.estimatedRowHeight = 300
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        
        Open.target = self.revealViewController()
        Open.action = Selector("revealToggle:")
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        
        var not1 = XmlNotificaciones(notificacion_fecha: "10/10/2015", notificacion_mensaje: "Ficohsa Seguros te informa que la ayuda va en camino.")
        arrayOfXmlNotificaciones.append(not1)
        arrayOfXmlNotificaciones.append(not1)
        arrayOfXmlNotificaciones.append(not1)
        arrayOfXmlNotificaciones.append(not1)
        arrayOfXmlNotificaciones.append(not1)
        arrayOfXmlNotificaciones.append(not1)
        arrayOfXmlNotificaciones.append(not1)
        arrayOfXmlNotificaciones.append(not1)
        arrayOfXmlNotificaciones.append(not1)
        
        
    }
    
    
    override func viewDidAppear(animated: Bool) {
        self.navigationController?.navigationBar.topItem?.title = sesionFechaP as String
        //var color: UIColor = UIColor(red: 62/255, green: 93/255, blue: 132/255, alpha: 1.0)
        //self.navigationController?.navigationBar.barTintColor = color
        //let titleDict: NSDictionary = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        //self.navigationController?.navigationBar.titleTextAttributes = titleDict as NSObject
        //self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfXmlNotificaciones.count
    }
    
    override func tableView(tableView:UITableView, heightForRowAtIndexPath indexPath:NSIndexPath)->CGFloat
    {
        return 100
        //return UITableViewAutomaticDimension;
        
    }
    
    override func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat{
        
        return UITableViewAutomaticDimension
        
    }
    
    func configureTableView() {
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 160.0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell : TableViewControllerNotificacionesCell = tableView.dequeueReusableCellWithIdentifier("NotificacionCell", forIndexPath: indexPath) as! TableViewControllerNotificacionesCell
        
        let notificacion = arrayOfXmlNotificaciones[indexPath.row]
        
        cell.NotificacionFecha.text = notificacion.notificacion_fecha
        cell.NotificacionDescripcion.text = notificacion.notificacion_mensaje
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    }
    
       
    
}



