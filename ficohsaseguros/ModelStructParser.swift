//
//  ModelStructParser.swift
//  ficohsaseguros
//
//  Created by mac on 31/10/15.
//  Copyright © 2015 SoftwareFactoryHN. All rights reserved.
//

import Foundation


struct ModelStructParser {
    
    static var elements = NSMutableDictionary()
    static var element = NSString()
    static var actualElement = NSString()
    
    static var arrayOfXmlTokenLoginresult :[XmlTokenLoginResult] = [XmlTokenLoginResult]()
    static var EsAsegurado = NSMutableString()
    static var snActivo = NSMutableString()
    static var strError = NSMutableString()

    static var arrayOfXmlAsegurados :[XmlAsegurado] = [XmlAsegurado]()
    static var ramo = NSMutableString()
    static var sucursal = NSMutableString()
    static var estado = NSMutableString()
    static var anio = NSMutableString()
    static var contratante = NSMutableString()

    static var arrayOfXmlGestiones:[XmlGestiones] = [XmlGestiones]()
    static var id_gestion = NSMutableString()
    static var id_item = NSMutableString()
    static var fec_evento = NSMutableString()
    static var txt_obs = NSMutableString()
    static var latitud = NSMutableString()
    static var longitud = NSMutableString()
    
    static var arrayOfXmlLocalizacionToken :[XmlLocalizacionToken] = [XmlLocalizacionToken]()
    static var txt_nombre = NSMutableString()
    
    
    static var arrayOfXmlCoordenadas :[XmlCoordenadas] = [XmlCoordenadas]()
    static var coorX = NSMutableString()
    static var coorY = NSMutableString()
 
    
    
}

