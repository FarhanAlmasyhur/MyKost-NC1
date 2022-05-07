//
//  Extension.swift
//  MyKost
//
//  Created by Muhammad Farhan Almasyhur on 28/04/22.
//

import Foundation
import UIKit

extension UIImageView {
    func roundedCorners(){
        self.layer.cornerRadius = 8.0
        self.layer.cornerCurve = .continuous
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
