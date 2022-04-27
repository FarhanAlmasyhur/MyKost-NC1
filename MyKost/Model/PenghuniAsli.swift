//
//  PenghuniAsli.swift
//  MyKost
//
//  Created by Muhammad Farhan Almasyhur on 27/04/22.
//

import Foundation


struct PenghuniAsli: Penghuni {
    let nama: String
    let tanggalLahir: Date
    let tanggalMasuk: Date
    let harga: Int64
    
    init(nama: String, tanggalLahir: Date, tanggalMasuk: Date, harga: Int64) {
        self.nama = nama
        self.tanggalLahir = tanggalLahir
        self.tanggalMasuk = tanggalMasuk
        self.harga = harga
    }
}
