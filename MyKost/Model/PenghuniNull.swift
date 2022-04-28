//
//  PenghuniNull.swift
//  MyKost
//
//  Created by Muhammad Farhan Almasyhur on 27/04/22.
//

import Foundation
import UIKit

struct PenghuniNull: Penghuni{
    let nama: String = "Farhan"
    let tanggalLahir: Date = Date.now
    let tanggalMasuk: Date = Date.now
    let harga: Int32 = 25000000
    let fotoProfil: UIImage = UIImage(named: "defaultProfileImage") ?? UIImage(systemName: "person.crop.rectangle")!
}
