//
//  ViewControllerMap.swift
//  ficohsaseguros
//
//  Created by mac on 24/10/15.
//  Copyright © 2015 SoftwareFactoryHN. All rights reserved.
//

import Foundation
import MapKit


class ViewControllerMap: UIViewController,NSURLConnectionDelegate, NSXMLParserDelegate,MKMapViewDelegate  {
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var Open: UIBarButtonItem!
    //@IBOutlet weak var Open: UIBarButtonItem!
    
    var mutableData:NSMutableData  = NSMutableData()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Open.target = self.revealViewController()
        Open.action = Selector("revealToggle:")
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.mapView.delegate = self
        
        
        ModelStructParser.arrayOfXmlLocalizacionToken = [XmlLocalizacionToken]()
        ModelStructParser.arrayOfXmlCoordenadas = [XmlCoordenadas]()
        
        /*let post:NSString = "<tem:fecha_inicio>2015-10-29 16:00:01</tem:fecha_inicio><tem:fecha_fin>2015-10-29 18:00:01</tem:fecha_fin>"
        let soapMessage1 = "<?xml version='1.0' encoding='utf-8'?><soapenv:Envelope xmlns:soapenv='http://schemas.xmlsoap.org/soap/envelope/' xmlns:tem='http://tempuri.org/'><soapenv:Header/><soapenv:Body><tem:seleccionarCoordenada>\(post)</tem:seleccionarCoordenada></soapenv:Body></soapenv:Envelope>"
        let urlString = "http://lordkortex-001-site1.smarterasp.net/pediasureService.asmx"*/
    
        
        let post:NSString = "<tem:pToken>abcd12015</tem:pToken>"
        let soapMessage1 = "<?xml version='1.0' encoding='utf-8'?><soapenv:Envelope xmlns:soapenv='http://www.w3.org/2003/05/soap-envelope' xmlns:tem='http://tempuri.org/'><soapenv:Header/><soapenv:Body><tem:getLocation>\(post)</tem:getLocation></soapenv:Body></soapenv:Envelope>"
        let urlString = "http://hdavid87-001-site1.btempurl.com/WebServices/wsFicohsaApp.asmx"
        
        
        let url = NSURL(string: urlString)
        
        let theRequest = NSMutableURLRequest(URL: url!)
        
        let msgLength = String(soapMessage1.characters.count)
        
        NSLog("PostData: %@",soapMessage1);
        
        theRequest.addValue("text/xml; charset=utf-8", forHTTPHeaderField: "Content-Type")
        theRequest.addValue(msgLength, forHTTPHeaderField: "Content-Length")
        theRequest.HTTPMethod = "POST"
        theRequest.HTTPBody = soapMessage1.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false) // or false
        
        let connection = NSURLConnection(request: theRequest, delegate: self, startImmediately: true)
        connection?.start();
        
        
        if (connection == true) {
            var mutableData : Void = NSMutableData.initialize()
        }

        
    }
    
    func mapView(mapView: MKMapView!, rendererForOverlay overlay: MKOverlay!) -> MKOverlayRenderer! {
        if !overlay.isKindOfClass(MKPolyline) {
            return nil
        }
        
        let polyline = overlay as! MKPolyline
        let renderer = MKPolylineRenderer(polyline: polyline)
        renderer.strokeColor = UIColor.blackColor()
        renderer.lineWidth = 3
        return renderer
    }
    
    
    func polyline(arrayOfXmlCoordenadas: [XmlCoordenadas]) -> MKPolyline {
        var coords = [CLLocationCoordinate2D]()
        var locations: [CLLocationCoordinate2D]
        
        for coordenada: XmlCoordenadas in arrayOfXmlCoordenadas {
            let myDoublex = Double(coordenada.coorY)
            let myDoubley = Double(coordenada.coorX)
            var point = CLLocationCoordinate2DMake(myDoublex!, myDoubley!);
            coords.append(point)
            
        }
        
        return MKPolyline(coordinates: &coords, count: coords.count)
    }
    
    
   
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // NSURL
    func connection(connection: NSURLConnection!, didReceiveResponse response: NSURLResponse!) {
        mutableData.length = 0;
    }
    
    func connection(connection: NSURLConnection!, didReceiveData data: NSData!) {
        mutableData.appendData(data)
    }
    
    
    func connectionDidFinishLoading(connection: NSURLConnection!) {
        let xmlParser = NSXMLParser(data: mutableData)
        xmlParser.delegate = self
        xmlParser.parse()
        xmlParser.shouldResolveExternalEntities = true
        //NSLog("finish ==> %@", element);
        
        
        var myInitialPoint = CLLocationCoordinate2DMake(0, 0);
        
        for itemLocalizacionToken: XmlLocalizacionToken in ModelStructParser.arrayOfXmlLocalizacionToken {
            var contador = 0
            
            for coordenada: XmlCoordenadas in itemLocalizacionToken.arrayOfXmlCoordenada {
                
                let myInitialDoublex = Double(coordenada.coorY)
                let myInitialDoubley = Double(coordenada.coorX)
            
            
                let myDoublex = Double(coordenada.coorY)
                let myDoubley = Double(coordenada.coorX)
                var point = CLLocationCoordinate2DMake(myDoublex!, myDoubley!);
                myInitialPoint = point
            
                if(contador == 0 ){
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = point
                    annotation.title = "Asistencia: " //+ coordenada.coorY + "  "  + coordenada.coorX
                    annotation.subtitle = "La ayuda va en camino"
                    mapView.addAnnotation(annotation)
                    contador++
                }
            
            
            }
        
            let annotation = MKPointAnnotation()
            annotation.coordinate = myInitialPoint
            annotation.title = "Asistencia"
            annotation.subtitle = "Vamos por aqui !!"
            mapView.addAnnotation(annotation)
            
        }
        
        
        for itemLocalizacionToken: XmlLocalizacionToken in ModelStructParser.arrayOfXmlLocalizacionToken {
              mapView.addOverlay(polyline(itemLocalizacionToken.arrayOfXmlCoordenada))
            
        }

        
        UIView.animateWithDuration(1.5, animations: { () -> Void in
            let span = MKCoordinateSpanMake(0.01, 0.01)
            
            let region1 = MKCoordinateRegion(center: myInitialPoint, span: span)
            self.mapView.setRegion(region1, animated: true)
        })
        
        
        

        
               
        
    }
    
    func parser(parser: NSXMLParser,didStartElement elementName: String,namespaceURI namespaceURI: String?,qualifiedName qName: String?, attributes attributeDict: [String : String])  {
        let name : NSString = elementName as NSString
        ModelParser().initializeElement(name)
    }
    
    func parser(parser: NSXMLParser!, foundCharacters string: String!) {
        ModelParser().foundCharacters(string)
        
    }
    
    func parser(parser: NSXMLParser!, didEndElement elementName: String!, namespaceURI: String!, qualifiedName qName: String!)
    {
        ModelParser().endElement(elementName)
        
    }

    
    
}