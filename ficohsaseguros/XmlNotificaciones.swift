//
//  XmlNotificaciones.swift
//  ficohsaseguros
//
//  Created by mac on 18/10/15.
//  Copyright © 2015 SoftwareFactoryHN. All rights reserved.
//

import Foundation

class XmlNotificaciones : NSObject, NSCoding {
    
    var notificacion_fecha = ""
    var notificacion_mensaje = ""
    
    init(notificacion_fecha : String,notificacion_mensaje : String){
        
        self.notificacion_fecha = notificacion_fecha
        self.notificacion_mensaje = notificacion_mensaje
        
    }
    
    
    required init?(coder decoder: NSCoder) {
        self.notificacion_fecha = decoder.decodeObjectForKey("notificacion_fecha") as! String
        self.notificacion_mensaje = decoder.decodeObjectForKey("notificacion_mensaje") as! String
        
        super.init()
    }
    
    func encodeWithCoder(coder: NSCoder) {
        coder.encodeObject(self.notificacion_fecha, forKey: "notificacion_fecha")
        coder.encodeObject(self.notificacion_mensaje, forKey: "notificacion_mensaje")
        
    }
    
    
    
}


