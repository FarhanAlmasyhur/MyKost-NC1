//
//  EditViewController.swift
//  MyKost
//
//  Created by Muhammad Farhan Almasyhur on 28/04/22.
//

import UIKit
import PhotosUI

class EditViewController: UIViewController {
    
    @IBOutlet weak var nameTextFieldOutlet: UITextField!
    @IBOutlet weak var tanggalMasukTextFieldOutlet: UITextField!
    @IBOutlet weak var hargaTextFieldOutlet: UITextField!
    
    @IBOutlet weak var inputKTPOutlet: UIButton!
    @IBOutlet weak var inputKontrakOutlet: UIButton!
    @IBOutlet weak var inputFotoOutlet: UIButton!
    @IBOutlet weak var submitOutlet: UIButton!
    
    var checkButton = ""
    var kamar: Kamar?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .done, target: self, action: #selector(self.backToDetail(_:)))
        inputKTPOutlet.addTarget(self, action: #selector(inputAction(_:)), for: .touchDown)
        inputKontrakOutlet.addTarget(self, action: #selector(inputAction(_:)), for: .touchDown)
        inputFotoOutlet.addTarget(self, action: #selector(inputAction(_:)), for: .touchDown)
        
        if let kamarPenghuni = kamar {
            nameTextFieldOutlet.text = kamarPenghuni.penghuni.nama
            tanggalMasukTextFieldOutlet.text = dateToString(kamarPenghuni.penghuni.tanggalMasuk)
            hargaTextFieldOutlet.text = String(kamarPenghuni.penghuni.harga)
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
    
    func dateToString(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        return dateFormatter.string(from: date)
    }
    
    @objc func inputAction(_ sender: UIButton){
        guard let buttonPressed = sender.titleLabel else { return }
        checkButton = buttonPressed.text ?? ""
        var photoConfig = PHPickerConfiguration()
        photoConfig.selectionLimit = 1
        photoConfig.filter = .images
        let photoVC = PHPickerViewController(configuration: photoConfig)
        photoVC.delegate = self
        present(photoVC, animated: true)
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
                        kamar?.penghuni.fotoKTP = image as! UIImage
                    } else if self.checkButton == "Kontrak" {
                        
                    } else {
                        
                    }
                }
            }
        }
        
    }
    
    
}
