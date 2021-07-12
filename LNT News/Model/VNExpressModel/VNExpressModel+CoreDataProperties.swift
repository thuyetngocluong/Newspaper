//
//  VNExpressModel+CoreDataProperties.swift
//  
//
//  Created by Luong Ngoc Thuyet on 09/07/2021.
//
//

import Foundation
import CoreData


extension VNExpressModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<VNExpressModel> {
        return NSFetchRequest<VNExpressModel>(entityName: "VNExpressModel")
    }

    @NSManaged public var title: String
    @NSManaged public var itemDescription: String
    @NSManaged public var pubDate: String
    @NSManaged public var link: String
    @NSManaged public var guid: String
    @NSManaged public var comments: String

}
