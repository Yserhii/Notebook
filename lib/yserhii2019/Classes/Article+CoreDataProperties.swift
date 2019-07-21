//
//  Article+CoreDataProperties.swift
//  yserhii2019_Example
//
//  Created by Yolankyi SERHII on 7/4/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//
//

import CoreData
import Foundation

extension Article {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Article> {
        return NSFetchRequest<Article>(entityName: "Article")
    }

    @NSManaged public var title: String?
    @NSManaged public var content: String?
    @NSManaged public var language: String?
    @NSManaged public var image: NSData?
    @NSManaged public var creation_date: NSDate?
    @NSManaged public var modification_date: NSDate?
    
    override public var description: String {
        return "title: \(title ?? "error")\n content: \(content ?? "error")\n language: \(language ?? "error")\n image: \(image ?? NSData())\n creation date: \(creation_date ?? NSDate())\n modification date: \(modification_date ?? NSDate())\n"
    }
}
