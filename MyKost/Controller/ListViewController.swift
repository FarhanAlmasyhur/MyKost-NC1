//
//  ViewController.swift
//  MyKost
//
//  Created by Muhammad Farhan Almasyhur on 27/04/22.
//

import UIKit

class ListViewController: UIViewController {
    
    @IBOutlet weak var tableViewOutlet: UITableView!
    
    
    var listKamarBawah: [Kamar] = []
    var listKamarAtas: [Kamar] = []

    
    override func viewWillAppear(_ animated: Bool) {
        // TO:DO Read List from Core Data
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Check if there is no data in Database
        if listKamarBawah.isEmpty{
            for i in 0...5{
                listKamarBawah.append(Kamar(noKamar: i))
            }
        }
        if listKamarAtas.isEmpty{
            for i in 6...11{
                listKamarAtas.append(Kamar(noKamar: i))
            }
        }
        
        
        
        // Do any additional setup after loading the view.
        
        
        tableViewOutlet.dataSource = self
        tableViewOutlet.delegate = self
    }

    
    
}

extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listKamarAtas.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PenyewaCell", for: indexPath)
        var cellContent = cell.defaultContentConfiguration()
        if indexPath.section == 0 {
            cellContent.text = "Kamar No. \(listKamarBawah[indexPath.row].noKamar)"
        } else {
            cellContent.text = "Kamar No. \(listKamarAtas[indexPath.row].noKamar)"
        }
        cell.contentConfiguration = cellContent
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
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "detailView") as? DetailViewController else {return}
        if indexPath.section == 0 {
            vc.title = "Kamar No. \(listKamarBawah[indexPath.row].noKamar)"
            vc.kamarPenghuni = listKamarBawah[indexPath.row]
            
        } else {
            vc.title = "Kamar No. \(listKamarAtas[indexPath.row].noKamar)"
            vc.kamarPenghuni = listKamarAtas[indexPath.row]
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
