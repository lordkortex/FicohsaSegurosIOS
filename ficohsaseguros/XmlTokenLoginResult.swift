//
//  XmlTokenLoginResult.swift
//  ficohsaseguros
//
//  Created by mac on 31/10/15.
//  Copyright © 2015 SoftwareFactoryHN. All rights reserved.
//

import Foundation

class XmlTokenLoginResult : NSObject, NSCoding {
    
    var EsAsegurado = ""
    var snActivo = ""
    var strError = ""
    
    
    
    init(EsAsegurado : String,snActivo : String,strError : String){
        
        self.EsAsegurado = EsAsegurado
        self.snActivo = snActivo
        self.strError = strError
        
    }
    
    
    required init?(coder decoder: NSCoder) {
        self.EsAsegurado = decoder.decodeObjectForKey("EsAsegurado") as! String
        self.snActivo = decoder.decodeObjectForKey("snActivo") as! String
        self.strError = decoder.decodeObjectForKey("strError") as! String
        
        super.init()
    }
    
    func encodeWithCoder(coder: NSCoder) {
        coder.encodeObject(self.EsAsegurado, forKey: "EsAsegurado")
        coder.encodeObject(self.snActivo, forKey: "snActivo")
        coder.encodeObject(self.strError, forKey: "strError")
        
    }
    
    
    
}
