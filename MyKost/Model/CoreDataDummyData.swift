//
//  CoreDataDummyData.swift
//  MyKost
//
//  Created by Muhammad Farhan Almasyhur on 06/05/22.
//

import Foundation
import UIKit
import CoreData


func saveDummyData(){
    let appDel:AppDelegate = UIApplication.shared.delegate as! AppDelegate
    let context:NSManagedObjectContext = appDel.persistentContainer.viewContext
    
    for i in 0...15{
        dummyData(noKamar: Int16(i))
    }
    
    do{
        try context.save()
        UserDefaults.standard.set(true, forKey: "dummyDataAdded")
        UserDefaults.standard.synchronize()
    } catch _ {
        print("error adding dummy data")
        
    }
    
    
    
    
}

func dummyData(noKamar: Int16){
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let kamar = NSEntityDescription.insertNewObject(forEntityName: "Kamar", into: context) as! Kamar
    kamar.noKamar = noKamar
    let newPenghuni = Penghuni(context: context)
    
    newPenghuni.nama = "Farhan"
    newPenghuni.tanggalMasuk = Date.now
    newPenghuni.harga = 25000000
    
    if let profilImage = UIImage(named: "defaultProfileImage") {
        newPenghuni.fotoProfil = profilImage.jpegData(compressionQuality: 0.15)
    }
    
    if let ktpImage = UIImage(named: "defaultKTPImage"){
        newPenghuni.fotoKTP = ktpImage.jpegData(compressionQuality: 0.15)
    }
    
    if let kontrakImage = UIImage(named: "defaultKontrakImage"){
        newPenghuni.fotoKontrak = kontrakImage.jpegData(compressionQuality: 0.15)
    }
    
    newPenghuni.kamar = kamar
    
    kamar.penghuni = newPenghuni
    
}
