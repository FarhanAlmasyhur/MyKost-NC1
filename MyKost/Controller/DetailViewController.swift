//
//  DetailViewController.swift
//  MyKost
//
//  Created by Muhammad Farhan Almasyhur on 27/04/22.
//

import UIKit

class DetailViewController: UIViewController {
    
    
    
    
    @IBOutlet weak var imageOutlet: UIImageView!
    @IBOutlet weak var tableViewOutlet: UITableView!
    @IBOutlet weak var ktpButtonOutlet: UIButton!
    @IBOutlet weak var kontrakButtonOutlet: UIButton!
    
    let titleArray = ["Nama", "Tanggal Masuk", "Harga"]
    var detailArray: [String] = []
    var kamarPenghuni: Kamar?
    var imageViewer: ImageViewer!
    
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
        
        ktpButtonOutlet.addTarget(self, action: #selector(imageButtonAction(_:)), for: .touchDown)
        kontrakButtonOutlet.addTarget(self, action: #selector(imageButtonAction(_:)), for: .touchDown)
    }
    
    @objc func imageButtonAction(_ sender: UIButton){
        self.imageViewer = ImageViewer(frame: self.view.frame)
        self.imageViewer.closeButtonOutlet.addTarget(self, action: #selector(closeButtonAction), for: .touchDown)
        
        guard let buttonTitle = sender.titleLabel else { return }
        if buttonTitle.text == "KTP" {
            self.imageViewer.imageViewOutlet.image = UIImage(data: (kamarPenghuni?.penghuni?.fotoKTP)!)
        } else {
            self.imageViewer.imageViewOutlet.image = UIImage(data: (kamarPenghuni?.penghuni?.fotoKontrak)!)
        }
        
        self.view.addSubview(imageViewer)
    }
    
    @objc func closeButtonAction(){
        self.imageViewer.removeFromSuperview()
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
