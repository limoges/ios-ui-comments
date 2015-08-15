//
//  LCImageView.swift
//  Comments
//
//  Created by Julien Limoges on 2015-08-14.
//  Copyright (c) 2015 limoges.co. All rights reserved.
//

import UIKit

class LCImageView: UIView {
    
    private var imageView: UIImageView = UIImageView()
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable var image: UIImage? {
        get {
            return self.imageView.image
        }
        set {
            self.imageView.image = newValue
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        self.after()
    }
    
    override func awakeFromNib() {
        
        self.after()
    }
    
    private func after() {
        
        // Do additional setup initialization
        
    }
    
}
