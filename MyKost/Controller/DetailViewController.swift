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
    
    @IBOutlet weak var closeButtonOutlet: UIButton!
    @IBOutlet weak var detailImageOutlet: UIImageView!
    
    @IBOutlet weak var blurViewOutlet: UIVisualEffectView!
    @IBOutlet var popUpImage: UIView!
    
    
    let titleArray = ["Nama", "Tanggal Masuk", "Harga"]
    var detailArray: [String] = []
    var kamarPenghuni: Kamar?
    
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
        closeButtonOutlet.addTarget(self, action: #selector(closeButtonAction), for: .touchDown)
        
        blurViewOutlet.bounds = self.view.bounds
        popUpImage.bounds = CGRect(x: 0, y: 0, width: self.view.bounds.width * 0.9, height: self.view.bounds.height * 0.4)
        
        
    }
    
    @objc func imageButtonAction(_ sender: UIButton){
        if sender.titleLabel?.text == "KTP" {
            detailImageOutlet.image = UIImage(data: (kamarPenghuni?.penghuni?.fotoKTP)!)
        } else {
            detailImageOutlet.image = UIImage(data: (kamarPenghuni?.penghuni?.fotoKontrak)!)
        }
        animatePopUp(desiredView: blurViewOutlet)
        animatePopUp(desiredView: popUpImage)
    }
    
    @objc func closeButtonAction(){
        animateClose(desiredView: popUpImage)
        animateClose(desiredView: blurViewOutlet)
    }
    
    func animatePopUp(desiredView: UIView){
        let bg = self.view!
        bg.addSubview(desiredView)
        desiredView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        desiredView.alpha = 0
        desiredView.center = bg.center
        UIView.animate(withDuration: 0.3, animations: {
            desiredView.transform = CGAffineTransform(scaleX: 1, y: 1)
            desiredView.alpha = 1
        })
    }
    
    func animateClose(desiredView: UIView){
        UIView.animate(withDuration: 0.3, animations: {
            desiredView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            desiredView.alpha = 0
            
        }, completion: { _ in
            desiredView.removeFromSuperview()
        })
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
