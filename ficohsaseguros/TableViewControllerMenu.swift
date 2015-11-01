//
//  TableViewControllerMenu.swift
//  ficohsaseguros
//
//  Created by mac on 18/10/15.
//  Copyright © 2015 SoftwareFactoryHN. All rights reserved.
//

import Foundation


class TableViewControllerMenu: UITableViewController {
    
    var TableArray = [String]()
    
    override func viewDidLoad() {
        
        let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        let isMotorista:Int? = prefs.integerForKey("ISMOTORISTA") as Int
        TableArray = [String]()

        if (isMotorista == 1)  {
            TableArray = ["Cerrar Sesion"]
        }else{
            TableArray = ["Solicitar Asistencia","Ubicacion Asistencia","Notificaciones","Consultas Generales","Cerrar Sesion"]
        }
        tableView.reloadData()
        
        

    }
    override func viewDidAppear(animated: Bool) {
       
        let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        let isMotorista:Int? = prefs.integerForKey("ISMOTORISTA") as Int
        TableArray = [String]()

        if (isMotorista == 1)  {
            TableArray = ["Cerrar Sesion"]
        }else{
            TableArray = ["Solicitar Asistencia","Ubicacion Asistencia","Notificaciones","Consultas Generales","Cerrar Sesion"]
        }
        tableView.reloadData()
        

        
    }

    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TableArray.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier(TableArray[indexPath.row],forIndexPath:indexPath) as UITableViewCell
        
        cell.textLabel?.text = TableArray[indexPath.row]
        
        return cell
        
    }
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        
        if (segue.identifier == "gotoLogout") {
            let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
            prefs.setObject("", forKey: "USERNAME")
            prefs.setInteger(1, forKey: "ISLOGGEDIN")
            prefs.synchronize()
            
        }
    }

    
}
