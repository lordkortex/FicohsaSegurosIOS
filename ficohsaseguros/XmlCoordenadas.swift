//
//  XmlCoordenadas.swift
//  ficohsaseguros
//
//  Created by mac on 31/10/15.
//  Copyright © 2015 SoftwareFactoryHN. All rights reserved.
//

import Foundation

class XmlCoordenadas : NSObject, NSCoding {
    
    var coorX = ""
    var coorY = ""
    
    
    
    init(coorX : String,coorY : String){
        
        self.coorX = coorX
        self.coorY = coorY
        
    }
    
    
    required init?(coder decoder: NSCoder) {
        self.coorX = decoder.decodeObjectForKey("coorX") as! String
        self.coorY = decoder.decodeObjectForKey("coorY") as! String
        super.init()
    }
    
    func encodeWithCoder(coder: NSCoder) {
        coder.encodeObject(self.coorX, forKey: "coorX")
        coder.encodeObject(self.coorY, forKey: "coorY")
        
    }
    
    
    
}
