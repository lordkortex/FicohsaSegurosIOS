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
    
    let basicCellIdentifier = "BasicCell"
    let imageCellIdentifier = "ImageCell"

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        
        
        Open.target = self.revealViewController()
        Open.action = Selector("revealToggle:")
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        
        var not1 = XmlNotificaciones(notificacion_fecha: "10/10/2015", notificacion_mensaje: "Ficohsa Seguros te informa que la ayuda va en camino.")
        var not2 = XmlNotificaciones(notificacion_fecha: "11/10/2015", notificacion_mensaje: "Ficohsa los mejores en Pensiones y Cesantias. Prieba de textos mas largos e intercalados con imagenes extensas provisionales")
        var not3 = XmlNotificaciones(notificacion_fecha: "12/10/2015", notificacion_mensaje: "Ambulancia Ficohsa")
        var not4 = XmlNotificaciones(notificacion_fecha: "13/10/2015", notificacion_mensaje: "La informacion de la busqueda ha sido exitosa. En unos momentos llegaremos a tu ubicacion para apoyarte con assitencia medica o tecnica. Recuerda contactarnos a nuestros numeros telefonicos y tener a mano tu credencial del seguro. Este es un texto mas largo de ejemplo.")
        arrayOfXmlNotificaciones.append(not1)
        arrayOfXmlNotificaciones.append(not2)
        arrayOfXmlNotificaciones.append(not3)
        arrayOfXmlNotificaciones.append(not4)
        arrayOfXmlNotificaciones.append(not1)
        arrayOfXmlNotificaciones.append(not2)
        arrayOfXmlNotificaciones.append(not2)
        arrayOfXmlNotificaciones.append(not3)
        arrayOfXmlNotificaciones.append(not1)
        
        
    }
    
    
    override func viewDidAppear(animated: Bool) {
        self.navigationController?.navigationBar.topItem?.title = sesionFechaP as String
        //var color: UIColor = UIColor(red: 62/255, green: 93/255, blue: 132/255, alpha: 1.0)
        //self.navigationController?.navigationBar.barTintColor = color
        //let titleDict: NSDictionary = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        //self.navigationController?.navigationBar.titleTextAttributes = titleDict as NSObject
        //self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.topItem?.title = "Notificaciones"
        
        
        
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
        
        let notificacion = arrayOfXmlNotificaciones[indexPath.row]
        
        //setImageForCell(cell, indexPath: indexPath)
        cell.titleLabel.text =  notificacion.notificacion_fecha
        cell.subtitleLabel.text =  notificacion.notificacion_mensaje
        
        return cell
    }

    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    }
    
       
    
}



