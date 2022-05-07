//
//  DetailViewController.swift
//  MyKost
//
//  Created by Muhammad Farhan Almasyhur on 27/04/22.
//

import UIKit

class DetailViewController: UIViewController {
    
    
    var kamarPenghuni: Kamar?
    
    @IBOutlet weak var imageOutlet: UIImageView!
    @IBOutlet weak var tableViewOutlet: UITableView!
    
    let titleArray = ["Nama", "Tanggal Masuk", "Harga"]
    var detailArray: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageOutlet.roundedCorners()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editDetail))
        if let kamarPenghuniObject = kamarPenghuni {
            
            imageOutlet.image = UIImage(data: (kamarPenghuniObject.penghuni?.fotoProfil!)!)
            
            detailArray.append(kamarPenghuniObject.penghuni!.nama!)
            detailArray.append(formatDate(kamarPenghuniObject.penghuni!.tanggalMasuk!))
            detailArray.append(changePriceToCurrency(kamarPenghuniObject.penghuni!.harga))
        }
        tableViewOutlet.dataSource = self
    }

                               
    func changePriceToCurrency(_ price: Int32) -> String {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "id_ID")
        formatter.numberStyle = .currency
        return formatter.string(from: NSNumber(value: price)) ?? "0"
    }
    
    func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        return formatter.string(from: date)
    }
    
    @objc func editDetail() {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "editView") as? EditViewController else { return }
        vc.kamar = kamarPenghuni
        self.navigationController?.pushViewController(vc, animated: true)
        
    }

}

extension DetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell", for: indexPath)
        var cellContent = cell.defaultContentConfiguration()
        cellContent.text = titleArray[indexPath.row]
        cellContent.secondaryText = String(describing: detailArray[indexPath.row])
        cell.contentConfiguration = cellContent
        
        return cell
    }
    
}
