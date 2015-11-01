//
//  XmlLocalizacionToken.swift
//  ficohsaseguros
//
//  Created by mac on 31/10/15.
//  Copyright © 2015 SoftwareFactoryHN. All rights reserved.
//

import Foundation

class XmlLocalizacionToken : NSObject, NSCoding {
    
    var txt_nombre = ""
    var arrayOfXmlCoordenada:[XmlCoordenadas] = [XmlCoordenadas]()
    
    init(txt_nombre : String , arrayOfXmlCoordenada: [XmlCoordenadas]){
        
        self.txt_nombre = txt_nombre
        self.arrayOfXmlCoordenada = arrayOfXmlCoordenada
        
    }
    
    
    required init?(coder decoder: NSCoder) {
        self.txt_nombre = decoder.decodeObjectForKey("txt_nombre") as! String
        super.init()
    }
    
    func encodeWithCoder(coder: NSCoder) {
        coder.encodeObject(self.txt_nombre, forKey: "txt_nombre")
        
    }
    
    
    
}
