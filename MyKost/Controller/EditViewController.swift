//
//  EditViewController.swift
//  MyKost
//
//  Created by Muhammad Farhan Almasyhur on 28/04/22.
//

import UIKit
import PhotosUI
import CoreData

class EditViewController: UIViewController {
    
    @IBOutlet weak var nameTextFieldOutlet: UITextField!
    @IBOutlet weak var tanggalMasukTextFieldOutlet: UITextField!
    @IBOutlet weak var hargaTextFieldOutlet: UITextField!
    
    @IBOutlet weak var inputKTPOutlet: UIButton!
    @IBOutlet weak var inputKontrakOutlet: UIButton!
    @IBOutlet weak var inputFotoOutlet: UIButton!
    @IBOutlet weak var submitOutlet: UIButton!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var checkButton = ""
    var kamar: Kamar?
    
    var newImageKTP: UIImage?
    var newImageKontrak: UIImage?
    var newImageProfile: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .done, target: self, action: #selector(self.backToDetail(_:)))
        inputKTPOutlet.addTarget(self, action: #selector(inputImageAction(_:)), for: .touchDown)
        inputKontrakOutlet.addTarget(self, action: #selector(inputImageAction(_:)), for: .touchDown)
        inputFotoOutlet.addTarget(self, action: #selector(inputImageAction(_:)), for: .touchDown)
        submitOutlet.addTarget(self, action: #selector(submitAction(_:)), for: .touchDown)
        
        if let kamarPenghuni = kamar {
            nameTextFieldOutlet.text = kamarPenghuni.penghuni?.nama!
            tanggalMasukTextFieldOutlet.text = dateToString((kamarPenghuni.penghuni?.tanggalMasuk!)!)
            hargaTextFieldOutlet.text = String(kamarPenghuni.penghuni?.harga ?? 0)
            newImageKTP = binaryDataToImage((kamarPenghuni.penghuni?.fotoKTP)!)
            newImageKontrak = binaryDataToImage((kamarPenghuni.penghuni?.fotoKontrak)!)
            newImageProfile = binaryDataToImage((kamarPenghuni.penghuni?.fotoProfil)!)
        }
        
        // Change Tanggal Outlet to DateInput
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(dateChange(datePicker:)), for: .valueChanged)
        datePicker.frame.size = CGSize(width: 0, height: 200)
        datePicker.preferredDatePickerStyle = .inline
        tanggalMasukTextFieldOutlet.inputView = datePicker
    }
    
    @objc func dateChange(datePicker: UIDatePicker){
        tanggalMasukTextFieldOutlet.text = dateToString(datePicker.date)
    }
    
    @objc func backToDetail(_ sender: UIButton){
        let alert = UIAlertController(title: "Apakah ingin kembali?", message: "Data yang dimasukkan akan kembali seperti semula", preferredStyle: .alert)
        let discard = UIAlertAction(title: "Kembali", style: .destructive) { UIAlertAction in
            self.navigationController?.popViewController(animated: true)
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(discard)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    @objc func inputImageAction(_ sender: UIButton){
        guard let buttonPressed = sender.titleLabel else { return }
        checkButton = buttonPressed.text ?? ""
        var photoConfig = PHPickerConfiguration()
        photoConfig.selectionLimit = 1
        photoConfig.filter = .images
        let photoVC = PHPickerViewController(configuration: photoConfig)
        photoVC.delegate = self
        present(photoVC, animated: true)
    }
    
    @objc func submitAction(_ sender: UIButton){
        guard let kamar = kamar else { return }

        
        let newPenghuni = Penghuni(context: context)
        newPenghuni.kamar = kamar
        newPenghuni.nama = nameTextFieldOutlet.text
        do {
            try newPenghuni.harga = Int32(hargaTextFieldOutlet.text ?? "0", format: .number)
        } catch {
            print("error changing harga to int")
        }
        
        newPenghuni.tanggalMasuk = stringToDate(tanggalMasukTextFieldOutlet.text ?? dateToString(Date.now))
        
        newPenghuni.fotoKTP = newImageKTP?.jpegData(compressionQuality: 0.15)
        newPenghuni.fotoKontrak = newImageKontrak?.jpegData(compressionQuality: 0.15)
        newPenghuni.fotoProfil = newImageProfile?.jpegData(compressionQuality: 0.15)
        
        saveToCoreData(newPenghuni)
        
        self.navigationController?.popToRootViewController(animated: true)
          
        
    }
    
    
    
    func binaryDataToImage(_ imageData: Data) -> UIImage {
        guard let encodedData = Data(base64Encoded: imageData) else { return UIImage(named: "defaultProfileImage")!}
        return UIImage(data: encodedData)!
    }
    
    
    
    func dateToString(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        return dateFormatter.string(from: date)
    }
    
    func stringToDate(_ string: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        return dateFormatter.date(from: string)!
    }
    
    func saveToCoreData(_ newPenghuni: Penghuni) {
        let kamarPenghuni: Kamar!

        let fetchPenghuni: NSFetchRequest<Kamar> = Kamar.fetchRequest()
        fetchPenghuni.predicate = NSPredicate(format: "noKamar == \(newPenghuni.kamar?.noKamar ?? 0)")

        let results = try? context.fetch(fetchPenghuni)

        if results?.count == 0 {
            kamarPenghuni = Kamar(context: context)
         } else {
            kamarPenghuni = results?.first
         }
        
        kamarPenghuni.penghuni = newPenghuni
        
        do {
            try context.save()
        } catch {
            print("error updating data")
        }
    }
    
    
    
}


extension EditViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        
        // Get the first item provider from the results
        let itemProvider = results.first?.itemProvider
        
        // Access the UIImage representation for the result
        if let itemProvider = itemProvider, itemProvider.canLoadObject(ofClass: UIImage.self) {
            itemProvider.loadObject(ofClass: UIImage.self) {  image, error in
                if let image = image {
                    if self.checkButton == "KTP"{
                        self.newImageKTP = image as? UIImage ?? UIImage(systemName: "person.fill")!
                    } else if self.checkButton == "Kontrak" {
                        self.newImageKontrak = image as? UIImage ?? UIImage(systemName: "person.fill")!
                    } else {
                        self.newImageProfile = image as? UIImage ?? UIImage(systemName: "person.fill")!
                        
                    }
                }
            }
        }
        
    }
    
    
}
