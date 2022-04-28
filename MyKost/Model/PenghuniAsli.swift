//
//  PenghuniAsli.swift
//  MyKost
//
//  Created by Muhammad Farhan Almasyhur on 27/04/22.
//

import Foundation
import UIKit


struct PenghuniAsli: Penghuni {
    let nama: String
    let tanggalLahir: Date
    let tanggalMasuk: Date
    let harga: Int32
    let fotoProfil: UIImage
    
    
    init(nama: String, tanggalLahir: Date, tanggalMasuk: Date, harga: Int32, fotoProfil: UIImage) {
        self.nama = nama
        self.tanggalLahir = tanggalLahir
        self.tanggalMasuk = tanggalMasuk
        self.harga = harga
        self.fotoProfil = fotoProfil
    }
}
