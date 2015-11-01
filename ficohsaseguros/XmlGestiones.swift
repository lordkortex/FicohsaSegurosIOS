//
//  XmlGestiones.swift
//  ficohsaseguros
//
//  Created by mac on 31/10/15.
//  Copyright © 2015 SoftwareFactoryHN. All rights reserved.
//

import Foundation

class XmlGestiones : NSObject, NSCoding {
    
    var id_gestion = ""
    var id_item = ""
    var fec_evento = ""
    var txt_obs = ""
    var latitud = ""
    var longitud = ""
    
    
    init(id_gestion : String,id_item : String,fec_evento : String,txt_obs : String,latitud : String,longitud : String){
        
        self.id_gestion = id_gestion
        self.id_item = id_item
        self.fec_evento = fec_evento
        self.txt_obs = txt_obs
        self.latitud = latitud
        self.longitud = longitud
        
    }
    
    
    required init?(coder decoder: NSCoder) {
        self.id_gestion = decoder.decodeObjectForKey("id_gestion") as! String
        self.id_item = decoder.decodeObjectForKey("id_item") as! String
        self.fec_evento = decoder.decodeObjectForKey("fec_evento") as! String
        self.txt_obs = decoder.decodeObjectForKey("txt_obs") as! String
        self.latitud = decoder.decodeObjectForKey("latitud") as! String
        self.longitud = decoder.decodeObjectForKey("longitud") as! String
        
        super.init()
    }
    
    func encodeWithCoder(coder: NSCoder) {
        coder.encodeObject(self.id_gestion, forKey: "id_gestion")
        coder.encodeObject(self.id_item, forKey: "id_item")
        coder.encodeObject(self.fec_evento, forKey: "fec_evento")
        coder.encodeObject(self.txt_obs, forKey: "txt_obs")
        coder.encodeObject(self.latitud, forKey: "latitud")
        coder.encodeObject(self.longitud, forKey: "longitud")
        
    }
    
    
    
}
