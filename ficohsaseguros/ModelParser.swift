//
//  ModelParser.swift
//  MiradorLegislativoApp
//
//  Created by mac on 31/10/15.
//  Copyright (c) 2015 SoftwareFactoryHN. All rights reserved.
//

import Foundation

class ModelParser {
    
    init() {
        // perform some initialization here
        
    }
    
    
    func initializeElement(elementName: NSString){
        
        ModelStructParser.element = elementName
        
        if (elementName as NSString).isEqualToString("tokenLoginResult")
        {
            
            ModelStructParser.actualElement = elementName
            ModelStructParser.elements = NSMutableDictionary()
            ModelStructParser.elements = [:]
            ModelStructParser.EsAsegurado=""
            ModelStructParser.snActivo=""
            ModelStructParser.strError=""
            
        }

        
        if (elementName as NSString).isEqualToString("asegurado")
        {
            
            ModelStructParser.actualElement = elementName
            ModelStructParser.elements = NSMutableDictionary()
            ModelStructParser.elements = [:]
            ModelStructParser.ramo=""
            ModelStructParser.sucursal=""
            ModelStructParser.estado=""
            ModelStructParser.anio=""
            ModelStructParser.contratante=""
            
        }
        
        
        if (elementName as NSString).isEqualToString("claseGestiones")
        {
            
            ModelStructParser.actualElement = elementName
            ModelStructParser.elements = NSMutableDictionary()
            ModelStructParser.elements = [:]
            ModelStructParser.id_gestion=""
            ModelStructParser.id_item=""
            ModelStructParser.fec_evento=""
            ModelStructParser.txt_obs=""
            ModelStructParser.latitud=""
            ModelStructParser.longitud=""
            
        }
        
        if (elementName as NSString).isEqualToString("asistencias")
        {
            ModelStructParser.actualElement = elementName
            
        }
        
        if (elementName as NSString).isEqualToString("localizacionToken")
        {
            ModelStructParser.actualElement = elementName
            ModelStructParser.elements = NSMutableDictionary()
            ModelStructParser.elements = [:]
            ModelStructParser.txt_nombre=""
            
        }
        

        
        //if (elementName as NSString).isEqualToString("Table")
        if (elementName as NSString).isEqualToString("localizacionPuntos")
        {
            
            ModelStructParser.actualElement = elementName
            ModelStructParser.elements = NSMutableDictionary()
            ModelStructParser.elements = [:]
            ModelStructParser.coorX=""
            ModelStructParser.coorY=""
            
        }
        
        
    }
    
    
    
    func foundCharacters(string: String){
        
        
        //tokenLogin
        
        if ModelStructParser.element.isEqualToString("EsAsegurado") {
            ModelStructParser.EsAsegurado.appendString(string)
        }
        if ModelStructParser.element.isEqualToString("snActivo") {
            ModelStructParser.snActivo.appendString(string)
        }
        if ModelStructParser.element.isEqualToString("strError") {
            ModelStructParser.strError.appendString(string)
        }
        

        
        //asegurado
        
        if ModelStructParser.element.isEqualToString("txt_ramo") {
            ModelStructParser.ramo.appendString(string)
        }
        if ModelStructParser.element.isEqualToString("txt_suc") {
            ModelStructParser.sucursal.appendString(string)
        }
        if ModelStructParser.element.isEqualToString("txt_estado_pol") {
            ModelStructParser.estado.appendString(string)
        }
        if ModelStructParser.element.isEqualToString("anio_pol") {
            ModelStructParser.anio.appendString(string)
        }
        if ModelStructParser.element.isEqualToString("txt_contratante") {
            ModelStructParser.contratante.appendString(string)
        }
        
        
        
        //gestiones
        
        if ModelStructParser.element.isEqualToString("id_gestion") && ModelStructParser.actualElement.isEqualToString("claseGestiones")  {
            ModelStructParser.id_gestion.appendString(string)
        }
        if ModelStructParser.element.isEqualToString("id_item")  && ModelStructParser.actualElement.isEqualToString("claseGestiones") {
            ModelStructParser.id_item.appendString(string)
        }
        if ModelStructParser.element.isEqualToString("fec_evento")  && ModelStructParser.actualElement.isEqualToString("claseGestiones"){
            ModelStructParser.fec_evento.appendString(string)
        }
        if ModelStructParser.element.isEqualToString("txt_obs")  && ModelStructParser.actualElement.isEqualToString("claseGestiones"){
            ModelStructParser.txt_obs.appendString(string)
        }
        if ModelStructParser.element.isEqualToString("latitud")  && ModelStructParser.actualElement.isEqualToString("claseGestiones"){
            ModelStructParser.latitud.appendString(string)
        }
        if ModelStructParser.element.isEqualToString("longitud") && ModelStructParser.actualElement.isEqualToString("claseGestiones") {
            ModelStructParser.longitud.appendString(string)
        }
        
        
        //tokenLogin
        
        if ModelStructParser.element.isEqualToString("coordenadax") {
            ModelStructParser.coorX.appendString(string)
        }
        if ModelStructParser.element.isEqualToString("coordenaday") {
            ModelStructParser.coorY.appendString(string)
        }

        
        // EncabezadoCoordenadas
        if ModelStructParser.element.isEqualToString("txt_nombre") {
            ModelStructParser.txt_nombre.appendString(string)
        }
        
        // Coordenadas
        if ModelStructParser.element.isEqualToString("longitud") {
            ModelStructParser.coorX.appendString(string)
        }
        if ModelStructParser.element.isEqualToString("latitud") {
            ModelStructParser.coorY.appendString(string)
        }


        
    }
    
    
    func endElement(elementName: NSString){
        
        if (elementName as NSString).isEqualToString("tokenLoginResult"){
            
            var tokenLogin = XmlTokenLoginResult(EsAsegurado: ModelStructParser.EsAsegurado as String, snActivo: ModelStructParser.snActivo as String, strError: ModelStructParser.strError as String)
            
            ModelStructParser.arrayOfXmlTokenLoginresult.append(tokenLogin)
        }
        
        
        if (elementName as NSString).isEqualToString("asegurado"){
            
            var asegurado = XmlAsegurado(ramo: ModelStructParser.ramo as String, sucursal: ModelStructParser.sucursal as String, anio: ModelStructParser.anio as String, estado: ModelStructParser.estado as String, contratante: ModelStructParser.contratante as String)
            
            ModelStructParser.arrayOfXmlAsegurados.append(asegurado)
        }

        
        if (elementName as NSString).isEqualToString("claseGestiones"){
            
            var gestion = XmlGestiones(id_gestion: ModelStructParser.id_gestion as String, id_item: ModelStructParser.id_item  as String, fec_evento: ModelStructParser.fec_evento  as String, txt_obs: ModelStructParser.txt_obs  as String, latitud: ModelStructParser.latitud as String, longitud: ModelStructParser.longitud  as String)
            
            ModelStructParser.arrayOfXmlGestiones.append(gestion)
        }
        
        
        if (elementName as NSString).isEqualToString("localizacionToken"){
            
            var localizacionToken = XmlLocalizacionToken(txt_nombre: ModelStructParser.txt_nombre as String , arrayOfXmlCoordenada: ModelStructParser.arrayOfXmlCoordenadas)
            ModelStructParser.arrayOfXmlLocalizacionToken.append(localizacionToken)
            ModelStructParser.arrayOfXmlCoordenadas = [XmlCoordenadas]()
        }
        
        //if (elementName as NSString).isEqualToString("Table"){
        if (elementName as NSString).isEqualToString("localizacionPuntos"){
            
            var coordenada = XmlCoordenadas(coorX: ModelStructParser.coorX as String, coorY: ModelStructParser.coorY as String)
            ModelStructParser.arrayOfXmlCoordenadas.append(coordenada)
        }

    }
    
    
    
    
}

