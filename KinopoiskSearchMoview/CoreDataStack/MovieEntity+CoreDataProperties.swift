//
//  MovieEntity+CoreDataProperties.swift
//  KinopoiskSearchMoview
//
//  Created by Константин Малков on 01.11.2022.
//
//

import Foundation
import CoreData


extension MovieEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MovieEntity> {
        return NSFetchRequest<MovieEntity>(entityName: "MovieEntity")
    }

    @NSManaged public var date: Date?
    @NSManaged public var image: Data?
    @NSManaged public var title: String
    @NSManaged public var type: String?
    @NSManaged public var url: String?
    @NSManaged public var year: String?
    @NSManaged public var rating: String?
    @NSManaged public var runtime: String?
    @NSManaged public var imdbLink: String



}

extension MovieEntity : Identifiable {

}
