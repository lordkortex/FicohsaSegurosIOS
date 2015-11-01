//
//  ViewControllerLogin.swift
//  ficohsaseguros
//
//  Created by mac on 18/10/15.
//  Copyright © 2015 SoftwareFactoryHN. All rights reserved.
//

import UIKit

class ViewControllerLogin: UIViewController, NSURLConnectionDelegate, NSXMLParserDelegate, UITextFieldDelegate {
    
    
    @IBOutlet weak var TextViewPassword: UITextField!
    @IBOutlet weak var ProgressLogin: UIProgressView!
    
    var contador:Int = 0 {
        didSet {
            let fractionalProgress = Float(contador) / 100.0
            let animated = contador != 0
            
            ProgressLogin.setProgress(fractionalProgress, animated: animated)
        }
    }
    var mutableData:NSMutableData  = NSMutableData()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.TextViewPassword.delegate = self
        self.TextViewPassword.returnKeyType = UIReturnKeyType.Done
        ProgressLogin.setProgress(0, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func login(sender: AnyObject) {
        
        let password:NSString = "abcd12015"//TextViewPassword.text!
        
        if (password.isEqualToString("") ) {
            
            let alertView:UIAlertView = UIAlertView()
            alertView.title = "Sign in Failed!"
            alertView.message = "Please enter Token"
            alertView.delegate = self
            alertView.addButtonWithTitle("OK")
            alertView.show()
            
        } else {
            
            UIApplication.sharedApplication().networkActivityIndicatorVisible = true
            
            self.contador = 30;
            let fractionalProgress = Float(self.contador) / 100.0
            ProgressLogin.setProgress(fractionalProgress, animated: true)
            
            for i in 0..<100 {
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), {
                    sleep(1)
                    dispatch_async(dispatch_get_main_queue(), {
                        self.contador++
                        if self.contador == 90{
                            self.contador = 0
                        }
                        return
                    })
                })
            }
            
            ModelStructParser.arrayOfXmlAsegurados  = [XmlAsegurado]()
            ModelStructParser.arrayOfXmlTokenLoginresult = [XmlTokenLoginResult]()
            ModelStructParser.arrayOfXmlGestiones = [XmlGestiones]()
            
            
            
            let post:NSString = "<tem:pToken>\(password)</tem:pToken><tem:pTokenMovilAndroid>\(password)</tem:pTokenMovilAndroid><tem:pTokenMoviliOs>\(password)</tem:pTokenMoviliOs>"
            
            
            
            let soapMessage1 = "<?xml version='1.0' encoding='utf-8'?><soapenv:Envelope xmlns:soapenv='http://schemas.xmlsoap.org/soap/envelope/' xmlns:tem='http://tempuri.org/'><soapenv:Header/><soapenv:Body><tem:tokenLogin>\(post)</tem:tokenLogin></soapenv:Body></soapenv:Envelope>"
            
            
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
        
        
    }
    
    func textFieldShouldReturn(userText: UITextField!) -> Bool {
        userText.resignFirstResponder()
        return true;
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        
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
        
        let success:NSInteger = 1 as NSInteger
        
        //[jsonData[@"success"] integerValue];
        
        
        NSLog("Success: %ld", success);
        
        if ModelStructParser.arrayOfXmlAsegurados.count > 0 {
            
            NSLog("Login SUCCESS");
            
            let password:NSString = TextViewPassword.text!
            let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
            prefs.setObject("", forKey: "USERNAME")
            prefs.setInteger(0, forKey: "ISLOGGEDIN")
            
            var EsAsegurado = ModelStructParser.arrayOfXmlTokenLoginresult[0].EsAsegurado
            if(EsAsegurado == "false"){
                prefs.setInteger(1, forKey: "ISMOTORISTA")
            }else{
                prefs.setInteger(0, forKey: "ISMOTORISTA")
            }
            prefs.synchronize()
            
            let dictionaryPassword: NSDictionary = [Constantes.password:password]
            
            NSUserDefaults.standardUserDefaults().setObject(dictionaryPassword, forKey: Constantes.password)
            NSUserDefaults.standardUserDefaults().synchronize()
            prefs.setInteger(0, forKey: "ISLOGGEDIN")
            prefs.synchronize()
            
            
            var arrayOfObjectsData = NSKeyedArchiver.archivedDataWithRootObject(ModelStructParser.arrayOfXmlAsegurados)
            prefs.setObject(arrayOfObjectsData, forKey: Constantes.arrayOfXmlAseguradosName)
            
            arrayOfObjectsData = NSKeyedArchiver.archivedDataWithRootObject(ModelStructParser.arrayOfXmlTokenLoginresult)
            prefs.setObject(arrayOfObjectsData, forKey: Constantes.arrayOfXmlTokenLoginName)
   
            arrayOfObjectsData = NSKeyedArchiver.archivedDataWithRootObject(ModelStructParser.arrayOfXmlGestiones)
            prefs.setObject(arrayOfObjectsData, forKey: Constantes.arrayOfXmlGestionesName)
   
            self.dismissViewControllerAnimated(true, completion: nil)
        } else {
            
            let alertView:UIAlertView = UIAlertView()
            alertView.title = "Sign in Failed!"
            alertView.message = "Error"
            alertView.delegate = self
            alertView.addButtonWithTitle("OK")
            alertView.show()
            
        }
        
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        
        
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