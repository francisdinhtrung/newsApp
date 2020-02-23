//
//  UIImageView+Ext.swift
//  News
//
//  Created by Trung Vu on 2/7/20.
//  Copyright © 2020 Trung Vu. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {
    
    func loadImage(
        URL: URL,
        placeholderImage: Image?,
        contentMode: UIView.ContentMode = .scaleAspectFit,
        completion: ((_ image: Image?, _ error: NSError?) -> ())?) {
        
        self.contentMode = contentMode
        self.clipsToBounds = true
        self.kf.setImage(with: URL, placeholder: placeholderImage, options: nil, progressBlock: nil) { (image, error, cacheType, url) in
            if let callback = completion {
                callback(image, error)
            }
        }
    }
}
