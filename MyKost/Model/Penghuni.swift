//
//  Penyewa.swift
//  MyKost
//
//  Created by Muhammad Farhan Almasyhur on 27/04/22.
//

import Foundation
import UIKit

protocol Penghuni {
    var nama: String { get }
    var tanggalLahir: Date { get }
    var tanggalMasuk: Date { get }
    var harga: Int32 { get }
    var fotoProfil: UIImage { get }
//    var fotoKTP: UIImage
//    var fotoKontrak: UIImage
}

