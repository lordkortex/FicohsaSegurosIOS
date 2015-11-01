//
//  XmlAsegurado.swift
//  ficohsaseguros
//
//  Created by mac on 31/10/15.
//  Copyright © 2015 SoftwareFactoryHN. All rights reserved.
//

import Foundation

class XmlAsegurado : NSObject, NSCoding {
    
    var ramo = ""
    var sucursal = ""
    var anio = ""
    var estado = ""
    var contratante = ""
    
    init(ramo : String,sucursal : String,anio : String,estado : String,contratante : String){
        
        self.ramo = ramo
        self.sucursal = sucursal
        self.anio = anio
        self.estado = estado
        self.contratante = contratante
         
    }
    
    
    required init?(coder decoder: NSCoder) {
        self.ramo = decoder.decodeObjectForKey("ramo") as! String
        self.sucursal = decoder.decodeObjectForKey("sucursal") as! String
        self.anio = decoder.decodeObjectForKey("anio") as! String
        self.estado = decoder.decodeObjectForKey("estado") as! String
        self.contratante = decoder.decodeObjectForKey("contratante") as! String
        
        super.init()
    }
    
    func encodeWithCoder(coder: NSCoder) {
        coder.encodeObject(self.ramo, forKey: "ramo")
        coder.encodeObject(self.sucursal, forKey: "sucursal")
        coder.encodeObject(self.anio, forKey: "anio")
        coder.encodeObject(self.estado, forKey: "estado")
        coder.encodeObject(self.contratante, forKey: "contratante")
        
    }
    
    
    
}
