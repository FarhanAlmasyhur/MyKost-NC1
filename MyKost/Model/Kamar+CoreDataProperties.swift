//
//  Kamar+CoreDataProperties.swift
//  MyKost
//
//  Created by Muhammad Farhan Almasyhur on 06/05/22.
//
//

import Foundation
import CoreData


extension Kamar {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Kamar> {
        return NSFetchRequest<Kamar>(entityName: "Kamar")
    }

    @NSManaged public var noKamar: Int16
    @NSManaged public var penghuni: Penghuni?

}

extension Kamar : Identifiable {

}
