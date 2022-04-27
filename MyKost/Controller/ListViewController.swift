//
//  ViewController.swift
//  MyKost
//
//  Created by Muhammad Farhan Almasyhur on 27/04/22.
//

import UIKit

class ListViewController: UIViewController {
    
    @IBOutlet weak var tableViewOutlet: UITableView!
    
    
    var listKamar: [Penyewa] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        listKamar.append(Penyewa(nama: "Farhan", tanggalLahir: Date.now, tanggalMasuk: Date.now, harga: 8000000, nomorKamar: 0))
        listKamar.append(Penyewa(nama: "Farhan", tanggalLahir: Date.now, tanggalMasuk: Date.now, harga: 5000000, nomorKamar: 1))
        listKamar.append(Penyewa(nama: "Farhan", tanggalLahir: Date.now, tanggalMasuk: Date.now, harga: 6000000, nomorKamar: 2))
        // Do any additional setup after loading the view.
        
        
        tableViewOutlet.dataSource = self
        tableViewOutlet.delegate = self
    }

    
    
}

extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listKamar.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PenyewaCell", for: indexPath)
        cell.textLabel?.text = "Kamar No.\(listKamar[indexPath.row].nomorKamar)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Kamar Bawah"
        }else{
            return "Kamar Atas"
        }
        
    }
    
}


extension ListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
