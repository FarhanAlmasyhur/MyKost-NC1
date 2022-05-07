//
//  ImageViewer.swift
//  MyKost
//
//  Created by Muhammad Farhan Almasyhur on 07/05/22.
//

import Foundation
import UIKit

class ImageViewer: UIView {
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setXib(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
    }
    
    func setXib(frame: CGRect){
        let view = loadXib()
        view.frame = frame
        addSubview(view)
    }
    
    func loadXib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "imageViewer", bundle: bundle)
        let view = nib.instantiate(withOwner: self).first as? UIView
        return view!
    }
    
    
}
