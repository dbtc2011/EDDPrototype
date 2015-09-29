//
//  ZoningXMLParser.swift
//  SURS
//
//  Created by IOSUSER006 on 10/27/14.
//  Copyright (c) 2014 Dev-Touch. All rights reserved.
//

import UIKit
import Foundation


protocol ZoningParserDelegate {
    
    
    func zoningParser (parser: ZoningXMLParser, contents: NSMutableArray)
    func zoningParserFailed (parser: ZoningXMLParser)
    
}

class ZoningXMLParser: NSObject, NSXMLParserDelegate {
    
    var stringXMLPath: NSString?
    var stringNode: NSString?
    var isContent = false
    var isSlideShow = false
    
    var mutableString: NSMutableString = ""
    
    var delegate: ZoningParserDelegate?
    
    
    var arrayContents: NSMutableArray = NSMutableArray()
    
    override init() {

        super.init()
        self.stringNode = nil
        
    }
    
    func parseXML(xmlPath: NSString) {
        
        self.stringXMLPath = xmlPath
        var parser = NSXMLParser(contentsOfURL: NSURL(fileURLWithPath: self.stringXMLPath! as String))
        parser?.delegate = self
//        parser.parse()
        var success:Bool = parser!.parse()
        
    
        println("Start PARSING")
        if success {
            self.delegate?.zoningParser(self, contents: self.arrayContents)
        }else {
            println("Failed to parse XML")
            self.delegate?.zoningParserFailed(self)
        }
        
    }
    
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [NSObject : AnyObject]) {
        
        println("element name \(elementName)\ncontents \(attributeDict)")
        self.stringNode = elementName
        self.mutableString = ""
        if elementName.rangeOfString("Page") != nil {
            self.isContent = true
            
            
            var arrayPage = [] as NSMutableArray
            var dictionaryPage = ["page": elementName,
                                  "content": arrayPage] as NSMutableDictionary
            self.arrayContents.addObject(dictionaryPage)
            
            
        }else if elementName == "video" {
            
            var dictionaryPage = self.arrayContents.lastObject as! NSMutableDictionary
            
            var arrayPage = dictionaryPage["content"] as! NSMutableArray
            
            var dictionaryContent = NSMutableDictionary(dictionary: attributeDict, copyItems: true)
            dictionaryContent.setObject(elementName, forKey: "type")
            
            arrayPage.addObject(dictionaryContent)
            
            dictionaryPage.setObject(arrayPage, forKey: "content")
            
            self.arrayContents.replaceObjectAtIndex(self.arrayContents.count-1, withObject: dictionaryPage)
            
        }else if elementName == "audio" {
            
            var dictionaryPage = self.arrayContents.lastObject as! NSMutableDictionary
            
            var arrayPage = dictionaryPage["content"] as! NSMutableArray
            
            var dictionaryContent = NSMutableDictionary(dictionary: attributeDict, copyItems: true)
            dictionaryContent.setObject(elementName, forKey: "type")
            
            arrayPage.addObject(dictionaryContent)
            
            dictionaryPage.setObject(arrayPage, forKey: "content")
            
            self.arrayContents.replaceObjectAtIndex(self.arrayContents.count-1, withObject: dictionaryPage)
            
        }else if elementName == "slideshow" {
            
            var dictionaryPage = self.arrayContents.lastObject as! NSMutableDictionary
            
            var arrayPage = dictionaryPage["content"] as! NSMutableArray
            
            var arrayImages = [] as NSMutableArray
            
            var dictionaryContent = NSMutableDictionary(dictionary: attributeDict, copyItems: true)
            dictionaryContent.setObject(elementName, forKey: "type")
            dictionaryContent.setObject(arrayImages, forKey: "images")
            
            arrayPage.addObject(dictionaryContent)
            
            dictionaryPage.setObject(arrayPage, forKey: "content")
            
            self.arrayContents.replaceObjectAtIndex(self.arrayContents.count-1, withObject: dictionaryPage)
            
            
        }else if elementName == "img" {
            var dictionaryPage = self.arrayContents.lastObject as! NSMutableDictionary
            
            var arrayPage : NSMutableArray = dictionaryPage["content"] as! NSMutableArray
            
            var dictionaryContent = arrayPage.lastObject as! NSMutableDictionary
            
            var arrayImages = dictionaryContent["images"] as! NSMutableArray
            
            let name: NSString = "Image\(arrayImages.count+1)"
            var dictionaryImage = NSMutableDictionary(dictionary: attributeDict, copyItems: true)
            dictionaryImage.setObject(name, forKey: "title")
    
            arrayImages.addObject(dictionaryImage)
            
            dictionaryContent.setObject(arrayImages, forKey: "images")
            
            dictionaryPage.setObject(arrayPage, forKey: "content")
            
            self.arrayContents.replaceObjectAtIndex(self.arrayContents.count-1, withObject: dictionaryPage)
        }else if elementName == "image" {
            
            var dictionaryPage = self.arrayContents.lastObject as! NSMutableDictionary
            
            var arrayPage = dictionaryPage["content"] as! NSMutableArray
            
            var dictionaryContent = NSMutableDictionary(dictionary: attributeDict, copyItems: true)
            dictionaryContent.setObject(elementName, forKey: "type")
            
            arrayPage.addObject(dictionaryContent)
            
            dictionaryPage.setObject(arrayPage, forKey: "content")
            
            self.arrayContents.replaceObjectAtIndex(self.arrayContents.count-1, withObject: dictionaryPage)
            
        }else if elementName == "text" {
            
            var dictionaryPage = self.arrayContents.lastObject as! NSMutableDictionary
            
            var arrayPage = dictionaryPage["content"] as! NSMutableArray
            
            var dictionaryContent = NSMutableDictionary(dictionary: attributeDict, copyItems: true)
            dictionaryContent.setObject(elementName, forKey: "type")
            
            arrayPage.addObject(dictionaryContent)
            
            dictionaryPage.setObject(arrayPage, forKey: "content")
            
            self.arrayContents.replaceObjectAtIndex(self.arrayContents.count-1, withObject: dictionaryPage)
            
        }
        
        
    }
    
    func parser(parser: NSXMLParser, foundCharacters string: String?) {
        
        if string == "\n        " {
            
        }else {
            self.mutableString.appendString(string!)
        }
        println("character \(string)")
        
        
        
    }
    
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String!, qualifiedName qName: String!) {
        if elementName == "audio" || elementName == "video" || elementName == "image" {
            
            var dictionaryPage = self.arrayContents.lastObject as! NSMutableDictionary
            
            var arrayPage = dictionaryPage["content"] as! NSMutableArray
            
            var dictionaryContent = arrayPage.lastObject as! NSMutableDictionary
            dictionaryContent.setObject(self.mutableString, forKey: "title")
            
            arrayPage.replaceObjectAtIndex(arrayPage.count-1, withObject: dictionaryContent)
            
            dictionaryPage.setObject(arrayPage, forKey: "content")
            
            self.arrayContents.replaceObjectAtIndex(self.arrayContents.count-1, withObject: dictionaryPage)
            
        }else if elementName == "text" {
            var dictionaryPage = self.arrayContents.lastObject as! NSMutableDictionary
            
            var arrayPage = dictionaryPage["content"] as! NSMutableArray
            
            var dictionaryContent = arrayPage.lastObject as! NSMutableDictionary
            dictionaryContent.setObject(self.mutableString, forKey: "value")
            
            arrayPage.replaceObjectAtIndex(arrayPage.count-1, withObject: dictionaryContent)
            
            dictionaryPage.setObject(arrayPage, forKey: "content")
            
            self.arrayContents.replaceObjectAtIndex(self.arrayContents.count-1, withObject: dictionaryPage)
        }
        
        
    }
    

    

    
    
    
}
