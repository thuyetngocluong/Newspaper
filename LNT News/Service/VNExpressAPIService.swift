//
//  VNExpressService.swift
//  NewspaperOnline
//
//  Created by Luong Ngoc Thuyet on 05/07/2021.
//  Copyright © 2021 thuyetln. All rights reserved.
//

import UIKit
import Alamofire
import CoreData

typealias FetchDataComplete = (Bool, [ItemVNExpress]) -> Void

class VNExpressAPIService : NSObject {
    
    
    private override init() {}
    
    private var foundChars = ""
    private var title = ""
    private var itemDescription = ""
    private var pubDate = ""
    private var link = ""
    private var guid = ""
    private var comments = ""
    
    private var listItem: [ItemVNExpress] = []
    
    static let shared = VNExpressAPIService()
    
    func fetchData(url: String, completion: @escaping FetchDataComplete) {
        AF.request(url, method: .get)
            .response(queue: DispatchQueue(label: "fetchDataVNExpress")) {
                response in
                if let data = response.data {
                    completion(true, self.encodeXML(data: data))
                } else {
                    completion(false, [])
                }
            }
    }
    
    func encodeXML(data: Data) -> [ItemVNExpress] {
        listItem.removeAll()
        let parser = XMLParser(data: data)
        parser.delegate = self
        parser.parse()
        return listItem
    }
}

extension VNExpressAPIService : XMLParserDelegate {
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        foundChars.append(string)
       
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        guard let vnExpressInfo = VNExpressInfo(rawValue: elementName) else {
            foundChars = ""
            return
        }
        
        foundChars = foundChars.trimmingCharacters(in: .whitespacesAndNewlines)
        
        switch vnExpressInfo {
        case .item:
            listItem.append(ItemVNExpress(title: title, itemDescription: itemDescription, pubDate: pubDate, link: link, guid: guid, comments: comments))
        case .title:
            title = foundChars
        case .comments:
            comments = foundChars
        case .guid:
            guid = foundChars
        case .itemDescription:
            itemDescription = foundChars
        case .pubDate:
            pubDate = foundChars
        case .link:
            link = foundChars
        }
        
        foundChars = ""
    }
}
