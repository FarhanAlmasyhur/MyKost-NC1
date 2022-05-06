//
//  Penghuni+CoreDataProperties.swift
//  MyKost
//
//  Created by Muhammad Farhan Almasyhur on 06/05/22.
//
//

import Foundation
import CoreData


extension Penghuni {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Penghuni> {
        return NSFetchRequest<Penghuni>(entityName: "Penghuni")
    }

    @NSManaged public var nama: String?
    @NSManaged public var tanggalMasuk: Date?
    @NSManaged public var harga: Int32
    @NSManaged public var fotoProfil: Data?
    @NSManaged public var fotoKTP: Data?
    @NSManaged public var fotoKontrak: Data?
    @NSManaged public var kamar: Kamar?

}

extension Penghuni : Identifiable {

}
