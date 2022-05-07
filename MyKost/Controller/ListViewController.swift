//
//  ViewController.swift
//  MyKost
//
//  Created by Muhammad Farhan Almasyhur on 27/04/22.
//

import UIKit
import CoreData

class ListViewController: UIViewController {
    
    @IBOutlet weak var tableViewOutlet: UITableView!
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var listKamar: [Kamar]?
    
    var listKamarBawah: [Kamar] = []
    var listKamarAtas: [Kamar] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Check dummy data, if there is none, create it
        if UserDefaults.standard.bool(forKey: "dummyDataAdded") == false {
            saveDummyData()
        }
        
        // read from database
        fetchData()
        
        guard let listKamar = listKamar else {
            return
        }

        for kamar in listKamar {
            if(kamar.noKamar <= 5){
                listKamarBawah.append(kamar)
            } else {
                listKamarAtas.append(kamar)
            }
        }
        
        tableViewOutlet.dataSource = self
        tableViewOutlet.delegate = self
        tableViewOutlet.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        fetchData()
        tableViewOutlet.reloadData()
    }
    
    func fetchData(){
        do{
            let request = Kamar.fetchRequest() as NSFetchRequest<Kamar>
            
            // sort by no.kamar
            let sort = NSSortDescriptor(key: "noKamar", ascending: true)
            
            request.sortDescriptors = [sort]
            
            self.listKamar = try context.fetch(request)
            DispatchQueue.main.async {
                self.tableViewOutlet.reloadData()
            }
        } catch {
            print("Error fetching data")
        }
        
    }

    
    
}

extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return listKamarBawah.count
        } else {
            return listKamarAtas.count
        }
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
