//
//  VNExpressXMLModel.swift
//  NewspaperOnline
//
//  Created by Luong Ngoc Thuyet on 7/2/21.
//  Copyright © 2021 thuyetln. All rights reserved.
//

import Foundation

enum VNExpressInfo : String {
    case item = "item"
    case title = "title"
    case itemDescription = "description"
    case pubDate = "pubDate"
    case link = "link"
    case guid = "guid"
    case comments = "slash:comments"
}

// MARK: - ItemVNExpress
class ItemVNExpress {
    let title, itemDescription, pubDate: String
    let link, guid: String
    let comments: String
    
    init(title: String, itemDescription: String, pubDate: String, link: String, guid: String, comments: String) {
        self.title = title
        self.itemDescription = itemDescription
        self.pubDate = pubDate
        self.link = link
        self.guid = guid
        self.comments = comments
    }
}


